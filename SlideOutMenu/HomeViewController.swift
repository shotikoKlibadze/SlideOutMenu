//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 24.03.22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView = {
        let tablView = UITableView()
        return tablView
    }()
    
    let darkCoverView = UIView()
    var menuWidth = CGFloat()
    var menuIsOpen = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        view.backgroundColor = .white
        setupNavigationItems()
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Home"
        setupCustomNavigationButton()
    }
    
    private func setupCustomNavigationButton() {
        let image = UIImage(named: "open")?.withRenderingMode(.alwaysOriginal)
        let customButtonView = UIButton(type: .system)
        customButtonView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customButtonView.setImage(image, for: .normal)
        customButtonView.imageView?.contentMode = .scaleAspectFit
        customButtonView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        customButtonView.layer.cornerRadius = 20
        customButtonView.clipsToBounds = true
        let barButtonItem = UIBarButtonItem(customView: customButtonView)
        navigationItem.leftBarButtonItem = barButtonItem
    }
        
    @objc func handleOpen() {
         guard let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController as? BaseSlidingController else { return }
        keyWindow.openMenu()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = " Row: \(indexPath.row)"
        return cell
    }

}

extension HomeViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

