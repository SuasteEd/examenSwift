//
//  SaleContentView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
struct SaleContentView: View {
     
    @StateObject var viewModel = SalesVM() //SaleViewModel.swift
    @State var presentAddSaleSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddSaleSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func saleRowView(sale: Sale) -> some
    View {
        NavigationLink(destination: SaleDetailsView(sale: sale)) { //SaleDetailsView.swift
         VStack(alignment: .leading) {
           Text(sale.productId)
             .font(.headline)
            Text(String(sale.total))
             .font(.subheadline)
         }
       }
    }
     
    var body: some View {
      NavigationView {
        List {
          ForEach (viewModel.sales) { sale in
            saleRowView(sale: sale)
          }
          .onDelete() { indexSet in
            //viewModel.removeSales(atOffsets: indexSet)
              viewModel.removeSales(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("Sale")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("SalesListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddSaleSheet) {
          SaleEditView()
        }
         
      }
    }
}
 
 
struct SaleContentView_Previews: PreviewProvider {
    static var previews: some View {
        SaleContentView()
    }
}
