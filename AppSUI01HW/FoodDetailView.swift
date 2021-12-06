//
//  FoodDetailView.swift
//  AppSUI01HW
//
//  Created by Konstantin Zaharev on 05.12.2021.
//

import SwiftUI

struct FoodDetailView: View {
    
    let food: Food
    
    var body: some View {
        NavigationView {
            List {
                Section("Properties") {
                    Text("Name: \(food.name)")
                    Text("Calories: \(food.calories) cal")
                }
            }
            .navigationTitle(food.name)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: Food(name: "Test food", calories: 99))
    }
}
