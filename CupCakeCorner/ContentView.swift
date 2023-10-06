//
//  ContentView.swift
//  CupCakeCorner
//
//  Created by Joseph Norris on 04/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Pick your flavor", selection: $order.type){
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes \(order.quantity)", value: $order.quantity, in: 0...20)
                }
                
                Section{
                    
                    Toggle("any special requests?" , isOn: $order.specialrequestEnabled.animation())
                    
                    if order.specialrequestEnabled == true
                    { Toggle("extra frosting?", isOn: $order.extrafrosting)
                        Toggle("any sprinkles?", isOn: $order.addsprinkles)
     
                    }
                    
                    
                }
                
                Section{
                    
                    NavigationLink{ AddressView(order: order)} label: {
                        Text("address details")
                    }
                    
                   
                   
                }
                }
               
            .navigationTitle("Cupcake Corner")
            
            }
            
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
