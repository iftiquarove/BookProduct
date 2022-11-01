//
//  homeView.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import Foundation
import UIKit

class ProductListView: UIView {
    
    //MARK: - Properties
    
    lazy var navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        return view
    }()
    
    let productCellIdentifier = "productCell"
    
    lazy var productTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.showsCancelButton = true
        searchBar.barStyle = .black
        searchBar.barTintColor = .white
        searchBar.placeholder = " Search Here..."
        searchBar.sizeToFit()
        productTableView.tableHeaderView = searchBar
        return searchBar
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
        
        addSubview(navigationBarView)
        navigationBarView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: Utility.convertHeightMultiplier(constant: 100))
        
        addSubview(productTableView)
        productTableView.anchor(top: navigationBarView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        productTableView.register(ProductCell.self, forCellReuseIdentifier: productCellIdentifier)
    }
}
