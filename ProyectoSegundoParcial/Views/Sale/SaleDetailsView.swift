//
//  SaleDetailsView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
 
struct SaleDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditSaleSheet = false
    
    var sale: Sale
    
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
                Text(sale.productName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)

                Text(sale.productId)
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Id Costumer: \(sale.customerId)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Id Vendor: \(sale.vendorId)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Amount: \(sale.amount)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Pieces: \(sale.pieces)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Subtotal: \(sale.subtotal)")
                    .font(.subheadline)
                    .padding(.bottom, 5)
                
                Text("Total: \(sale.total)")
                    .font(.subheadline)
                    .padding(.bottom, 5)
                editButton {
                    self.presentEditSaleSheet.toggle()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .navigationBarItems(trailing: editButton {
            self.presentEditSaleSheet.toggle()
        })
        .onAppear() {
            print("SaleDetailsView.onAppear() for \(self.sale.productName)")
        }
        .onDisappear() {
            print("SaleDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditSaleSheet) {
            SaleEditView(viewModel: SaleVM(sale: sale), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct SaleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sale = Sale(productName: "Sample title", productId:"1", customerId: "10", vendorId: "5", amount: 10, pieces: 5, subtotal: 3000, total:10)
        return NavigationView {
            SaleDetailsView(sale: sale)
        }
    }
}
