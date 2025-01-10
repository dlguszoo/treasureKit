//
//  BaseTabBarController.swift
//  
//
//  Created by 이현주 on 1/10/25.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    private override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        configureTabs()
    }
    
    private func configureTabs() {
        
        //TabBarShadow.swift 등록!!
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0, x: 0, y: 0, blur: 0)
        
        self.tabBar.tintColor = Constants.Colors.skyblue
        self.tabBar.unselectedItemTintColor = Constants.Colors.gray500
        self.tabBar.backgroundColor = .systemBackground
        
        let nav1 = UINavigationController(rootViewController: HomeViewController())
        let nav2 = UINavigationController(rootViewController: HomeViewController())
        let nav3 = UINavigationController(rootViewController: HomeViewController())
        let nav4 = UINavigationController(rootViewController: HomeViewController())
        let nav5 = UINavigationController(rootViewController: HomeViewController())
        
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "Home")?.withRenderingMode(.alwaysTemplate), tag: 0)
        
        nav2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "")?.withRenderingMode(.alwaysTemplate), tag: 1)
        
        nav3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "")?.withRenderingMode(.alwaysTemplate), tag: 2)
        
        nav4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "")?.withRenderingMode(.alwaysTemplate), tag: 3)
        
        nav5.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "")?.withRenderingMode(.alwaysTemplate), tag: 4)
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
    }
}

// MARK: - UITabBarControllerDelegate
extension BaseTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // 현재 선택된 탭이 다시 선택되었을 때만 처리
        guard let navController = viewController as? UINavigationController else { return }
        
        // 루트 뷰로 이동
        navController.popToRootViewController(animated: true)
    }
}
