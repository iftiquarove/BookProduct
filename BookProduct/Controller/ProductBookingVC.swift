//
//  ProductDetailsVC.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 1/11/22.
//

import UIKit
import CoreData

class ProductBookingVC: UIViewController{
    //MARK: - Properties
    
    var product: Product?
    var fromDate: Date?
    var toDate: Date?
    
    lazy var bookingView: ProductBookingView = {
        let view = ProductBookingView(product: product!)
        view.navigationBarView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        view.confirmBookingButton.addTarget(self, action: #selector(confirmBookingTapped(_:)), for: .touchUpInside)
        view.fromDateButton.addTarget(self, action: #selector(fromDateTapped(_:)), for: .touchUpInside)
        view.toDateButton.addTarget(self, action: #selector(toDateTapped(_:)), for: .touchUpInside)
        return view
    }()
    
    //MARK: - Initializers
    
    required init(product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.addSubview(bookingView)
        bookingView.fillSuperView()
    }
    
    private func bookAProduct(product: Product){
        let product = BookingProduct(productName: product.productName, productCode: product.productCode, productType: product.productType, productAvailibility: product.productAvailibility, needRepair: product.needRepair, currentDurability: product.currentDurability, maxDurability: product.maxDurability, mileage: product.mileage, price: product.price, minimumRentDays: product.minimumRentDays, bookingDate: fromDate, returnDate: toDate)
        
        saveDataInDB(product: product)
    }
    
    func saveDataInDB(product: BookingProduct){
        // Save booking product in `BookingProducts` table
        let entity = NSEntityDescription.entity(forEntityName: Entity.BookingProducts.rawValue, in: context)
        let newProduct = NSManagedObject(entity: entity!, insertInto: context)
        newProduct.setValue(product.productName, forKey: "productName")
        newProduct.setValue(product.productCode, forKey: "productCode")
        newProduct.setValue(product.productType, forKey: "productType")
        newProduct.setValue(product.productAvailibility, forKey: "productAvailibility")
        newProduct.setValue(product.needRepair, forKey: "needRepair")
        newProduct.setValue(product.currentDurability, forKey: "currentDurability")
        newProduct.setValue(product.maxDurability, forKey: "maxDurability")
        newProduct.setValue(product.mileage ?? 0, forKey: "mileage")
        newProduct.setValue(product.price, forKey: "price")
        newProduct.setValue(product.minimumRentDays, forKey: "minimumRentDays")
        newProduct.setValue(product.bookingDate, forKey: "bookingDate")
        newProduct.setValue(product.returnDate, forKey: "returnDate")
        // ***************** ********************* *******************
        
        
        // Update the product availibity to false as already booked
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.Products.rawValue)
        fetchRequest.predicate = NSPredicate(format: "productCode = %@", product.productCode!)
        let results = try? context.fetch(fetchRequest) as? [NSManagedObject]
        if results?.count == 0 {
           // here you are inserting
        } else {
           // here you are updating
            results?[0].setValue(false, forKey: "productAvailibility")
        }
        // ################## #################### ##################

        do {
            try context.save()
            print("🟢 saved")
            DispatchQueue.main.async {[self] in
                Utility.showAlert(self, "Success", "Booking succesfully completed!")
                navigationController?.popToRootViewController(animated: true)
            }
        } catch {
            print("🔴 Storing data Failed: ", error.localizedDescription)
        }
    }
    
    //MARK: - Button Actions
    @IBAction @objc func backButtonTapped(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction @objc func fromDateTapped(_ sender: UIButton){
        let vc = CalendarVC()
        vc.callBack = {[weak self] selectedDate in
            self?.fromDate = selectedDate
            let dateString = "\(selectedDate.year)-\(selectedDate.month)-\(selectedDate.day)"
            self?.bookingView.fromDateButton.setTitle(dateString, for: .normal)
        }
        self.present(vc, animated: true)
    }
    
    @IBAction @objc func toDateTapped(_ sender: UIButton){
        guard let fromDate = fromDate else {
            showToast(message: "select from date first!")
            return
        }
        
        let vc = CalendarVC()
        vc.callBack = {[weak self] selectedDate in
            if selectedDate <= fromDate{
                self?.showToast(message: "Invalid date!")
                return
            }
            
            self?.toDate = selectedDate
            let dateString = "\(selectedDate.year)-\(selectedDate.month)-\(selectedDate.day)"
            self?.bookingView.toDateButton.setTitle(dateString, for: .normal)
        }
        self.present(vc, animated: true)
    }
    
    @IBAction @objc func confirmBookingTapped(_ sender: UIButton){
        if !(product?.productAvailibility ?? false){
            Utility.showAlert(self, "Warning", " Product not available at this moment!")
            return
        }
        
        
        guard let fromDate = fromDate, let toDate = toDate else {
            showToast(message: "Please select date first")
            return
        }
        
        let daysBetween = Utility.daysBetween(start: fromDate, end: toDate)
        if daysBetween < product?.minimumRentDays ?? 0{
            showToast(message: "Please meet the minimumum Rent Days")
            return
        }
        
        var totalAmount = 0
        if product?.productType == PRODUCT_TYPE.plain.rawValue{
            totalAmount = Utility.bookingCostCalculation(forDays: daysBetween, type: .plain, cost: product?.price ?? 0)
        }else{
            totalAmount = Utility.bookingCostCalculation(forDays: daysBetween, type: .meter, cost: product?.price ?? 0)
        }
        
        
        let alert = UIAlertController(title: "Confirm Booking", message: "Your total payemnt will be $\(totalAmount)", preferredStyle: .alert)
        let confirmButton = UIAlertAction(title: "Confirm", style: .cancel, handler: {[weak self] action in
            guard let self = self, let product = self.product else {return}
            self.bookAProduct(product: product)
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
