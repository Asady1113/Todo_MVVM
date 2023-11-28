//
//  MainViewModel.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//


import Foundation
import RxSwift
import RxCocoa

// protocolでinputとoutputを定義しておく(入力なのか出力なのか分かりやすくするため)
protocol MainViewModelInput {
    var cellDidTap_Rx: PublishRelay<IndexPath> { get }
}

protocol MainViewModelOutput {
    var selectedTask_Rx: PublishRelay<Task> { get }
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelInput, MainViewModelOutput, MainViewModelType {
    
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    // input
    let cellDidTap_Rx = PublishRelay<IndexPath>()  // タップされたtableViewCellのindexPath
    
    // output(UIに表示したいものを出力)
    let selectedTask_Rx = PublishRelay<Task>()  // 選択されたTask
    
    private let disposeBag = DisposeBag()
    // TodoList
    private var taskArr = [Task]()
    
    init() {
        // initでバインディング
        bind()
    }
    
    private func bind() {
        // cellタップを検知すると、選択されているindexPath.row番目の要素を渡す
        cellDidTap_Rx
            .subscribe(onNext: { indexPath in
                let selectedTask = self.taskArr[indexPath.row]
                // outputのselectedTaskに値を流す
                self.output.selectedTask_Rx.accept(selectedTask)
            })
            .disposed(by: disposeBag)
    }
    
    // 関数はprivateにした方がいい
    // todoの読み込み
    func readTask() {
        taskArr = [Task]()
        taskArr = MainModel.readTask()
    }
    // tableViewCellの数
    func getCellCount() -> Int {
        return taskArr.count
    }
    // tableViewCellの中身
    func getCell(tableView: UITableView, indexPath: IndexPath) -> (cell: UITableViewCell, title: String) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            fatalError()
        }
        let taskTitle = taskArr[indexPath.row].title
        return (cell, taskTitle ?? "")
    }
}

