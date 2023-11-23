//
//  MainViewController.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet private weak var memoTableView: UITableView!
    
    private let mainViewModel = MainViewModel()
    // 講読解除するゴミ箱的な役割("https://qiita.com/ta9yamakawa/items/0580799542a1f518a53f")
    // いったんおまじないだと思います
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // ここでバインディングする
        bindInput()
        bindOutput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Appear時にデータを読み込む（Viewdidloadでもいい）
        mainViewModel.readTask()
    }
    
    // 入力に関するバインディング(UIからの入力をViewModelに伝達)
    private func bindInput() {
        // セルがタップされたら、ViewModelにindexPathを渡す
        memoTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainViewModel.input.cellDidTap_Rx.accept(indexPath)
            })
            .disposed(by: disposeBag)
    }
    
    // 出力に関するバインディング(ViewModelから来た値をUIに表示)
    private func bindOutput() {
        // ViewModelから選択された要素を受け取って画面遷移
        mainViewModel.output.selectedTask
            .subscribe(onNext: { [weak self] Task in
                self?.toDetail(selectedTask: Task)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func toCreate() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Create", bundle: Bundle.main)
        if let createViewController = storyboard.instantiateViewController(withIdentifier: "CreateViewController") as? CreateViewController {
            self.present(createViewController, animated: true, completion: nil)
        }
    }
    
    private func toDetail(selectedTask: Task) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: Bundle.main)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.setSelectedTask(selectedTask: selectedTask)
            self.present(detailViewController, animated: true, completion: nil)
        }
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セル数取得
        return mainViewModel.getCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セル内容取得
        let result = mainViewModel.getCell(tableView: tableView, indexPath: indexPath)
        let cell = result.cell
        let title = result.title
        
        // カスタムセルの方がいいかも
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = title
        }
        return cell
    }
}



