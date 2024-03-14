//
//  ProfileView.swift
//  HealthWars
//
//  Created by Philip on 2/21/24.
//

import SwiftUI
import Foundation

class InterestsModel: ObservableObject {
    @Published var selectedInterests: [String: Int] = [:]
    

    var maxRank: Int {
        return selectedInterests.values.max() ?? 0
    }
}

struct ProfileView: View {
    @StateObject var interestsModel = InterestsModel() // Initialize the data model

    var body: some View {
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle() // Add a rectangle
                        .fill(Color.orange) // Make it orange
                        .frame(height: 60) // Set its height
                        .edgesIgnoringSafeArea(.top) // Extend to the top edge of the screen
                    Text("Profile") // Add a profile header
                        .font(.largeTitle)
                        .foregroundColor(.white) // Change color to white
                }
                .padding(.bottom)
                
                Image("profile-pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100) // Adjust size as needed
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray, lineWidth: 0.5)
                    )
                    .offset(x: 10)
                
                
                Text("Hi Ryan!") // Add a title
                    .font(.title)
                    .foregroundColor(.orange) // Change color to orange
                    .padding()
                VStack {
                    HStack {
                        Text("Distance: ")
                            .font(.title2)
                            .foregroundColor(.orange)
                        Spacer()
                        Text("23.41 miles")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        Text("Sleep: ")
                            .font(.title2)
                            .foregroundColor(.orange)
                        Spacer()
                        Text("6.89 hour/avg")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        Text("Calories: ")
                            .font(.title2)
                            .foregroundColor(.orange)
                        Spacer()
                        Text("1963")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                }
                Text("Interests:") // Add a title for achievements
                    .font(.title)
                    .foregroundColor(.orange)
                    .padding()
                
                
                // Display selected interests
                ForEach(interestsModel.selectedInterests.sorted(by: { $0.value < $1.value }), id: \.key) { interest, rank in
                    HStack {
                        Text("\(interest):".capitalized)
                            .font(.title2)
                            .foregroundColor(.orange)
                        Spacer()
                        Text("\(rank)")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                }
                
                
                // Add the button for interests
                NavigationLink(
                    destination:  CreateInterestsView(interestsModel: interestsModel),
                    label: {
                        Text("Add Interests")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                )
                .padding(.bottom)
                
                
            }
            .padding()
        }
    }
}
