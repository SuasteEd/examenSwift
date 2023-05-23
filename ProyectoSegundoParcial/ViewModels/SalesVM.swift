//
//  SalesVM.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class SalesVM: ObservableObject {
  @Published var sales = [Sale]()
   
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
      listenerRegistration = db.collection("Sales").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.sales = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Sale.self)
        }
      }
    }
  }
   
  func removeSales(atOffsets indexSet: IndexSet) {
    let sales = indexSet.lazy.map { self.sales[$0] }
    sales.forEach { sale in
      if let documentId = sale.id {
        db.collection("Sales").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
