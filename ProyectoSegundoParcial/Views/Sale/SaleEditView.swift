import SwiftUI


struct SaleEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @ObservedObject var viewModel = SaleVM()
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
                        Text(mode == .new ? "New Sale" : viewModel.sale.productName )
                            .padding(.bottom, 30)
                        VStack(alignment: .leading) {
                            Label("Name", systemImage: "person")
                            TextField("Name", text: $viewModel.sale.productName)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Product ID", systemImage: "barcode")
                            TextField("Product ID", text: $viewModel.sale.productId)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Costumer ID", systemImage: "person.2")
                            TextField("Costumer ID", value: $viewModel.sale.customerId, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Vendor ID", systemImage: "building.2")
                            TextField("Vendor ID", value: $viewModel.sale.vendorId, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                                .padding(.bottom, 20)

                            Label("Amount", systemImage: "dollarsign.square")
                            TextField("Amount", value: $viewModel.sale.amount, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                        }

                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Pices", systemImage: "square.grid.2x2")
                            TextField("Pices", value: $viewModel.sale.pieces, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Subtotal", systemImage: "sum")
                            TextField("Subtotal", value: $viewModel.sale.subtotal, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Total", systemImage: "equal.circle")
                            TextField("Total", value: $viewModel.sale.total, formatter: NumberFormatter())
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


struct SaleEditView_Previews: PreviewProvider {
    static var previews: some View {
        let sale = Sale(productName: "Sample title", productId: "1", customerId: "10", vendorId: "5", amount: 9.99, pieces: 4, subtotal: 10, total: 20)
        let saleViewModel = SaleVM(sale: sale)
        return SaleEditView(viewModel: saleViewModel, mode: .edit)
    }
}
