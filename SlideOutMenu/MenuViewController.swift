//
//  MenuViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 24.03.22.
//

import Foundation
import UIKit

class MenuViewController : UITableViewController {
    
    let menuItems = ["Home", "Moments", "Lists", "Bookmarks"]
    
    weak var controller : BaseSlidingController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
      
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        guard let parent = parent as? BaseSlidingController else { return }
        controller = parent
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomMenuHeaderView()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuTableViewCell(style: .default, reuseIdentifier: "MenuCell")
        cell.backgroundColor = .systemGray5
        cell.tittleLable.text = menuItems[indexPath.row]
        cell.iconImageView.image = UIImage(named: menuItems[indexPath.row])
       
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        controller?.didSelectMenuItem(indexPath: indexPath)
    }
    
    
    
}
