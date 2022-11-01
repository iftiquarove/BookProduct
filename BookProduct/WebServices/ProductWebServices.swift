//
//  ProductWebServices.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//


import Foundation

class ProductWebServices {
    static let shared = ProductWebServices()
    
    // --------------------- Get Musics by category ----------------------------------------
    // ===================== *********** =================================================
    
    func getAllProducts() -> [Product]{
        var products = [Product]()
        let url = Bundle.main.url(forResource: "productData" , withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            products = try jsonDecoder.decode([Product].self, from: jsonData)
        }
        catch {
            print("🔴 Can't parse music with err: ", error)
        }
        
        return products
    }
}

@propertyWrapper struct BundleFile<DataType: Decodable> {
    let name: String
    let type: String = "json"
    let fileManager: FileManager = .default
    let bundle: Bundle = .main
    let decoder = JSONDecoder()

    var wrappedValue: DataType {
        guard let path = bundle.path(forResource: name, ofType: type) else { fatalError("Resource not found") }
        guard let data = fileManager.contents(atPath: path) else { fatalError("File not loaded") }
        return try! decoder.decode(DataType.self, from: data)
    }
}
