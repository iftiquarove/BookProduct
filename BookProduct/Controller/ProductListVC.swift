//
//  ViewController.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import UIKit

class ProductListVC: UIViewController {
    //MARK: - Properties
    
    lazy var productView: ProductListView = {
        let view = ProductListView()
        view.productTableView.delegate = self
        view.productTableView.dataSource = self
        view.navigationBarView.titleLabel.text = "Product List"
        view.navigationBarView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        return view
    }()
    
    //MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    deinit{
        
    }
    
    //MARK: - Functions
    
    private func setupSubviews(){
        view.addSubview(productView)
        productView.fillSuperView()
    }
    
    //MARK: - Button Actions
    
    @IBAction @objc func backButtonTapped(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productView.productCellIdentifier, for: indexPath) as! ProductCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductBookingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

