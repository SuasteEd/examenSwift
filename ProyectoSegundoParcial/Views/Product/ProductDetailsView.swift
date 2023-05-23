//
//  ProductDetailsView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
 
struct ProductDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditProductSheet = false
    
    var product: Product
    
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
                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)

                Text(product.description)
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Units: \(product.units)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Cost: \(product.cost)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Price: \(product.price)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Utility: \(product.utility)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                editButton {
                    self.presentEditProductSheet.toggle()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .navigationBarItems(trailing: editButton {
            self.presentEditProductSheet.toggle()
        })
        .onAppear() {
            print("ProductDetailsView.onAppear() for \(self.product.name)")
        }
        .onDisappear() {
            print("ProductDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditProductSheet) {
            ProductEditView(viewModel: ProductVM(product: product), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(name: "Sample title", description: "Sample Description", units: 10, cost: 5.0, price: 10.0, utility: 5.0)
        return NavigationView {
            ProductDetailsView(product: product)
        }
    }
}
