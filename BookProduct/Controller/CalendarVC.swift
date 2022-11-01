//
//  CalendarVC.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 1/11/22.
//

import UIKit

class CalendarVC: UIViewController {
    //MARK: - Properties
    
    lazy var tapView = UIView()
    
    lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var callBack: ((_ selectedDate: Date) -> Void)?

    
    //MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        addTapGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    //MARK: - Functions
    fileprivate func setUpSubViews(){
        view.backgroundColor = .clear
        
        view.addSubview(bottomView)
        bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingRight: 20, height: Utility.convertHeightMultiplier(constant: 200))
        
        view.addSubview(calendarView)
        calendarView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: Utility.convertHeightMultiplier(constant: 100), paddingRight: 20, height: Utility.convertHeightMultiplier(constant: 335))
        
        tapView.backgroundColor = .clear
        view.addSubview(tapView)
        tapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: calendarView.topAnchor, right: view.rightAnchor)
        
        calendarView.theme = CalendarViewTheme()
        calendarView.localeIdentifier = "en_US"
        calendarView.delegate = self
        
        //Min Date to configure how past calendar can be selected
        calendarView.minDate = Date("2021-04-01")
        //Max date to configure how max calender can be selected
        calendarView.maxDate = Date("2030-12-06")
    }
    
    private func addTapGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTapped(_:)))
        tapView.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: - Button Actions
    
    @objc func dismissTapped(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: true)
    }
    
    @objc func calendarTapped(_ sender: UITapGestureRecognizer){
        return
    }
}

extension CalendarVC: CalendarViewDelegate {
    func calendarView(_ calendarView: CalendarView, didUpdateBeginDate beginDate: Date?) {
        if beginDate ?? Date() < Date(){
            showToast(message: "Can't select Past dates")
            return
        }
        callBack?(beginDate ?? Date())
        dismiss(animated: true)
    }
    
    func calendarView(_ calendarView: CalendarView, didUpdateFinishDate finishDate: Date?) {
        return
    }
}

