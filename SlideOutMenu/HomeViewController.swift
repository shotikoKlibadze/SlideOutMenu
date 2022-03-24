//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 24.03.22.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let menuVc = MenuViewController()
    var menuWidth = CGFloat()
    var isMenuOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuWidth = view.frame.width * 0.8
        menuVc.view.frame = CGRect(x: -menuWidth, y: 0, width: view.frame.width * 0.8, height: view.frame.height)
        guard let keyWindow = getKeyWindow() else { return}
        keyWindow.addSubview(menuVc.view)
        addChild(menuVc)
    }
    
    private func setupNavigationItems() {
        view.backgroundColor = .white
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuTapped))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        if sender.state == .changed {
            var x = translation.x
            
            if isMenuOpen {
                x += menuWidth
            }
            x = min(x, menuWidth)
            x = max(x, 0)
            
            
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuVc.view.transform = transform
            navigationController?.view.transform = transform
        } else if sender.state == .ended {
            translation.x > menuWidth / 3 ? openMenu() : closeMenu()
        }
       
    }
   
    @objc func menuTapped() {
        isMenuOpen ? closeMenu() : openMenu()
    }
    
    func openMenu() {
        let transform = CGAffineTransform(translationX:  self.view.frame.width * 0.8, y: 0)
        performAnimation(transform: transform)
        isMenuOpen.toggle()
    }
    
    func closeMenu() {
        performAnimation(transform: .identity)
        isMenuOpen.toggle()
    }
    
    
    private func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            guard let self = self else {return}
            self.menuVc.view.transform = transform
           // self.view.transform = transform
            self.navigationController?.view.transform = transform
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

