//
//  MainModel.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import RealmSwift

class MainModel {
    static func readTask() -> [Task] {
        var result = [Task]()
        if let realm = try? Realm() {
            let object = realm.objects(Task.self)
            result = Array(object)
        }
        return result
    }
}

