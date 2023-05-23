//
//  purchseView.swift
//  ProyectoSegundoParcial
//
//  Created by ISSC_612_2023 on 24/04/23.
//

import SwiftUI

struct purchseView: View {
    @State private var name = ""
    @State private var pieces = ""
    @State private var IDA = ""
    @State private var showAlert = false
    @State private var message = ""
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
                           Circle().scale(1.9).foregroundColor(.white.opacity(0.15))
            Circle().scale(1.7).foregroundColor(.white)
            VStack{
                    Text("New Purchase").font(.largeTitle).bold().padding(.top,90)
 
                TextField("ProductID", text: $name).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                    TextField("Name", text: $name).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                    TextField("Pieces", text: $pieces).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                    TextField("IDA", text: $IDA).keyboardType(.numberPad).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10)
                
               
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
        if (!name.isEmpty && !pieces.isEmpty && !IDA.isEmpty) {
            message = "Information complete"
        } else {
            message = "Information incomplete"
        }
    }
}

struct purchseView_Previews: PreviewProvider {
    static var previews: some View {
        purchseView()
    }
}
