//
//  UserProfile.swift
//  Littlelemon
//
//  Created by Paul on 31/12/2024.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    private let firstName = UserDefaults.standard.string(forKey: kFirstNameKey) ?? ""
    private let lastName = UserDefaults.standard.string(forKey: kLastNameKey) ?? ""
    private let email = UserDefaults.standard.string(forKey: kEmailKey) ?? ""
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text("First name: \(firstName)")
                .padding()
            Text("Last name: \(lastName)")
                .padding()
            Text("Email: \(email)")
                .padding()
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedInKey)
                presentation.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

#Preview {
    UserProfile()
}
