//
//  PurchaseDetailsView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
 
struct PurchaseDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditPurchaseSheet = false
    
    var purchase: Purchase
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
                .foregroundColor(Color.blue)
                .font(.subheadline)
        }
    }
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Circle().scale(1.9).foregroundColor(.white.opacity(0.15))
            Circle().scale(1.7).foregroundColor(.white)
            VStack {
                Text(purchase.productName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text("ProductId: \(purchase.productId)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Pieces: \(purchase.pieces)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Ida: \(purchase.idA)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                editButton {
                    self.presentEditPurchaseSheet.toggle()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .navigationBarItems(trailing: editButton {
            self.presentEditPurchaseSheet.toggle()
        })
        .onAppear() {
            print("PurchaseDetailsView.onAppear() for \(self.purchase.productName)")
        }
        .onDisappear() {
            print("PurchaseDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditPurchaseSheet) {
            PurchaseEditView(viewModel: PurchaseVM(purchase: purchase), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct PurchaseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let purchase = Purchase(productName: "Sample title", productId: "1", pieces: 10, idA: "5")
        return NavigationView {
            PurchaseDetailsView(purchase: purchase)
        }
    }
}
