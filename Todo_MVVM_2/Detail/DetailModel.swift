//
//  DetailModel.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/29.
//

import Foundation
import RealmSwift

class DetailModel {
    // 更新の関数
    static func updateTask(id: String, newTitle: String, newMemo: String) {
        if let realm = try? Realm() {
            let selectedTask = realm.objects(Task.self).filter("id == %@", id).first
            try? realm.write {
                selectedTask?.title = newTitle
                selectedTask?.memo = newMemo
                print("success")
            }
        }
    }
    
}
