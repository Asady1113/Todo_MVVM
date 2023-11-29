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
    
    // 入力に関するバインディング(UIからの入力をViewModelに伝達)
    private func bindInput() {
        // Appear時にデータを読み込む
        rx.methodInvoked(#selector(UIViewController.viewWillAppear))
            .subscribe(onNext: { _ in
                self.mainViewModel.input.viewWillAppear_Rx.accept(())
            })
            .disposed(by: disposeBag)
        
        // セルがタップされたら、ViewModelにindexPathを渡す
        memoTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainViewModel.input.cellDidTap_Rx.accept(indexPath)
            })
            .disposed(by: disposeBag)
    }
    
    // 出力に関するバインディング(ViewModelから来た値をUIに表示)
    private func bindOutput() {
        // 読み込みが完了したらTableViewをリロード
        mainViewModel.output.readCompleted_Rx
            .subscribe(onNext: {
                self.memoTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // ViewModelから選択された要素を受け取って画面遷移
        mainViewModel.output.selectedTask_Rx
            .subscribe(onNext: { [weak self] Task in
                self?.toDetail(selectedTask: Task)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func toCreate() {
        Router.shared.showCreate(from: self)
    }
    
    private func toDetail(selectedTask: Task) {
        // 値わたし（Routerに書くべきな気もする）
        let vc = UIStoryboard.detailViewController
        vc.setSelectedTask(selectedTask: selectedTask)
        Router.shared.showDetail(from: self)
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



