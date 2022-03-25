//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 24.03.22.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let menuVc = MenuViewController()
    let darkCoverView = UIView()
    var menuWidth = CGFloat()
    var menuIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
        setupPanGesture()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuWidth = view.frame.width * 0.65
        menuVc.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        guard let keyWindow = view.window?.windowScene?.keyWindow else { return }
        keyWindow.addSubview(menuVc.view)
        addChild(menuVc)
        setupDarkCover()
    }
    
    
    private func setupDarkCover() {
        darkCoverView.alpha = menuIsOpen ? 1 : 0
        guard let keyWindow = view.window?.windowScene?.keyWindow else { return }
        keyWindow.addSubview(darkCoverView)
        darkCoverView.frame = keyWindow.frame
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        darkCoverView.isUserInteractionEnabled = false
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuTapped))
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        if gesture.state == .changed {
            var x = translation.x
            if menuIsOpen {
                x += menuWidth
            }
            x = min(x, menuWidth)
            x = max(x, 0)
            print(x)
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuVc.view.transform = transform
            navigationController?.view.transform = transform
            darkCoverView.transform = transform
            darkCoverView.alpha = x / menuWidth
        } else if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    private func handleEnded(gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view)
        let translation = gesture.translation(in: view)
        let velocityThreshold : CGFloat = 500
        if menuIsOpen {
            if velocity.x > abs(-velocityThreshold) {
                closeMenu()
                return
            }
            abs(translation.x) > menuWidth / 3.5 ? closeMenu() : openMenu()
        } else {
            if velocity.x > velocityThreshold {
                openMenu()
                return
            }
            translation.x > menuWidth / 3 ? openMenu() : closeMenu()
        }
    }
   
    @objc func menuTapped() {
        menuIsOpen ? closeMenu() : openMenu()
    }
    
    private func openMenu() {
        let transform = CGAffineTransform(translationX:  menuWidth, y: 0)
        performAnimation(transform: transform)
        menuIsOpen = true
    }
    
    private func closeMenu() {
        performAnimation(transform: .identity)
        menuIsOpen = false
    }
    
    
    private func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            guard let self = self else {return}
            self.menuVc.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkCoverView.transform = transform
            self.darkCoverView.alpha = transform == .identity ? 0 : 1
        }
    }
    
    private func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = " Row: \(indexPath.row)"
        return cell
    }

}

