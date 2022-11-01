//
//  NavigationBar.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 1/11/22.
//

import UIKit

class CustomNavigationBar: UIView {
    
    //MARK: - Properties
    let backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "backButton").withTintColor(.black), for: .normal)
        return button
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "ProductList"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setUpSubviews(){
        self.backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(centerX: centerXAnchor, centerY: centerYAnchor, yConstant: 20)
        
        addSubview(backButton)
        backButton.anchor(left: leftAnchor, centerY: titleLabel.centerYAnchor, paddingLeft: 10, width: 30, height: 30)
    }
    
    //MARK: - Button Actions
}
