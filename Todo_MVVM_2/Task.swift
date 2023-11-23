//
//  Task.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var title: String?
    @objc dynamic var memo: String?
    
    func add(title: String, memo: String) {
        self.title = title
        self.memo = memo
    }
}
