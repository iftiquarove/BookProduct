//
//  Utility.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import SystemConfiguration
import UIKit
import CoreData

class Utility: NSObject{
    
    //MARK: - Height/Width related
    class func convertHeightMultiplier(constant : CGFloat) -> CGFloat{
        let value = constant/896
        return value*UIScreen.main.bounds.height
    }
    
    public class func convertWidthMultiplier(constant : CGFloat) -> CGFloat{
        let value = constant/414
        return value*UIScreen.main.bounds.width
    }
    
    //MARK: - Netrork Check
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    //MARK: - Alert Related
    class func showAlert(_ VC: UIViewController, _ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default: print("default")
            case .cancel: print("cancel")
            case .destructive: print("destructive")
            default: break
            }}))
        DispatchQueue.main.async {
            VC.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Core data related
    
    class func isEntityEmpty(_ entity: Entity) -> Bool{
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
            let count  = try context.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    //MARK: - Cost Calculation
    
    class func daysBetween(start: Date, end: Date) -> Int {
        let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: start)!
        let end = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: end)!
        return Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
    }
    
    class func bookingCostCalculation(forDays: Int, type: PRODUCT_TYPE, cost: Int) -> Int{
        switch type{
        case .plain: return cost*forDays
        case .meter: return (cost*10)*forDays
        }
    }
}
