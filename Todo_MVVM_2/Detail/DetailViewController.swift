//
//  DetailViewController.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var selectedTask = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedTask)
    }
    
    func setSelectedTask(selectedTask: Task) {
        self.selectedTask = selectedTask
    }

}

