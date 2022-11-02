//
//  ViewController.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import UIKit
import CoreData

class ProductListVC: UIViewController {
    //MARK: - Properties
    
    var products: [Product] = [] {
        didSet{
            DispatchQueue.main.async {[self] in
                productView.productTableView.reloadData()
            }
        }
    }
    
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
        fetchData()
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
    
    private func fetchData(){
        if Utility.isEntityEmpty(.Products){
            return
        }
        print("🕜 Fetching Data !")
        var products = [Product]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.Products.rawValue)
        request.returnsObjectsAsFaults = true
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let productName = data.value(forKey: "productName") as? String
                let productCode = data.value(forKey: "productCode") as? String
                let productType = data.value(forKey: "productType") as? String
                let productAvailibility = data.value(forKey: "productAvailibility") as? Bool
                let needRepair = data.value(forKey: "needRepair") as? Bool
                let currentDurability = data.value(forKey: "currentDurability") as? Int
                let maxDurability = data.value(forKey: "maxDurability") as? Int
                let mileage = data.value(forKey: "mileage") as? Int
                let price = data.value(forKey: "price") as? Int
                let minimumRentDays = data.value(forKey: "minimumRentDays") as? Int
                
                let product = Product(productName: productName, productCode: productCode, productType: productType, productAvailibility: productAvailibility, needRepair: needRepair, currentDurability: currentDurability, maxDurability: maxDurability, mileage: mileage, price: price, minimumRentDays: minimumRentDays)
                products.append(product)
            }
            self.products.append(contentsOf: products)
            
        } catch {
            print("🔴 Fetching data Failed")
        }
    }
    
    //MARK: - Button Actions
    
    @IBAction @objc func backButtonTapped(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productView.productCellIdentifier, for: indexPath) as! ProductCell
        cell.productNameLabel.text = products[indexPath.row].productName
        cell.productCodeLabel.text = products[indexPath.row].productCode
        cell.productAvailabilityLabel.text = "Product Available: \(products[indexPath.row].productAvailibility ?? false)"
        if products[indexPath.row].productAvailibility ?? false{
            cell.productAvailabilityLabel.textColor = .systemGreen
        }else{
            cell.productAvailabilityLabel.textColor = .systemRed
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductBookingVC(product: products[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

