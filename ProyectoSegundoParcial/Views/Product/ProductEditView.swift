import SwiftUI


struct ProductEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @ObservedObject var viewModel = ProductVM()
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
                        Text(mode == .new ? "New Product" : viewModel.product.name )
                            .padding(.bottom, 30)
                        VStack(alignment: .leading) {
                            Label("Name", systemImage: "person")
                            TextField("Name", text: $viewModel.product.name)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Description", systemImage: "text.justify")
                            TextField("Description", text: $viewModel.product.description)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Units", systemImage: "number.circle")
                            TextField("Units", value: $viewModel.product.units, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Cost", systemImage: "dollarsign.circle")
                            TextField("Cost", value: $viewModel.product.cost, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Price", systemImage: "dollarsign.square")
                            TextField("Price", value: $viewModel.product.price, formatter: NumberFormatter())
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.bottom, 20)
                        VStack(alignment: .leading) {
                            Label("Utility", systemImage: "dollarsign.square.fill")
                            TextField("Utility", value: $viewModel.product.utility, formatter: NumberFormatter())
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
                                Button("Delete Product") {
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
                            Text("Delete Product"),
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

struct ProductEditView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(name: "Sample title", description: "Sample Description", units: 10, cost: 5.99, price: 9.99, utility: 4.00)
        let productViewModel = ProductVM(product: product)
        return ProductEditView(viewModel: productViewModel, mode: .edit)
    }
}
