//
//  ProductVM.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//



import Foundation
import Combine
import FirebaseFirestore

class ProductVM: ObservableObject {
    @Published var product: Product
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(product: Product = Product(name: "", description: "", units: 0, cost: 0, price: 0, utility: 0)) {
        self.product = product
        
        self.$product
            .dropFirst()
            .sink {
                [weak self] product in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    // Firestore
    
    private var db = Firestore.firestore()
    
    private func addProduct(_ product: Product) {
        do {
            let _ = try db.collection("Products").addDocument(from: product)
        }
        catch {
            print(error)
        }
    }
    
    private func updateProduct(_ product: Product) {
        if let documentId = product.id {
            do {
                try db.collection("Products").document(documentId).setData(from: product)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func updateOrAddProduct() {
        if let _ = product.id {
            self.updateProduct(self.product)
        }
        else {
            addProduct(product)
        }
    }
    
    private func removeProduct() {
        if let documentId = product.id {
            db.collection("Products").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // UI handlers
    
    func handleDoneTapped() {
        self.updateOrAddProduct()
    }
    
    func handleDeleteTapped() {
        self.removeProduct()
    }
}
