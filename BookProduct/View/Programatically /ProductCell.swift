//
//  ProductCell.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import UIKit

class ProductCell: UITableViewCell {
    //MARK: - Properties
    
    lazy var productImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "AC")
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Air Compressor 12"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Product code: p1"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var productAvailabilityLabel: UILabel = {
        let label = UILabel()
        label.text = "Availibility: True"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        addSubview(productImage)
        productImage.anchor(left: leftAnchor, centerY: centerYAnchor, width: 100, height: 100)
        
        addSubview(productNameLabel)
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 20)
        
        addSubview(productCodeLabel)
        productCodeLabel.anchor(top: productNameLabel.bottomAnchor, left: productNameLabel.leftAnchor, paddingTop: 10)
        
        addSubview(productAvailabilityLabel)
        productAvailabilityLabel.anchor(top: productCodeLabel.bottomAnchor, left: productNameLabel.leftAnchor, paddingTop: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
}
