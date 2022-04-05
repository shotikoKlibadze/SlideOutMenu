//
//  CustomMenuHeaderView.swift
//  SlideOutMenu
//
//  Created by Shotiko Klibadze on 04.04.22.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    let mainLabel = UILabel()
    let seccondaryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        setUpUI()
        setUpLayout()
    }
    
    private func setUpUI() {
        mainLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        mainLabel.text = "Your Profile"
        seccondaryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        seccondaryLabel.text = "Infromation"
    }
    
    private func setUpLayout() {
        let stackView = UIStackView(arrangedSubviews: [mainLabel,seccondaryLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor,constant: 60),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 30),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
