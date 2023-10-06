//
//  CheckoutVIew.swift
//  CupCakeCorner
//
//  Created by Joseph Norris on 04/10/2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationmessage = ""
    @State private var showingconfirmation = false
    var body: some View {
        
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://www.hackingwithswift.com/samples/img/cupcakes@3x.jpg"), scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                }placeholder: {
                    ProgressView()
                        
                }
                .frame(height: 233)
                
                Text("your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                
                Button("Place Order") {
                    Task{
                        await placeorder() }
                }

               
                    .padding()
                        
                    
                    
                }
            
            }
        
        .navigationTitle("checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you" ,isPresented: $showingconfirmation){
            Button("ok") {}
            
        }message: { Text(confirmationmessage) }
            
        }
        
            
        

func placeorder() async {
    
    guard let encoded = try? JSONEncoder().encode(order)
else {
    print("error")
    return
}
    
    let url = URL(string: "https://regres.in/api/cupcakes")!
    
    var request = URLRequest(url: url)
    request.setValue("application/json",  forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    
    
    do{
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        
        let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
        confirmationmessage = ("your order \(decodedOrder.quantity) x \(Order.types [decodedOrder.type].lowercased()) cupcakes are on its way")
        
        showingconfirmation = true
        
    }catch{
        print("error")
    }
}
    
    
    
}
    


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            
            CheckoutView(order: Order())
        }
    }
}
