//
//  UserEditView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}


struct UserEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = UserVM()
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
                            Text(mode == .new ? "New User" : viewModel.user.name + " " +  viewModel.user.lastName)
                                .padding(.bottom, 30)
                            VStack(alignment: .leading) {

                                Label("Name", systemImage: "person")
                                TextField("Name", text: $viewModel.user.name)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 20)
                            VStack(alignment: .leading) {
                                Label("LastName", systemImage: "person.fill")
                                TextField("LastName", text: $viewModel.user.lastName)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 20)
                            VStack(alignment: .leading) {
                                Label("Age", systemImage: "calendar")
                                TextField("Age", value:
                                    
                                    $viewModel.user.age,
                                formatter: NumberFormatter())
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                                    .keyboardType(.numberPad)
                            }
                            .padding(.bottom, 20)
                            VStack(alignment: .leading) {
                                Label("Gender", systemImage: "person.crop.circle")
                                TextField("Gender", text: $viewModel.user.gender)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 20)
                            VStack(alignment: .leading) {
                                Label("Username", systemImage: "person.crop.circle.badge.checkmark")
                                TextField("Username", text: $viewModel.user.email)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 20)
                            VStack(alignment: .leading) {
                                Label("Rol", systemImage: "person.2.square.stack")
                                TextField("Rol", text: $viewModel.user.role)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            VStack(alignment: .leading) {
                                Label("Password", systemImage: "lock")
                                TextField("Password", text: $viewModel.user.password)
                                    .padding()
                                    .frame(width: 300, height: 50)
                                    .background(Color.black.opacity(0.05))
                                    .cornerRadius(10)
                            }
                            .padding(.bottom, 10)

                            saveButton
                            .padding(.bottom, 1)

                        if mode == .edit {
                            Section {
                                Button("Delete User") {
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
                                Text("Delete User"),
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
 
//struct UserEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserEditView()
//    }
//}
 
struct UserEditView_Previews: PreviewProvider {
  static var previews: some View {
      let user = User(name: "Sample title", lastName: "Sample Description", age: 18, gender: "M", email: "user", role: "admin", password: "12345")
    let userViewModel = UserVM(user: user)
    return UserEditView(viewModel: userViewModel, mode: .edit)
  }
}

