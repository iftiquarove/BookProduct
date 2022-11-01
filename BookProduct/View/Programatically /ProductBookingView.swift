//
//  ProductDetailsVC.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 1/11/22.
//

import Foundation
import UIKit

class ProductBookingView: UIView {
    
    //MARK: - Properties
    lazy var navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.titleLabel.text = "Book A Product"
        return view
    }()
    
    lazy var productImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "AC")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var productNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name: Air Compressor 12 GAS"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productCodeLabel : UILabel = {
        let label = UILabel()
        label.text = "Code: p1"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productAvailabilityLabel : UILabel = {
        let label = UILabel()
        label.text = "Available: True"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productRapairStatusLabel : UILabel = {
        let label = UILabel()
        label.text = "Need To Repair: False"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productMaxDurabilityLabel : UILabel = {
        let label = UILabel()
        label.text = "Max Durability: 3000"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productCurrentDurabilityLabel : UILabel = {
        let label = UILabel()
        label.text = "Current Durability: 1000"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productMileage : UILabel = {
        let label = UILabel()
        label.text = "Mileage: N/A"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productRentLabel : UILabel = {
        let label = UILabel()
        label.text = "Product Rent Per Day: 5000"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var confirmBookingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm Booking", for: .normal)
        button.setBackgroundImage(UIImage(named: "box"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    lazy var BookingTitle: UILabel = {
       let label = UILabel()
        label.text = "Booking Date"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    lazy var fromDateLabel: UILabel = {
        let label = UILabel()
        label.text = "From: "
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var toDateLabel: UILabel = {
        let label = UILabel()
        label.text = "To: "
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var fromDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tap to Select A date", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    lazy var toDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tap to Select A date", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    let paddingTop = Utility.convertHeightMultiplier(constant: 20)
    
    
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
        addSubview(navigationBarView)
        navigationBarView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 100)
        
        addSubview(productImage)
        productImage.anchor(top: navigationBarView.bottomAnchor, centerX: centerXAnchor, width: 130, height: 130)
        
        addSubview(productNameLabel)
        productNameLabel.anchor(top: productImage.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(productCodeLabel)
        productCodeLabel.anchor(top: productNameLabel.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(productAvailabilityLabel)
        productAvailabilityLabel.anchor(top: productCodeLabel.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(productRapairStatusLabel)
        productRapairStatusLabel.anchor(top: productAvailabilityLabel.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(productMaxDurabilityLabel)
        productMaxDurabilityLabel.anchor(top: productRapairStatusLabel.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(productCurrentDurabilityLabel)
        productCurrentDurabilityLabel.anchor(top: productMaxDurabilityLabel.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(productRentLabel)
        productRentLabel.anchor(top: productCurrentDurabilityLabel.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(BookingTitle)
        BookingTitle.anchor(top: productRentLabel.bottomAnchor, centerX: centerXAnchor, paddingTop: Utility.convertHeightMultiplier(constant: 30))
        
        addSubview(fromDateLabel)
        fromDateLabel.anchor(top: BookingTitle.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(fromDateButton)
        fromDateButton.anchor(left: fromDateLabel.rightAnchor, centerY: fromDateLabel.centerYAnchor, paddingLeft: 20)
        
        addSubview(toDateLabel)
        toDateLabel.anchor(top: fromDateLabel.bottomAnchor, left: leftAnchor, paddingTop: paddingTop, paddingLeft: 20)
        
        addSubview(toDateButton)
        toDateButton.anchor(left: toDateLabel.rightAnchor, centerY: toDateLabel.centerYAnchor, paddingLeft: 20)
        
        addSubview(confirmBookingButton)
        confirmBookingButton.anchor(top: toDateLabel.bottomAnchor, centerX: centerXAnchor, paddingTop: Utility.convertHeightMultiplier(constant: 40), width: 200, height: 40)
    }
    
    //MARK: - Button Actions
}
