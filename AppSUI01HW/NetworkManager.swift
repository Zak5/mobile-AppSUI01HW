//
//  NetworkManager.swift
//  AppSUI01HW
//
//  Created by Konstantin Zaharev on 04.12.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let foodCatalog = [
        Food(name: "Strawberry", calories: 33),
        Food(name: "Cheese", calories: 402),
        Food(name: "Apple", calories: 52),
        Food(name: "Tomato", calories: 18),
    ]

    private(set) var foodList: [Food] = []
    
    private(set) var lastFood: Food
    
    private(set) var totalCalories = 0
    
    var maxCalories = 1000

    private init() {
        foodList = foodCatalog
        lastFood = foodList[3]
        for food in foodList {
            totalCalories += food.calories
        }
    }
    
    func addFood(_ food: Food) {
        foodList.append(food)
        lastFood = food
        totalCalories += food.calories
    }
    
}
