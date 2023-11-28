//
//  CreateViewModel.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import Foundation
import RxSwift
import RxCocoa

// protocolでinputとoutputを定義しておく(入力なのか出力なのか分かりやすくするため)
protocol CreateViewModelInput {
    var createButtonTap_Rx: PublishRelay<(String, String)> { get }
}

protocol CreateViewModelOutput {
    var createCompleted_Rx: PublishRelay<Void> { get }
}

protocol CreateViewModelType {
    var input: CreateViewModelInput { get }
    var output: CreateViewModelOutput { get }
}

class CreateViewModel: CreateViewModelInput, CreateViewModelOutput, CreateViewModelType {
    
    var input: CreateViewModelInput { return self }
    var output: CreateViewModelOutput { return self }
    
    // input(入力されたデータを受け取る
    let createButtonTap_Rx = PublishRelay<(String, String)>()
    
    // output(UIに表示したいものを出力)
    let createCompleted_Rx = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        // initでバインディング
        bind()
    }
    
    private func bind() {
        // 保存ボタンタップを感知したら、createTaskを実行する
        createButtonTap_Rx
            .subscribe(onNext: { textDataTuple in
                self.createTask(title: textDataTuple.0, memo: textDataTuple.1)
                // 保存したら、Viewに向けて出力する
                
            })
            .disposed(by: disposeBag)
    }
    
    private func createTask(title: String, memo: String) {
        if title == "" || memo == "" {
            // 入力してね〜ってKRHudを出したい（Viewの仕事かな）
            return
        }
        CreateModel.createTask(title: title, memo: memo)
    }
    
}

