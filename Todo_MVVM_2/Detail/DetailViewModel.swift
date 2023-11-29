//
//  DetailViewModl.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/29.
//

import Foundation
import RxSwift
import RxCocoa

// protocolでinputとoutputを定義しておく(入力なのか出力なのか分かりやすくするため)
protocol DetailViewModelInput {
    var updateButtonTap_Rx: PublishRelay<(Task,String,String)> { get }
    var deleteButtonTap_Rx: PublishRelay<Task> { get }
}

protocol DetailViewModelOutput {
    var updateCompleted_Rx: PublishRelay<Void> { get }
    var deleteCompleted_Rx: PublishRelay<Void> { get }
}

protocol DetailViewModelType {
    var input: DetailViewModelInput { get }
    var output: DetailViewModelOutput { get }
}

class DetailViewModel: DetailViewModelInput, DetailViewModelOutput, DetailViewModelType {
    
    var input: DetailViewModelInput { return self }
    var output: DetailViewModelOutput { return self }
    
    // input(入力されたデータを受け取る
    let updateButtonTap_Rx = PublishRelay<(Task,String,String)>() // 更新ボタンを検知し、タスクを受け取る
    let deleteButtonTap_Rx = PublishRelay<Task>() // 削除ボタンを検知し、タスクを受け取る
    
    // output(UIに表示したいものを出力)
    let updateCompleted_Rx = PublishRelay<Void>() // 更新完了を伝達する
    let deleteCompleted_Rx = PublishRelay<Void>() // 削除完了を伝達する
    
    private let disposeBag = DisposeBag()
    
    init() {
        // initでバインディング
        bind()
    }
    
    private func bind() {
        // 更新ボタンを検知したら、updateTaskを実行する
        updateButtonTap_Rx
            .subscribe(onNext: { updateDataTupple in
                self.updateTask(selectedTask: updateDataTupple.0, newTitle: updateDataTupple.1, newMemo: updateDataTupple.2)
                // 更新したら、Viewに向けて出力する
                self.output.updateCompleted_Rx.accept(())
            })
            .disposed(by: disposeBag)
        
        // 削除ボタンを検知したら、deleteTaskを実行する
        deleteButtonTap_Rx
            .subscribe(onNext: { selectedTask in
                self.deleteTask(selectedTask: selectedTask)
                // 削除したら、Viewに向けて出力する
                self.output.deleteCompleted_Rx.accept(())
            })
            .disposed(by: disposeBag)
    }
    
    private func updateTask(selectedTask: Task, newTitle: String, newMemo: String) {
        if newTitle == "" || newMemo == "" {
            // 入力してね〜ってKRHudを出したい（Viewの仕事かな）
            return
        } else if let id = selectedTask.id {
            DetailModel.updateTask(id: id, newTitle: newTitle, newMemo: newMemo)
        }
    }
    
    private func deleteTask(selectedTask: Task) {
        print("削除します！")
    }
    
}
