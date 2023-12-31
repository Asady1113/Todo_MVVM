//
//  CreateViewController.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit
import RxCocoa
import RxSwift

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
        // 保存ボタンがタップされたら
        createButton.rx.tap.subscribe(onNext: {
            self.createViewModel.createTask(title: self.titleTextField.text ?? "", memo: self.memoTextView.text ?? "")
        }).disposed(by: disposeBag)

    }
    
    // 出力に関するバインディング(ViewModelから来た値をUIに表示)
    private func bindOutput() {
        
    }

}
