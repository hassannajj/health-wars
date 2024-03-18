//
//  AddFriendsView.swift
//  HealthWars
//
//  Created by MAC on 3/14/24.
//

import Foundation


import SwiftUI

struct AddFriendsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var friendsModel: FriendsModel // Use the data model
    

    
    // Replace possibleFriends with actual backend data instead of hardcore
  let possibleFriends: [Player] = [
    Player(name: "Emily", points: 80),
    Player(name: "David", points: 120),
    Player(name: "Sophia", points: 170),
    Player(name: "Ethan", points: 190),
    Player(name: "Olivia", points: 110),
    Player(name: "Michael", points: 130),
    Player(name: "Emma", points: 180),
    Player(name: "Alexander", points: 140),
    Player(name: "Ava", points: 160),
    Player(name: "James", points: 220),
    Player(name: "Isabella", points: 90),
    Player(name: "William", points: 250),
    Player(name: "Charlotte", points: 200),
    Player(name: "Daniel", points: 270),
    Player(name: "Mia", points: 120),
    Player(name: "Benjamin", points: 300),
    Player(name: "Sophie", points: 210)
  ]
    
    
    @State private var searchText = "" // State variable for search query
    
    var filteredFriends: [Player] {
      // Filter friends based on search query
      if searchText.isEmpty {
        return possibleFriends
      } else {
        return possibleFriends.filter { friend in
          friend.name.lowercased().contains(searchText.lowercased())
        }
      }
    }

    @State private var refreshView = false // State variable to trigger view refresh

    

    
  var body: some View {
    NavigationView {
      VStack {
          
          HStack {
            TextField("Search...", text: $searchText)
              .padding(.horizontal)
              
            Button(action: {
                let player = Player(name: searchText, points: 70)
                friendsModel.friends.append(player);
                refreshView.toggle(); // Trigger refresh
                sendAddFriendDataToBackend(friend: searchText);
                
                
            }) {
                Text("Add")
                    .foregroundColor(.blue)
            }

            Button(action: {
              // Clear search text on button click
              searchText = ""
            }) {
              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
                
            }
          }
          .padding(.bottom)

        // Display a list of friends
          List {
              ForEach(filteredFriends) { friend in  // LEFT OFF RIGHT HERE
                  HStack {
                    Text(friend.name)
                      
                      Spacer()
                          
                              // Check if friend is already in self.friends
                              if friendsModel.friends.contains(where: { $0.name == friend.name }) {
                                  
                                  Image(systemName: "checkmark.circle.fill")
                                      .foregroundColor(.orange)
                              }
                                else {
                                  // Add button if not a friend
                                  Button(action: {
                                      friendsModel.friends.append(friend)
                                      refreshView.toggle() // Trigger refresh
                                      
                                  }) {
                                      Text("Add")
                                          .foregroundColor(.blue)
                                  }
                              }
                      
                      
                      
                        }
                      
                        

                  }
              }

              Button(action: {
                  presentationMode.wrappedValue.dismiss()
              }) {
                  Text("Back")
                      .foregroundColor(.white)
                      .padding()
                      .background(Color.orange)
                      .cornerRadius(10)
              }
              .padding(.top)
          }
          .navigationBarTitle("Add Friends")
      }
      .onChange(of: refreshView) { _ in
          // This will be called whenever refreshView changes,
          // triggering the view refresh
      }
  }
    
    
    
    func sendAddFriendDataToBackend(friend: String) {
        guard let url = URL(string: "http://localhost:4000/set_friend") else {
            print("Invalid URL")
            return
        }
        
        let userData = [
            "user_name1": UserData.username,
            "user_name2": friend
        ] as [String : Any]
        
    
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: userData) else {
            print("Error serializing JSON")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
            
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
            }
        }.resume()
    }
}

struct AddFriendsView_Previews: PreviewProvider {
  static var previews: some View {
    AddFriendsView(friendsModel: FriendsModel())
  }
}



//struct UserView: View {
//  let player: Player
//
//  var body: some View {
//    VStack {
//      Text(player.name)
//        .font(.title)
//      Text("Screen Time: \(player.screen_time, specifier: "%.2f")")
//      Text("Steps: \(player.steps)")
//    }
//  }
//}
