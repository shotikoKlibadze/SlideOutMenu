//
//  MenuViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 24.03.22.
//

import Foundation
import UIKit

class MenuViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .blue
        view.backgroundColor = .red
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomMenuHeaderView()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MenuCell")
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
    
}
