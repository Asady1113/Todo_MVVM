//
//  DetailViewController.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit
import RxCocoa
import RxSwift
import KRProgressHUD

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var memoTextView: UITextView!
    
    private var selectedTask = Task()
    
    private let detailViewModel = DetailViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displaySelectedTask()
        // ここでバインディングする
        bindInput()
        bindOutput()
    }
    
    func setSelectedTask(selectedTask: Task) {
        self.selectedTask = selectedTask
    }
    
    private func displaySelectedTask() {
        titleTextField.text = selectedTask.title
        memoTextView.text = selectedTask.memo
    }
    
    // 入力に関するバインディング(UIからの入力をViewModelに伝達)
    private func bindInput() {
        // 更新ボタンがタップされたら、タスクを渡す
        updateButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if let titleText = self.titleTextField.text,
                   let memoText = self.memoTextView.text {
                    let updateDataTupple = (self.selectedTask, titleText, memoText)
                    self.detailViewModel.input.updateButtonTap_Rx.accept(updateDataTupple)
                }
            })
            .disposed(by: disposeBag)
        
        // 削除ボタンがタップされたら、タスクを渡す
        deleteButton.rx.tap
            .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.detailViewModel.input.deleteButtonTap_Rx.accept(self.selectedTask)
        })
            .disposed(by: disposeBag)
    }
    
    // 出力に関するバインディング(ViewModelから来た値をUIに表示)
    private func bindOutput() {
        // 更新が完了したら、KRを表示して前の画面に戻る
        detailViewModel.output.updateCompleted_Rx
            .subscribe(onNext: {
                KRProgressHUD.showSuccess(withMessage: "更新に成功しました")
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        // 削除が完了したら、KRを表示して前の画面に戻る
        detailViewModel.output.deleteCompleted_Rx
            .subscribe(onNext: {
                KRProgressHUD.showSuccess(withMessage: "削除に成功しました")
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

}

