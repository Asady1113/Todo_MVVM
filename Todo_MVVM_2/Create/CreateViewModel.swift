//
//  CreateViewModel.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class CreateViewModel {
    
    // input(ボタンのタップを検知する)
    
    // output(UIに表示したいものを出力)

    
    private let disposeBag = DisposeBag()
    
    init() {
        // initでバインディング
        bind()
    }
    
    private func bind() {
        // 保存が完了したら、Viewに向けて出力する
        
    }
    
    func createTask(title: String, memo: String) {
        if title == "" || memo == "" {
            // 入力してね〜ってKRHudを出したい（Viewの仕事かな）
            return
        }
        CreateModel.createTask(title: title, memo: memo)
    }
    
}

