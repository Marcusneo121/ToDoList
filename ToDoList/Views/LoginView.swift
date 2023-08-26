//
//  LoginView.swift
//  ToDoList
//
//  Created by Marcus Neo on 20/08/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(
                    title: "To Do List",
                    subtitle: "Get things done",
                    angle: 15, background: .pink)
                // Login Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage).foregroundColor(Color.red)
                    }
                    TextField("Email Address", text: $viewModel.email)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    // .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Password", text: $viewModel.password)
                    // .textFieldStyle(RoundedBorderTextFieldStyle())
                    TLButton(title: "Log In", background: .blue) {
                        // attempt to log in
                        viewModel.login()
                    }
                }
                .offset(y: -50)

                // Create Account
                VStack {
                    Text("New around here?")
                    NavigationLink("Create An Account", destination: RegisterView())
                }
                .padding(.bottom, 50)

                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
