//
//  ViewController.swift
//  SlideMenu
//
//  Created by Alex Grazhdan on 29.03.2023.
//

import UIKit

class ContainerViewController: UIViewController {

    let menuVc = MenuViewController()
    let homeVc = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
    }

    private func addChildVCs() {
        //Menu
        addChild(menuVc)
        view.addSubview(menuVc.view)
        menuVc.didMove(toParent: self)
        
        //Home
        homeVc.delegate = self
        let navVc = UINavigationController(rootViewController: homeVc)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        
    }

}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        //Animate the menu
        print("did tap menu")
    }
    
    
}
