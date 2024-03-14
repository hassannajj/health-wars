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
    

    
//    init(friendsModel: FriendsModel) {
//        self.friendsModel = friendsModel
//        //_nextRank = State(initialValue: friendsModel.maxRank + 1) // Fix this line?
//    }

    
    // Replace possibleFriends with actual backend data instead of hardcore
  let possibleFriends: [Player] = [
    Player(name: "Charlie", steps: 12542, screen_time: 0.9),
    Player(name: "Olivia", steps: 10890, screen_time: 1.6),
    Player(name: "Liam", steps: 9745, screen_time: 2.1),
    Player(name: "Sophia", steps: 8602, screen_time: 2.4),
    Player(name: "Noah", steps: 7511, screen_time: 3.2),

    Player(name: "Mia", steps: 6423, screen_time: 3.8),
    Player(name: "William", steps: 13215, screen_time: 0.4),
    Player(name: "Ava", steps: 11583, screen_time: 1.0),
    Player(name: "James", steps: 10432, screen_time: 1.7),
    Player(name: "Isabella", steps: 9289, screen_time: 2.2),

    Player(name: "Benjamin", steps: 8198, screen_time: 2.9),
    Player(name: "Charlotte", steps: 7109, screen_time: 3.5),
    Player(name: "Lucas", steps: 14023, screen_time: 0.2),
    Player(name: "Amelia", steps: 12391, screen_time: 0.7),
    Player(name: "Mason", steps: 11240, screen_time: 1.4),
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
