//
//  CreateModel.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import Foundation
import RealmSwift

class CreateModel {
    static func createTask(title: String, memo: String) {
        if let realm = try? Realm() {
            let task = Task()
            task.add(title: title, memo: memo)
            try? realm.write {
                realm.add(task)
                print("success")
            }
        }
    }
}
