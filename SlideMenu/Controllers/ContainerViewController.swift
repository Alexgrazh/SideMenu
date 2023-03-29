//
//  ViewController.swift
//  SlideMenu
//
//  Created by Alex Grazhdan on 29.03.2023.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    var menuVc = MenuViewController()
    let homeVc = HomeViewController()
    var navVc : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
    }

    private func addChildVCs() {
        //Menu
        menuVc.delegate = self
        addChild(menuVc)
        view.addSubview(menuVc.view)
        menuVc.didMove(toParent: self)
        
        //Home
        homeVc.delegate = self
        let navVc = UINavigationController(rootViewController: homeVc)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        self.navVc = navVc
    }

}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
       toggleMenu(comletion: nil)
       
    }
    
    func toggleMenu(comletion: (() -> Void)?){
        //Animate the menu
        switch menuState {
        case .closed :
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.navVc?.view.frame.origin.x = self.homeVc.view.frame.size.width - 100
                
            } completion: {[weak self] done in
                if done {
                    self?.menuState = .opened
                    DispatchQueue.main.async {
                        comletion?()
                    }
                   
                }
            }
        case .opened:
            // clos it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.navVc?.view.frame.origin.x = 0
                
            } completion: {[weak self] done in
                if done {
                    self?.menuState = .closed
                }
            }
        }
    }
    
}

extension ContainerViewController : MenuViewControllerDelegate {
    func didSelect(manuItem: MenuViewController.MenuOptions) {
        toggleMenu { [weak self] in
            switch manuItem {
                
            case .home:
                break
            case .info:
                break
            case .appRation:
                break
            case .shareApp:
                break
            case .settings:
                break
            }
        }
    }
    
    
}
