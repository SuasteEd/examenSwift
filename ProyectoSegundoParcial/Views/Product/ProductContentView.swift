//
//  ProductContentView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
struct ProductContentView: View {
     
    @StateObject var viewModel = ProductsVM() //ProductViewModel.swift
    @State var presentAddProductSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddProductSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func productRowView(product: Product) -> some
    View {
        NavigationLink(destination: ProductDetailsView(product: product)) { //ProductDetailsView.swift
         VStack(alignment: .leading) {
           Text(product.name)
             .font(.headline)
            Text(product.description)
             .font(.subheadline)
         }
       }
    }
     
    var body: some View {
      NavigationView {
        List {
          ForEach (viewModel.products) { product in
            productRowView(product: product)
          }
          .onDelete() { indexSet in
            //viewModel.removeProducts(atOffsets: indexSet)
              viewModel.removeProducts(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("Product")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("ProductsListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddProductSheet) {
          ProductEditView()
        }
         
      }
    }
}
 
 
struct ProductContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductContentView()
    }
}
