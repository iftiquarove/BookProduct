//
//  Extensions.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import UIKit

extension UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {[self] in
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
            activityIndicator.layer.cornerRadius = 6
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .large
            activityIndicator.startAnimating()
            activityIndicator.tag = 100
            for subview in view.subviews {
                if subview.tag == 100 {
                    return
                }
            }
            view.addSubview(activityIndicator)
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {[self] in
            let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
        }
    }
    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 15, weight: .medium)) {
        DispatchQueue.main.async {
            let toastLabel = UILabel()
            self.view.addSubview(toastLabel)
            toastLabel.font = font
            toastLabel.backgroundColor = .darkGray
            toastLabel.text = message
            toastLabel.textAlignment = .center
            toastLabel.textColor = .red
            toastLabel.sizeToFit()
            
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            toastLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(10)).isActive = true
            toastLabel.widthAnchor.constraint(equalToConstant: toastLabel.frame.width + 20).isActive = true
            toastLabel.heightAnchor.constraint(equalToConstant: toastLabel.frame.height + 20).isActive = true
            toastLabel.layer.cornerRadius = Utility.convertHeightMultiplier(constant: 12)
            toastLabel.clipsToBounds = true
            
            UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
}

extension UIView {
    func anchor (top : NSLayoutYAxisAnchor? = nil , left: NSLayoutXAxisAnchor?  = nil , bottom : NSLayoutYAxisAnchor?  = nil , right : NSLayoutXAxisAnchor?  = nil ,centerX : NSLayoutXAxisAnchor? = nil , centerY : NSLayoutYAxisAnchor? = nil, paddingTop : CGFloat = 0 , paddingLeft : CGFloat = 0 , paddingBottom : CGFloat = 0 , paddingRight : CGFloat = 0 ,xConstant : CGFloat = 0, yConstant : CGFloat = 0, width : CGFloat = 0 , height : CGFloat = 0 ){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top , constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left , constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom , constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right , constant: -paddingRight).isActive = true
        }
        
        if let centerX = centerX{
            self.centerXAnchor.constraint(equalTo: centerX, constant: xConstant).isActive = true
        }
        
        if let centerY = centerY{
            self.centerYAnchor.constraint(equalTo: centerY, constant: yConstant).isActive = true
        }
        
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fillSuperView(){
        guard let superView = self.superview else {return}
        translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
}
