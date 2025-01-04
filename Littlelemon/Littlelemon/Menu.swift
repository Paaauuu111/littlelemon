//
//  Menu.swift
//  Littlelemon
//
//  Created by Paul on 31/12/2024.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Little lemon")
                        .font(.title.bold())
                        .foregroundStyle(.themeYellow)
                    Text("Chicago")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .bold()
                    Text("Little Lemon is a charming neighborhood bistro thatserves simple food and  classic cocktails in a lively but casual environment. The restaurant features a locally-sourced menu with daily specials.")
                        .foregroundStyle(.white)
                }
                .padding(20)
                .background(Color(.themeGreen))
                
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
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
            .searchable(text: $searchText, prompt: "Search menu")
            .navigationTitle("Order for delivery!")
            .navigationBarTitleDisplayMode(.large)
            .onAppear() {
                getMenuData()
            }
            .padding()
        }
    }
    
    private func getMenuData() {
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
    
    private func buildPredicate() -> NSPredicate {
        return searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title",
                             ascending: true,
                             selector:
                                #selector(NSString .localizedStandardCompare))
        ]
    }
}

#Preview {
    Menu()
}
