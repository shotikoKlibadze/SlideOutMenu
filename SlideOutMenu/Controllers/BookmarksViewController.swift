//
//  BookmarksViewController.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 05.04.22.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    var label : UILabel  = {
        let label = UILabel()
        label.text = "Bookmarks"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .white
        label.frame = view.frame

    }
    

   

}
