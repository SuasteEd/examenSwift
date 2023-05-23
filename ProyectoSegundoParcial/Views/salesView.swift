//
//  salesView.swift
//  ProyectoSegundoParcial
//
//  Created by ISSC_612_2023 on 24/04/23.
//

import SwiftUI

struct salesView: View {
    @State private var name = ""
    @State private var quantity = ""
    @State private var ID_S = ""
    @State private var ID_P = ""
    @State private var pieces = ""
    @State private var Subtotal = ""
    @State private var Total = ""
    @State private var showAlert = false
    @State private var message = ""
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
                           Circle().scale(1.9).foregroundColor(.white.opacity(0.15))
            Circle().scale(1.7).foregroundColor(.white)
            VStack{
                    Text("New Purchase").font(.largeTitle).bold().padding(.top,90)
 
                    TextField("Name", text: $name).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                    TextField("Amount", text: $quantity).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                    TextField("Vendor ID", text: $ID_S).keyboardType(.numberPad).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                TextField("Customer ID", text: $ID_P).keyboardType(.numberPad).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                TextField("Pieces", text: $pieces).keyboardType(.numberPad).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                TextField("Subtotal", text: $Subtotal).keyboardType(.numberPad).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                TextField("Total", text: $Total).keyboardType(.numberPad).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                
               
                Button("Add") {
                    showAlert = true
                    validar()
                }.foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.bottom, 30).alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: Text("\(message)"), dismissButton: .default(Text("OK")))
                }
                
                Button("Return") {
                    self.presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.blue)

            }
        }
    }
    @Environment(\.presentationMode) var presentationMode
    
    func validar() {
        if (!name.isEmpty && !pieces.isEmpty && !Total.isEmpty) {
            message = "Information complete"
        } else {
            message = "Information incomplete"
        }
    }
}

struct salesView_Previews: PreviewProvider {
    static var previews: some View {
        salesView()
    }
}
