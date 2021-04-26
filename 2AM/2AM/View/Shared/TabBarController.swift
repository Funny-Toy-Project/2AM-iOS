//
//  TabBar.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import UIKit

class TabBarController: UITabBarController {
    
    init() {
            super.init(nibName: nil, bundle: nil)
            
            let vcs = [HomeViewController(), MyPageViewController()]
            let items = [
                UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0),
                UITabBarItem(tabBarSystemItem: .more, tag: 1)
            ]
            (0..<vcs.count).forEach { vcs[$0].tabBarItem = items[$0] }
            
            setViewControllers(vcs, animated: true)
        }
    
    required init?(coder: NSCoder) {
        fatalError(">> TabBar Controller : init(coder:) has not been implemented")
    }
}
