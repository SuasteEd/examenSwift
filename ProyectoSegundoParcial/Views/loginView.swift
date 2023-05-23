//
//  loginView.swift
//  ProyectoSegundoParcial
//
//  Created by ISSC_612_2023 on 24/04/23.
//

import SwiftUI

struct loginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var mensaje = ""
    @State private var wrongUser = 0
    @State private var wrongPassword = 0
    
    var body: some View {
        
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack {
                    Text("Login").font(.largeTitle).bold().padding()
                        
                    TextField("Username", text: $email).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(wrongUser))
                    SecureField("Password", text: $password).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(wrongPassword))
                    
                    NavigationLink(destination: menuView(), label: {Text("Sign in")}).foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding()
                    NavigationLink(destination: UserEditView(), label: {Text("Sign up")})
                }
            }
        }
    
    
    func validar(){
        if (!email.isEmpty && !password.isEmpty) {
                mensaje = "Information complete"
        } else {
            mensaje = "Information incomplete"
        }
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
