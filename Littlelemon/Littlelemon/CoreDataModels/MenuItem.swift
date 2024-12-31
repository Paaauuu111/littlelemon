//
//  MenuItem.swift
//  Littlelemon
//
//  Created by Paul on 31/12/2024.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let price: String
}
