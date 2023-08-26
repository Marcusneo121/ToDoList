//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Marcus Neo on 20/08/2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    init() {}

    func register() {
        guard validate() else {
            return
        }

        // Try register
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, _ in
            guard let userId = result?.user.uid else {
                return
            }

            self?.insertUserRecord(id: userId)
        }
    }

    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)

        let db = Firestore.firestore()

        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }

    func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email."
            return false
        }

        guard password.count >= 6 else {
            errorMessage = "Please enter at least 6 character password."
            return false
        }

        return true
    }
}
