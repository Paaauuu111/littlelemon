//
//  Menu.swift
//  Littlelemon
//
//  Created by Paul Poucher on 31/12/2024.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little lemon")
                .padding()
            Text("Chicago")
                .padding()
            Text("Hey, welcome to little lemon located in Chicago :)")
                .padding()
            
            List {
                
            }
        }
        .padding()
    }
}

#Preview {
    Menu()
}
