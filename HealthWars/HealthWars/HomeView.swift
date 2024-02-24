//
//  HomeView.swift
//  HealthWars
//
//  Created by Hassan on 2/21/24.
//

import SwiftUI

struct HomeView: View {
    
    let hikeRecommendations = [
        "Hike 1: Mountain Trail",
        "Hike 2: Lakeview Loop",
        "Hike 3: Forest Adventure"
    ]

    var body: some View {
        VStack {
                            
                Text("    Your Stats This Week    ")
                    .padding(.top, 35)
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white) // Set text color to white
                    .background(Color.orange)
                    .cornerRadius(20) // Add corner radius for a modern look
                    .edgesIgnoringSafeArea(.all)
            
            Spacer()
            VStack {
                VStack {
                    Image("applewatch-ring")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                    Text("8207").bold() + Text(" Steps")
                }

                VStack {
                    Image("applewatch-ring")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                    Text("12").bold() + Text(" Flights Climbed")
                }

                
                
                VStack {
                    Image("screen-time")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                        .offset(x: 10)
                    Text("17").bold() + Text(" hrs Screen Time")
                }
            }
            .padding(.bottom, 30)

            Text("Recommendations")
                .font(.largeTitle)
                .padding()
                .background(Color.orange)
                .cornerRadius(8)
        
            VStack(alignment: .leading, spacing: 10) {
                ForEach(hikeRecommendations, id: \.self) { recommendation in
                    Text("🥾 \(recommendation)")
                        .font(.headline)
                }
            }
            Spacer()
        }

    }
}
