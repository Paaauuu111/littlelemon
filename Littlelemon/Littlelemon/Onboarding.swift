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
            VStack(spacing: 20) {
                NavigationLink("", destination: Home(), isActive: $isLoggedIn)
                          
                Image(.littleLemonLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300, alignment: .center)
                
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
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
                .foregroundStyle(.gray)
                .frame(width: 142, height: 30, alignment: .center)
                .padding()
                .font(.title2)
                .overlay(
                    /// apply a rounded border
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 2)
                )
            }
        }
        .padding()
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    Onboarding()
}
