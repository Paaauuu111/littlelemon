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
                .font(.title.bold())
            
            HStack {
                Spacer()
                Image(.profilePlaceholder)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 170)
                    .cornerRadius(85)
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            .background(.themeGreen)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("First name: \(firstName)")
                Text("Last name: \(lastName)")
                Text("Email: \(email)")
                Button("Logout") {
                    UserDefaults.standard.set(false, forKey: kIsLoggedInKey)
                    presentation.wrappedValue.dismiss()
                }
                .frame(width: 142, height: 30, alignment: .center)
                .padding()
                .font(.title2)
                .foregroundStyle(.black)
                .background(.themeYellow)
                .cornerRadius(15)
            }
            .padding()
        }
    }
}

#Preview {
    UserProfile()
}
