//
//  menuView.swift
//  ProyectoSegundoParcial
//
//  Created by ISSC_612_2023 on 24/04/23.
//

import SwiftUI

struct menuView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                
                VStack{
                    
                NavigationLink(destination: UserContentView(), label: {Text("Register")})
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(10).padding()
                NavigationLink(destination: ProductContentView(), label: {Text("Products")})
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(10).padding()
                NavigationLink(destination: PurchaseContentView(), label: {Text("Purchase")})
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(10).padding()
                NavigationLink(destination: SaleContentView(), label: {Text("Sales")})
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(10).padding()
                    Button("Return") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.foregroundColor(.blue)
                }
            }
        }
    }
    @Environment(\.presentationMode) var presentationMode
}

struct menuView_Previews: PreviewProvider {
    static var previews: some View {
        menuView()
    }
}
