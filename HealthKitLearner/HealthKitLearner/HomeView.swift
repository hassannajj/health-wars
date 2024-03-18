//
//  HomeView.swift
//  HealthKitLearner
//
//  Created by Angela on 3/7/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        
        VStack{
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                ForEach(manager.activities.sorted(by: { $0.value.id <  $1.value.id }), id: \.key) { item in
                    ActivityCard(activity: item.value)
                    
                }
                //ActivityCard( activity:   Activity(id: 5, title: "STEPS", subtitle: "STEP GOAL : 10,000", image: "figure.walk", amount: "6,666"))
                //ActivityCard()
            }
            .padding(.horizontal)
        }
    }
}
