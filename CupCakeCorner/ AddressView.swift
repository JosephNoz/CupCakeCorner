//
//   AddressView.swift
//  CupCakeCorner
//
//  Created by Joseph Norris on 04/10/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order = Order()
    var body: some View {
        Form {
            Section{
                TextField( "enter your name", text: $order.name)
                
                TextField("enter your street address", text: $order.streetaddress)
                
                TextField("enter your city", text: $order.city)
                
                TextField("enter your postcode", text: $order.zip)
                
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
                

            }.disabled(order.hasValidAddress == false)
        } .navigationTitle("Delivery Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order())
        }
    }
}
