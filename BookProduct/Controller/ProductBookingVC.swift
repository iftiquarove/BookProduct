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
    var fromDate: String?
    var toDate: String?
    
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
            self?.bookingView.fromDateButton.setTitle(selectedDate, for: .normal)
        }
        self.present(vc, animated: true)
    }
    
    @IBAction @objc func toDateTapped(_ sender: UIButton){
        let vc = CalendarVC()
        vc.callBack = {[weak self] selectedDate in
            self?.toDate = selectedDate
            self?.bookingView.toDateButton.setTitle(selectedDate, for: .normal)
        }
        self.present(vc, animated: true)
    }
    
    @IBAction @objc func confirmBookingTapped(_ sender: UIButton){
        guard let _ = fromDate, let _ = toDate else {
            showToast(message: "Please select date first")
            return
        }
        
        let alert = UIAlertController(title: "Confirm Booking", message: "Your total payemnt will be $500", preferredStyle: .alert)
        
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
