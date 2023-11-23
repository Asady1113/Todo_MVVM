//
//  StoryBoard+.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit

// Storyboardの読み込みを１箇所にまとめる
extension UIStoryboard {
    static var mainViewController: MainViewController {
        UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
    }
    
    static var createViewController: CreateViewController {
        UIStoryboard.init(name: "Create", bundle: nil).instantiateInitialViewController() as! CreateViewController
    }
    
    static var detailViewController: DetailViewController {
        UIStoryboard.init(name: "Detail", bundle: nil).instantiateInitialViewController() as! DetailViewController
    }
}
