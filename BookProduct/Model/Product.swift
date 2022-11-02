//
//  Product.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import Foundation

enum PRODUCT_TYPE: String, Codable{
    case meter
    case plain
}

enum Entity: String{
    case Products
    case BookingProducts
}

struct Product: Codable{
    var productName: String?
    var productCode: String?
    var productType: String?
    var productAvailibility: Bool?
    var needRepair: Bool?
    var currentDurability: Int?
    var maxDurability: Int?
    var mileage: Int? = 0
    var price: Int?
    var minimumRentDays: Int?
    
    enum CodingKeys: String, CodingKey {
        case productName = "name"
        case productCode = "code"
        case productType = "type"
        case productAvailibility = "availability"
        case needRepair = "needing_repair"
        case currentDurability = "durability"
        case maxDurability = "max_durability"
        case mileage = "mileage"
        case price = "price"
        case minimumRentDays = "minimum_rent_period"
    }
}

struct BookingProduct: Codable{
    var productName: String?
    var productCode: String?
    var productType: String?
    var productAvailibility: Bool?
    var needRepair: Bool?
    var currentDurability: Int?
    var maxDurability: Int?
    var mileage: Int? = 0
    var price: Int?
    var minimumRentDays: Int?
    var bookingDate: Date?
    var returnDate: Date?
}
