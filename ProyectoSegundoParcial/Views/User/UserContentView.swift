//
//  UserContentView.swift
//  ProyectoSegundoParcial
//
//  Created by Jonatan Elizalde Gomez on 20/05/23.
//

import SwiftUI
struct UserContentView: View {
     
    @StateObject var viewModel = UsersVM() //UserViewModel.swift
    @State var presentAddUserSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddUserSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func userRowView(user: User) -> some View {
       NavigationLink(destination: UserDetailsView(user: user)) { //UserDetailsView.swift
         VStack(alignment: .leading) {
           Text(user.name)
             .font(.headline)
            Text(user.lastName)
             .font(.subheadline)
         }
       }
    }
     
    var body: some View {
      VStack {
        List {
          ForEach (viewModel.users) { user in
            userRowView(user: user)
          }
          .onDelete() { indexSet in
            //viewModel.removeUsers(atOffsets: indexSet)
            viewModel.removeUsers(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("User")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("UsersListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddUserSheet) {
          UserEditView() //UserEditView.swift
        }
         
      }// End Navigation
    }// End Body
}
 
 
struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
      UserContentView()
    }
}
