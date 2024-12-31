//
//  Menu.swift
//  Littlelemon
//
//  Created by Paul Poucher on 31/12/2024.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Text("Little lemon")
                .padding()
            Text("Chicago")
                .padding()
            Text("Hey, welcome to little lemon located in Chicago :)")
                .padding()
            
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id:\.self) { dish in
                        HStack {
                            if let imageUrl = dish.image,
                               let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { result in
                                    result.image?
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 150, height: 150, alignment: .center)
                                    
                            }
                            
                            Text("\(dish.title ?? "")\nPrice: \(dish.price ?? "")")
                        }
                    }
                }
            }
        }
        .onAppear() {
            getMenuData()
        }
        .padding()
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let filePath = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: filePath) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            let decoder = JSONDecoder()
            
            if let menuList = try? decoder.decode(MenuList.self, from: data) {
                for menuItem in menuList.menu {
                    let dish = Dish(context: viewContext)
                    dish.title = menuItem.title
                    dish.image = menuItem.image
                    dish.price = menuItem.price
                }
                
                try? viewContext.save()
            }
            
        }
        
        task.resume()
        
    }
}

#Preview {
    Menu()
}
