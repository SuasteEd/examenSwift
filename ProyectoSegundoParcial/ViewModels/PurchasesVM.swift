//
//  PurchasesVM.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class PurchasesVM: ObservableObject {
  @Published var purchases = [Purchase]()
   
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
      listenerRegistration = db.collection("Purchases").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.purchases = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Purchase.self)
        }
      }
    }
  }
   
  func removePurchases(atOffsets indexSet: IndexSet) {
    let purchases = indexSet.lazy.map { self.purchases[$0] }
    purchases.forEach { purchase in
      if let documentId = purchase.id {
        db.collection("Purchases").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
