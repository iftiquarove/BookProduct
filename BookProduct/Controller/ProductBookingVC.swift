//
//  ProductDetailsVC.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 1/11/22.
//

import UIKit

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
        let confirmButton = UIAlertAction(title: "Confirm", style: .cancel, handler: { action in
           
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
