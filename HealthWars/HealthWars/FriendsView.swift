//
//  FriendsView.swift
//  HealthWars
//
//  Created by Ryan on 2/21/24.
//


import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let steps: Int
    let screen_time: Float
}

struct FriendsView: View {
    let mySteps = 8207
    let players: [Player] = [
        Player(name: "Alice", steps: 11040, screen_time: 0.6),
        Player(name: "Bob", steps: 9456, screen_time: 1.3),
        Player(name: "You", steps: 8207, screen_time: 2.7),
        Player(name: "David", steps: 7021, screen_time: 3.6),
        Player(name: "Eve", steps: 6034, screen_time: 4.1)
    ]
    
    var body: some View {
        VStack {
            Spacer() // Pushes the first VStack to the top
            
            VStack {
                
                Text("Leaderboard")
                    .padding(.top, 35)
                    .font(.largeTitle)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white) // Set text color to white
                
                List(players.indices, id: \.self) { index in
                    let player = players[index]
                    
                    HStack {
                        Text("\(index + 1).") // Display rank
                            .font(.headline)
                        Text("\(player.name)")
                            .font(.body)
                        Spacer()
                        Text("\(player.steps) steps")
                            .font(.body)
                        Spacer()
                        Text("\(player.screen_time, specifier: "%.1f") hrs") // Format screen time to one decimal place
                            .font(.body)
                    }
                    .padding()
                    .background(player.name == "You" ? Color.orange : Color.white)
                    .cornerRadius(10) // Round corners of the List
                }
                .cornerRadius(20)
//                .listStyle(.plain)
            }
            .background(Color.orange)
            .cornerRadius(20) // Add corner radius for a modern look
//            .padding()
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("You need \(players.first!.steps - mySteps) steps to reach first place!")
                    .font(.body)
//                    .foregroundColor(.white)
                    .padding()
//                    .background(Color.gray)
                
                Button(action: {
                    // Add action to get recommendations nearby
//                    print("Get recommendations nearby tapped")
                }) {
                    Text("Get Recommendations Nearby")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        

                }
                .padding(.bottom, 55) // Add padding to the button
                

           .padding()

               
            }
//            .background(Color.orange)
            .cornerRadius(20) // Add corner radius for a modern look
            .padding()
            
        }
//        .background(Color.orange)
        .cornerRadius(20) // Add corner radius for a modern look
        .edgesIgnoringSafeArea(.all)
    }
}
