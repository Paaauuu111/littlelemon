//
//  Onboarding.swift
//  Littlelemon
//
//  Created by Paul on 31/12/2024.
//

import SwiftUI

let kFirstNameKey = "kFirstNameKey"
let kLastNameKey = "kLastNameKey"
let kEmailKey = "kEmailKey"
let kIsLoggedInKey = "kIsLoggedInKey"

struct Onboarding: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedInKey)
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("", destination: Home(), isActive: $isLoggedIn)
                               
                TextField("First name", text: $firstName)
                    .padding()
                TextField("Last name", text: $lastName)
                    .padding()
                TextField("Email", text: $email)
                    .padding()
                Button("Register") {
                    guard
                        !firstName.isEmpty
                            && !lastName.isEmpty
                            && !email.isEmpty
                    else {
                        return
                    }
                    
                    UserDefaults.standard.set(firstName, forKey: kFirstNameKey)
                    UserDefaults.standard.set(lastName, forKey: kLastNameKey)
                    UserDefaults.standard.set(email, forKey: kEmailKey)
                    UserDefaults.standard.set(true, forKey: kIsLoggedInKey)
                    
                    isLoggedIn = true
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    Onboarding()
}
