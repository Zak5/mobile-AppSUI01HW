//
//  FoodListView.swift
//  AppSUI01HW
//
//  Created by Konstantin Zaharev on 03.12.2021.
//

import SwiftUI

final class FoodListViewModel: ObservableObject {
    
    @Published private(set) var foods: [Food] = []

    func loadFoods() {
        foods = NetworkManager.shared.foodList
    }
    
}


struct FoodListView: View {
    
    @StateObject var foodListViewModel: FoodListViewModel = .init()
    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        NavigationView {
            List(foodListViewModel.foods) { food in
                NavigationLink(
                    destination: FoodDetailView(food: food),
                    tag: food.name,
                    selection: $contentViewModel.seletedFood,
                    label: {FoodRowView(food: food)})
            }
            .listStyle(.plain)
            .navigationTitle("Foods")
        }.onAppear {
            foodListViewModel.loadFoods()
        }
    }
}


struct FoodRowView: View {
    
    var food: Food
    
    var body: some View {
        Label(food.name, systemImage: "leaf")
    }
    
}
