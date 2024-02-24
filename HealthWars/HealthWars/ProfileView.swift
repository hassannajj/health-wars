//
//  ProfileView.swift
//  HealthWars
//
//  Created by Philip on 2/21/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
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
            Text("Achievements!") // Add a title for achievements
                .font(.title)
                .foregroundColor(.orange)
                .padding()
            Spacer() // Pushes the buttons to the bottom
        }
        .padding()
    }
}

