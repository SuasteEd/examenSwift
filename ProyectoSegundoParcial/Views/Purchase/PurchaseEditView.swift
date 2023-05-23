import SwiftUI


struct PurchaseEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @ObservedObject var viewModel = PurchaseVM()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
        }
    }
    
    var saveButton: some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(mode == .new ? "Done" : "Save")
        }
        .disabled(!viewModel.modified)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle().scale(1.9).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.7).foregroundColor(.white)
                ScrollView(){
                    VStack {
                        
                        Text(mode == .new ? "New Purchase" : viewModel.purchase.productName )
                            .padding(.bottom, 30)
                        VStack(alignment: .leading) {
                            Label("Name", systemImage: "person")
                            TextField("Name", text: $viewModel.purchase.productName)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Product ID", systemImage: "barcode")
                            TextField("Product ID", text: $viewModel.purchase.productId)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Pieces", systemImage: "number")
                            TextField("Pieces", value: $viewModel.purchase.pieces, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Administrator ID", systemImage: "person.fill")
                            TextField("Administrator ID", value: $viewModel.purchase.idA, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.bottom, 10)
                        
                        saveButton
                            .padding(.bottom, 1)
                        
                        if mode == .edit {
                            Section {
                                Button("Delete Purchase") {
                                    self.presentActionSheet.toggle()
                                }
                                .foregroundColor(.red)
                            }
                        }
                    }
                    
                }
                .frame(height:550)
                
            }
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(
                    title: Text("Are you sure?"),
                    buttons: [
                        .destructive(
                            Text("Delete Purchase"),
                            action: { self.handleDeleteTapped() }
                        ),
                        .cancel()
                    ]
                )
            }
        }
    }
    
    // Action Handlers
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
        self.dismiss()
    }
    
    func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct PurchaseEditView_Previews: PreviewProvider {
    static var previews: some View {
        let purchase = Purchase(productName: "Sample title", productId: "3", pieces: 10, idA: "2")
        let purchaseViewModel = PurchaseVM(purchase: purchase)
        return PurchaseEditView(viewModel: purchaseViewModel, mode: .edit)
    }
}
