//
//  BaseSlidingController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 31.03.22.
//

import Foundation

import UIKit

class BaseSlidingController: UIViewController {
    
    var homeControllerViewConstraint: NSLayoutConstraint!
    fileprivate var menuWidth: CGFloat = 250
    fileprivate var velocityThreshold: CGFloat = 500
    fileprivate var isMenuOpened = false
    
    var actingViewController : UIViewController?
    
    let mainControllerView: UIView = {
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
        
        // how do we translate our red view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // menuWidth = view.frame.width * 0.65
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        homeControllerViewConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        // Cleaning up this section of code to solve for Lesson #10 Challenge of velocity and darkCoverView
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
    
    fileprivate func openMenu() {
        isMenuOpened = true
        homeControllerViewConstraint.constant = menuWidth
        performAnimations()
    }
    
    fileprivate func closeMenu() {
        homeControllerViewConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        cleanUpMainViewController()
        switch indexPath.row {
        case 0:
            print("Show Home")
        case 1:
            print("Show Moments")
        case 2:
            let vc = ListsViewController()
            mainControllerView.addSubview(vc.view)
            addChild(vc)
            actingViewController = vc
        default :
            let vc = BookmarksViewController()
            mainControllerView.addSubview(vc.view)
            addChild(vc)
            actingViewController = vc
        }
        mainControllerView.bringSubviewToFront(darkCoverView)
        closeMenu()
    }
    
    fileprivate func cleanUpMainViewController() {
        actingViewController?.view.removeFromSuperview()
        actingViewController?.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            // leave a reference link down in desc below
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    
    
    fileprivate func setupViews() {
        view.addSubview(mainControllerView)
        view.addSubview(menuControllerView)
        
        // let's go ahead and use Auto Layout
        NSLayoutConstraint.activate([
            mainControllerView.topAnchor.constraint(equalTo: view.topAnchor),
            mainControllerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainControllerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            menuControllerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuControllerView.trailingAnchor.constraint(equalTo: mainControllerView.safeAreaLayoutGuide.leadingAnchor),
            menuControllerView.widthAnchor.constraint(equalToConstant: menuWidth),
            menuControllerView.bottomAnchor.constraint(equalTo: mainControllerView.bottomAnchor)
            ])
        
        self.homeControllerViewConstraint = mainControllerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        homeControllerViewConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        // let's add back our HomeController into the redView
      //  let homeController = HomeViewController()
        actingViewController = HomeViewController()
        let menuController = MenuViewController()
        
        let homeView = actingViewController!.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        mainControllerView.addSubview(homeView)
        mainControllerView.addSubview(darkCoverView)
        menuControllerView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            // top, leading, bottom, trailing anchors
            homeView.topAnchor.constraint(equalTo: mainControllerView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: mainControllerView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: mainControllerView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: mainControllerView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: menuControllerView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: menuControllerView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: menuControllerView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: menuControllerView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: mainControllerView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: mainControllerView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: mainControllerView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: mainControllerView.trailingAnchor),
            ])
        
        addChild(actingViewController!)
        addChild(menuController)
        menuController.didMove(toParent: self)
    }

}
