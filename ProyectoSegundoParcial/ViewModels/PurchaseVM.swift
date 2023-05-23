//
//  PurchaseVM.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class PurchaseVM: ObservableObject {
   
  @Published var purchase: Purchase
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(purchase: Purchase = Purchase(productName: "", productId: "", pieces: 0, idA: "")) {
    self.purchase = purchase
     
    self.$purchase
      .dropFirst()
      .sink { [weak self] purchase in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addPurchase(_ purchase: Purchase) {
    do {
      let _ = try db.collection("Purchases").addDocument(from: purchase)
    }
    catch {
      print(error)
    }
  }
   
  private func updatePurchase(_ purchase: Purchase) {
    if let documentId = purchase.id {
      do {
        try db.collection("Purchases").document(documentId).setData(from: purchase)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddPurchase() {
    if let _ = purchase.id {
      self.updatePurchase(self.purchase)
    }
    else {
      addPurchase(purchase)
    }
  }
   
  private func removePurchase() {
    if let documentId = purchase.id {
      db.collection("Purchases").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddPurchase()
  }
   
  func handleDeleteTapped() {
    self.removePurchase()
  }
   
}
