//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 24.03.22.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let darkCoverView = UIView()
    var menuWidth = CGFloat()
    var menuIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Home"
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

extension HomeViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}

