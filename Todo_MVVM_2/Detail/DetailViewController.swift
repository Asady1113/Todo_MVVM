//
//  DetailViewController.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit
import RxCocoa
import RxSwift

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
    
    // 入力に関するバインディング(UIからの入力をViewModelに伝達)
    private func bindInput() {
        
    }
    
    // 出力に関するバインディング(ViewModelから来た値をUIに表示)
    private func bindOutput() {
        
    }
    
    private func displaySelectedTask() {
        titleTextField.text = selectedTask.title
        titleTextField.text = selectedTask.memo
    }

}

