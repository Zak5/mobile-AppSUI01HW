//
//  ContentView.swift
//  AppSUI01HW
//
//  Created by Konstantin Zaharev on 02.12.2021.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var seletedTab: Int = 0
    @Published var seletedFood: String? = nil
    
}

struct ContentView: View {
    
    @StateObject var contentViewModel: ContentViewModel = .init()

    var body: some View {
        
        TabView(selection: $contentViewModel.seletedTab) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar")
                }
                .tag(0)
                .environmentObject(contentViewModel)
            FoodListView()
                .tabItem {
                    Label("Foods", systemImage: "menucard")
                }
                .tag(1)
                .environmentObject(contentViewModel)
           SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
