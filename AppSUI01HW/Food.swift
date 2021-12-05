//
//  Food.swift
//  AppSUI01HW
//
//  Created by Konstantin Zaharev on 04.12.2021.
//

import Foundation

struct Food: Identifiable {
    var id: String { name }
    let name: String
    let calories: Int
}
