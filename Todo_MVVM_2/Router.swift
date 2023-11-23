//
//  Router.swift
//  Todo_MVVM_2
//
//  Created by 浅田智哉 on 2023/11/23.
//

import UIKit

final class Router {
    
    // シングルトン
    static let shared: Router = .init()
    private init() {}
    
    private (set) var window: UIWindow?
    
    // 起動直後の画面を表示する
    func showRoot(window: UIWindow?) {
        let vc = UIStoryboard.mainViewController
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        self.window = window
    }
    
    func showCreate(from: UIViewController) {
        let vc = UIStoryboard.createViewController
        show(from: from, next: vc)
    }
    
    func showDetail(from: UIViewController) {
        let vc = UIStoryboard.detailViewController
        show(from: from, next: vc)
    }
}

private extension Router {
    func show(from: UIViewController, next: UIViewController, animated: Bool = true) {
        if let nav = from.navigationController {
            nav.pushViewController(next, animated: animated)
        } else {
            from.present(next, animated: animated, completion: nil)
        }
    }
}
