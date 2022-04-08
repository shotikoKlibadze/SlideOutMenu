//
//  ListsViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 05.04.22.
//

import UIKit

class ListsViewController: UIViewController {

    var label : UILabel  = {
        let label = UILabel()
        label.text = "List"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .white
        label.frame = view.frame
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Lists"
    }
}
