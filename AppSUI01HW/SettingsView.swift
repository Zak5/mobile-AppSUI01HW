//
//  SettingsView.swift
//  AppSUI01HW
//
//  Created by Konstantin Zaharev on 03.12.2021.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    @Published private(set) var maxCalories: Int = 0

    func loadSettings() {
        maxCalories = NetworkManager.shared.maxCalories
    }
    
}

struct SettingsView: View {
    
    @StateObject var settingsViewModel: SettingsViewModel = .init()
    
    @State var showModalView: Bool = false
    
    var body: some View {
        List {
            Button  {
                showModalView = true
            }
            label: {
                Label("Max calories", systemImage: "info.circle")
            }
        }
        .sheet(isPresented: $showModalView) {
            MaxCaloriesSettingsView()
                .environmentObject(settingsViewModel)
        }
        .onAppear {
            settingsViewModel.loadSettings()
        }
    }
}

struct MaxCaloriesSettingsView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 50) {
            Text("\(settingsViewModel.maxCalories) cal")
            .font(.largeTitle)
          
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }, label: {
            Label("Close", systemImage: "xmark.circle")
          })
        }
    }
    
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
