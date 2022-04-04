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
        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        view.addGestureRecognizer(panGesture)
        
    }
    
//    @objc func handlePan(gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: view)
//        let x = translation.x
//        view.transform = CGAffineTransform(scaleX: x, y: 0)
//    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MenuCell")
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
    
    

}
