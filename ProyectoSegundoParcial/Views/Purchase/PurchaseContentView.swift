//
//  PurchaseContentView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
struct PurchaseContentView: View {
     
    @StateObject var viewModel = PurchasesVM() //PurchaseViewModel.swift
    @State var presentAddPurchaseSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddPurchaseSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func purchaseRowView(purchase: Purchase) -> some
    View {
        NavigationLink(destination: PurchaseDetailsView(purchase: purchase)) { //PurchaseDetailsView.swift
         VStack(alignment: .leading) {
           Text(purchase.productName)
             .font(.headline)
             Text(String(purchase.pieces))
               .font(.subheadline)
         }
       }
    }
     
    var body: some View {
      NavigationView {
        List {
          ForEach (viewModel.purchases) { purchase in
            purchaseRowView(purchase: purchase)
          }
          .onDelete() { indexSet in
            //viewModel.removePurchases(atOffsets: indexSet)
              viewModel.removePurchases(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("Purchase")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("PurchasesListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddPurchaseSheet) {
          PurchaseEditView()
        }
         
      }
    }
}
 
 
struct PurchaseContentView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseContentView()
    }
}
