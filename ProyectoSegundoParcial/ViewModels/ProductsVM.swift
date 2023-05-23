//
//  UsersVM.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class ProductsVM: ObservableObject {
  @Published var products = [Product]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("Products").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.products = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Product.self)
        }
      }
    }
  }
   
  func removeProducts(atOffsets indexSet: IndexSet) {
    let products = indexSet.lazy.map { self.products[$0] }
      products.forEach { products in
      if let documentId = products.id {
        db.collection("Products").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
