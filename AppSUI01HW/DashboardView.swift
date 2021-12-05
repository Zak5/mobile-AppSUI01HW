//
//  DashboardView.swift
//  AppSUI01HW
//
//  Created by Konstantin Zaharev on 03.12.2021.
//

import SwiftUI

final class DashboardViewModel: ObservableObject {
    
    @Published private(set) var lastFood: Food?
    @Published private(set) var calories: Int = 0
    @Published private(set) var progress: Float = 0.0

    func loadDashboardData() {
        lastFood = NetworkManager.shared.lastFood
        calories = NetworkManager.shared.totalCalories
        let maxCalories = NetworkManager.shared.maxCalories
        if maxCalories != 0 {
            progress = Float(calories) / Float(maxCalories)
        }
    }
    
}


struct DashboardView: View {
    
    @StateObject var dashboardViewModel: DashboardViewModel = .init()

    var body: some View {
        VStack {
            Spacer()
            ProgressBarView()
                .environmentObject(dashboardViewModel)
            Spacer()
            LastFoodView()
                .environmentObject(dashboardViewModel)
            Spacer()
            AddFoodButton()
            Spacer()
        }.onAppear { dashboardViewModel.loadDashboardData() }
    }
}

struct ProgressBarView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.green)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(dashboardViewModel.progress))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(/*@START_MENU_TOKEN@*/.linear/*@END_MENU_TOKEN@*/, value: dashboardViewModel.calories)

            Text("\(dashboardViewModel.calories) cal")
                .font(.title)
                .bold()
        }.frame(maxWidth: 300, maxHeight: 300)
            .padding()
    }
}

struct LastFoodView: View {
    
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        VStack {
            Text("last food is")
                .foregroundColor(Color.gray)
                .italic()
                .padding(.bottom, 10.0)

            if let food = dashboardViewModel.lastFood {
                LastFoodContentView(food: food)
            } else {
                Label("There's nothing yet", systemImage: "leaf")
            }
        }
    }
}

struct LastFoodContentView: View {
    
    @EnvironmentObject var contentViewModel: ContentViewModel

    var food: Food
    
    var body: some View {
        Button {
            contentViewModel.seletedTab = 1
            contentViewModel.seletedFood = food.name
        }
        label: {
            Label("\(food.name) (\(food.calories) cal)", systemImage: "leaf")
        }
    }
}


struct AddFoodButton: View {
    
    @State private var shouldAnimate = false
    
    var body: some View {
        VStack {
            ActivityIndicator(startAnimating: $shouldAnimate)
            Button {
                shouldAnimate = !shouldAnimate
            }
            label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
            }
            .frame(width: 50.0)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Circle())
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var startAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.startAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
.previewInterfaceOrientation(.portrait)
    }
}
