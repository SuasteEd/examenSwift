//
//  UserDetailsView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
 
struct UserDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditUserSheet = false
    
    var user: User
    
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
                
                Text(user.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(user.lastName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)

                Text("Age: \(user.age)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Gender: \(user.gender)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Username: \(user.email)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                Text("Role: \(user.role)")
                    .font(.subheadline)
                    .padding(.bottom, 5)
                Text("Password: \(user.password)")
                    .font(.subheadline)
                    .padding(.bottom, 5)

                editButton {
                    self.presentEditUserSheet.toggle()
                }
            }
            
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
        }
        .navigationBarItems(trailing: editButton {
            self.presentEditUserSheet.toggle()
        })
        .onAppear(){
            print("UserDetailsView.onAppear() for \(self.user.name)")
        }
        .onDisappear(){
            print("UserDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditUserSheet)
        {
            UserEditView(viewModel: UserVM(user: user), mode: .edit){ result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    struct UserDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            let user = User(name: "Sample title", lastName: "Sample Description", age: 18, gender: "M", email: "user", role: "admin", password: "12345")
            return
            NavigationView {
                UserDetailsView(user: user)
            }
        }
    }
}

