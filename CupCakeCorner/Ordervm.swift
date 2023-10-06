//
//  order.swift
//  CupCakeCorner
//
//  Created by Joseph Norris on 04/10/2023.
//

import SwiftUI



class Order : ObservableObject, Codable {
    enum Codingkeys: CodingKey {
        case type, quantity, addsprinkles, extrafrosting, name, streetaddress, city, zip
    }
    
    static let types = ["vanilla","chocolate","strawberry","mint"]
    
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialrequestEnabled = false{
        didSet{ if specialrequestEnabled == false {
            extrafrosting = false
            addsprinkles = false
        }}
    }
        @Published var extrafrosting = false
        @Published var addsprinkles = false
    
    @Published var name = ""
    @Published var streetaddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress : Bool {
        if name.isEmpty || streetaddress.isEmpty || city.isEmpty || zip.isEmpty {
                return false
    }
   
        return true
    
        }
    
    var cost : Double {
        
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extrafrosting {
            cost += Double(quantity)
        }
        
        
        if addsprinkles{
            cost += Double(quantity) / 2
        }
        return cost
        
        
       
    }
    
    
    init() {} 
    
    func encode(to encoder :Encoder) throws {
        var container = encoder.container(keyedBy: Codingkeys.self )
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(addsprinkles, forKey: .addsprinkles)
        try container.encode(extrafrosting, forKey: .extrafrosting)
        try container.encode(name, forKey: .name)
        try container.encode(streetaddress, forKey: .streetaddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        addsprinkles = try container.decode(Bool.self, forKey: .addsprinkles)
        extrafrosting = try container.decode(Bool.self, forKey: .extrafrosting)
        name = try container.decode(String.self, forKey: .name)
        streetaddress = try container.decode(String.self, forKey: .streetaddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
       
    }
    
    
    
    
    
    
    }



    
    
    


