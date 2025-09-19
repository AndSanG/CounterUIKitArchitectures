//
//  ViewController.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 19/9/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }

    private func configureTabBarController() {
        let tabBarController = UITabBarController()

        let mvcNavigationController = UINavigationController(rootViewController: MVCCounterViewController())
        mvcNavigationController.tabBarItem = UITabBarItem(title: "MVC", image: UIImage(systemName: "1.circle"), selectedImage: UIImage(systemName: "1.circle.fill"))

        let mvvmCombineNavigationController = UINavigationController(rootViewController: MVVMCombineCounterViewController())
        mvvmCombineNavigationController.tabBarItem = UITabBarItem(title: "MVVM Combine", image: UIImage(systemName: "2.circle"), selectedImage: UIImage(systemName: "2.circle.fill"))

        let mvvmObservableNavigationController = UINavigationController(rootViewController: MVVMObservableCounterViewController())
        mvvmObservableNavigationController.tabBarItem = UITabBarItem(title: "MVVM Observable", image: UIImage(systemName: "3.circle"), selectedImage: UIImage(systemName: "3.circle.fill"))

        let mvvmDelegateNavigationController = UINavigationController(rootViewController: MVVMDelegateCounterViewController())
        mvvmDelegateNavigationController.tabBarItem = UITabBarItem(title: "MVVM Delegate", image: UIImage(systemName: "4.circle"), selectedImage: UIImage(systemName: "4.circle.fill"))

        tabBarController.viewControllers = [
            mvcNavigationController,
            mvvmCombineNavigationController,
            mvvmObservableNavigationController,
            mvvmDelegateNavigationController
        ]

        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBarController.didMove(toParent: self)
    }

}
