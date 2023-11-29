//
//  CreateViewController.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit
import RxCocoa
import RxSwift
import KRProgressHUD

class CreateViewController: UIViewController {
    
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var memoTextView: UITextView!
    
    private let createViewModel = CreateViewModel()
    // 講読解除するゴミ箱的な役割("https://qiita.com/ta9yamakawa/items/0580799542a1f518a53f")
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ここでバインディングする
        bindInput()
        bindOutput()
    }
    
    // 入力に関するバインディング(UIからの入力をViewModelに伝達)
    private func bindInput() {
        // 保存ボタンがタップされたらtextをタプルで渡す
        createButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if let titleText = self.titleTextField.text,
               let memoText = self.memoTextView.text {
                let textDataTuple = (titleText, memoText)
                self.createViewModel.input.createButtonTap_Rx.accept(textDataTuple)
            }
        }).disposed(by: disposeBag)
    }
    
    // 出力に関するバインディング(ViewModelから来た値をUIに表示)
    private func bindOutput() {
        // 保存されたら完了のKRで前の画面に戻る
        createViewModel.output.createCompleted_Rx
            .subscribe(onNext: {
                KRProgressHUD.showSuccess(withMessage: "保存に成功しました")
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

}
