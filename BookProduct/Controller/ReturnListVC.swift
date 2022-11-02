//
//  ReturnListVC.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 1/11/22.
//

import UIKit
import CoreData

class ReturnListVC: UIViewController {
    //MARK: - Properties
    var products: [BookingProduct] = [] {
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
        view.navigationBarView.titleLabel.text = "Return List"
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
        if Utility.isEntityEmpty(.BookingProducts){
            return
        }
        print("🕜 Fetching Data ...")
        var products = [BookingProduct]()
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.BookingProducts.rawValue)
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
                let bookingDate = data.value(forKey: "bookingDate") as? Date
                let returnDate = data.value(forKey: "returnDate") as? Date
                
                let product = BookingProduct(productName: productName, productCode: productCode, productType: productType, productAvailibility: productAvailibility, needRepair: needRepair, currentDurability: currentDurability, maxDurability: maxDurability, mileage: mileage, price: price, minimumRentDays: minimumRentDays, bookingDate: bookingDate, returnDate: returnDate)
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

extension ReturnListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productView.productCellIdentifier, for: indexPath) as! ProductCell
        cell.productNameLabel.text = products[indexPath.row].productName
        cell.productCodeLabel.text = products[indexPath.row].productCode
        
        if Date() > products[indexPath.row].returnDate ?? Date(){
            cell.productAvailabilityLabel.text = "Need To Return: true"
            cell.productAvailabilityLabel.textColor = .systemRed
        }else{
            cell.productAvailabilityLabel.text = "Need To Return: false"
            cell.productAvailabilityLabel.textColor = .systemGreen
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        var usedDays = Utility.daysBetween(start: products[indexPath.row].bookingDate ?? Date(), end: Date())
        if usedDays < product.minimumRentDays ?? 0{
            usedDays = product.minimumRentDays ?? 0
        }
        
        var cost: Int = 0
        var updatedDuribility: Int = 0
        
        if products[indexPath.row].productType == "plain"{
            cost = Utility.returnCostCalculation(forDays: usedDays, type: .plain, cost: product.price ?? 0, currentDuribility: product.currentDurability ?? 0).cost
            updatedDuribility = Utility.returnCostCalculation(forDays: usedDays, type: .plain, cost: product.price ?? 0, currentDuribility: product.currentDurability ?? 0).currentDuribility
        }else{
            cost = Utility.returnCostCalculation(forDays: usedDays, type: .meter, cost: product.price ?? 0, currentDuribility: product.currentDurability ?? 0).cost
            updatedDuribility = Utility.returnCostCalculation(forDays: usedDays, type: .meter, cost: product.price ?? 0, currentDuribility: product.currentDurability ?? 0).currentDuribility
        }
        
        let alert = UIAlertController(title: "Confirm Return", message: "Your total payemnt untill today is $\(cost)", preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "Confirm", style: .cancel, handler: { action in
            
            // Update the product availibity to false as already booked
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.Products.rawValue)
            fetchRequest.predicate = NSPredicate(format: "productCode = %@", product.productCode!)
            let results = try? context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count == 0 {
               // here you are inserting
            } else {
               // here you are updating
                results?[0].setValue(true, forKey: "productAvailibility")
                if updatedDuribility >= 0{
                    results?[0].setValue(updatedDuribility, forKey: "currentDurability")
                }
            }
            // ################## #################### ##################
            
            
            // Delete the object from return list
            let returnFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.BookingProducts.rawValue)
            returnFetchRequest.predicate = NSPredicate(format: "productCode = %@", product.productCode!)
            if let result = try? context.fetch(returnFetchRequest) as? [NSManagedObject] {
                for object in result {
                    context.delete(object)
                }
            }
            // **************** **************** *************
            
            do {
                try context.save()
                print("🟢 saved")
                DispatchQueue.main.async {[self] in
                    Utility.showAlert(self, "Success", "Return succesfully completed!")
                    navigationController?.popToRootViewController(animated: true)
                }
            } catch {
                print("🔴 Storing data Failed: ", error.localizedDescription)
            }
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            return
        })
        confirmButton.setValue(UIColor.blue, forKey: "titleTextColor")
        alert.addAction(confirmButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

