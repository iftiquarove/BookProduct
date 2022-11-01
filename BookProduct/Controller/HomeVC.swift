//
//  HomeVC.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 1/11/22.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - Properties
    
    lazy var bookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Book a Product", for: .normal)
        button.setBackgroundImage(UIImage(named: "box"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(bookButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Return a Product", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.setBackgroundImage(UIImage(named: "box"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [bookButton, returnButton])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 14
        return sv
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
        view.backgroundColor = .white
        view.addSubview(buttonStackView)
        buttonStackView.anchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor, yConstant: Utility.convertHeightMultiplier(constant: 40))
    }
    
    //MARK: - Button Actions
    
    @IBAction @objc func bookButtonTapped(_ sender: UIButton){
        let vc = ProductListVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction @objc func returnButtonTapped(_ sender: UIButton){
        let vc = ReturnListVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
