//
//  BaseSlidingController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 31.03.22.
//

import Foundation

import UIKit

class BaseSlidingController: UIViewController {
    
    var mainViewLeadingContstraint: NSLayoutConstraint!
    var mainViewTrailingConstraint: NSLayoutConstraint!
    
    fileprivate var menuWidth: CGFloat = 250
    fileprivate var velocityThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false
    
    var actingViewController : UIViewController = UINavigationController(rootViewController: HomeViewController())
    
    let mainView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let menuControllerView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupViews()
        setupGestures()
    }

    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapDismiss() {
        closeMenu()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        mainViewLeadingContstraint.constant = x
        mainViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    
    func openMenu() {
        isMenuOpened = true
        mainViewLeadingContstraint.constant = menuWidth
        mainViewTrailingConstraint.constant = menuWidth
        performAnimations()
    }
    
    func closeMenu() {
        mainViewLeadingContstraint.constant = 0
        mainViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        cleanUpMainViewController()
        closeMenu()
        switch indexPath.row {
        case 0:
            actingViewController = UINavigationController(rootViewController: HomeViewController())
        case 1:
            let tabBarController = UITabBarController()
            let momentsController = UIViewController()
            momentsController.view.backgroundColor = .systemGray6
            momentsController.tabBarItem.title = "Moments"
            let momentsController2 = UIViewController()
            momentsController2.view.backgroundColor = .systemGray5
            momentsController2.tabBarItem.title = "Moments2"
            tabBarController.viewControllers = [momentsController , momentsController2]
            actingViewController = tabBarController
        case 2:
            actingViewController = UINavigationController(rootViewController: ListsViewController())
        default :
            actingViewController = BookmarksViewController()
        }
        addChild(actingViewController)
        mainView.addSubview(actingViewController.view)
        mainView.bringSubviewToFront(darkCoverView)
    }
    
    fileprivate func cleanUpMainViewController() {
        actingViewController.view.removeFromSuperview()
        actingViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    fileprivate func setupViews() {
        view.addSubview(mainView)
        view.addSubview(menuControllerView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            menuControllerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuControllerView.trailingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor),
            menuControllerView.widthAnchor.constraint(equalToConstant: menuWidth),
            menuControllerView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
            ])
        
        mainViewLeadingContstraint = mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        mainViewTrailingConstraint =  mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        mainViewLeadingContstraint.isActive = true
        mainViewTrailingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        
        let menuController = MenuViewController()
        let homeView = actingViewController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(homeView)
        mainView.addSubview(darkCoverView)
        menuControllerView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            // top, leading, bottom, trailing anchors
            homeView.topAnchor.constraint(equalTo: mainView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: menuControllerView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: menuControllerView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: menuControllerView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: menuControllerView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: mainView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            ])
        
        addChild(actingViewController)
        addChild(menuController)
        menuController.didMove(toParent: self)
    }
}
