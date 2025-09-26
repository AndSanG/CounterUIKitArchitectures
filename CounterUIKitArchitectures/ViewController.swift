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

        let mvvmPageNavigationController = UINavigationController(rootViewController: MVVMPageViewController())
        mvvmPageNavigationController.tabBarItem = UITabBarItem(title: "MVVM", image: UIImage(systemName: "2.circle"), selectedImage: UIImage(systemName: "2.circle.fill"))

        let viperNavigationController = UINavigationController(rootViewController:  CounterModule.build())
        viperNavigationController.tabBarItem = UITabBarItem(title: "VIPER", image: UIImage(systemName: "3.circle"), selectedImage: UIImage(systemName: "3.circle.fill"))
        
        let appStore = Store(initial: CounterState(), reducer: counterReducer)
        let reduxNavigationController = UINavigationController(rootViewController: RxCounterViewController(store: appStore))
        reduxNavigationController.tabBarItem = UITabBarItem(title: "Redux", image: UIImage(systemName: "3.circle"), selectedImage: UIImage(systemName: "4.circle.fill"))

        tabBarController.viewControllers = [
            mvcNavigationController,
            mvvmPageNavigationController,
            viperNavigationController,
            reduxNavigationController
        ]

        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBarController.didMove(toParent: self)
    }

}
