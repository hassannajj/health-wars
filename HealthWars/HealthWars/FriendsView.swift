//
//  FriendsView.swift
//  HealthWars
//
//  Created by Ryan on 2/21/24.
//


import SwiftUI

class FriendsModel: ObservableObject {
    @Published var friends: [Player] // Array of Player instances
    
    init() {
        //self.friends  = getLeaderboardDataFromBackend();
        self.friends = []
    }
}

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let points: Int
}

struct FriendsView: View {
    let myPoints = 200
    @StateObject var friendsModel = FriendsModel() // Initialize the data model
        
    var body: some View {
        NavigationView{
            
            VStack {
                Spacer() // Pushes the first VStack to the top
                
                VStack {
                    
                    Text("Leaderboard")
                        .padding(.top, 35)
                        .font(.largeTitle)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white) // Set text color to white
                    
                    List(friendsModel.friends.indices, id: \.self) { index in
                        let player = friendsModel.friends[index]
                        
                        HStack {
                            Text("\(index + 1).") // Display rank
                                .font(.headline)
                            Text("\(player.name)")
                                .font(.body)
                            Spacer()
                            Text("\(player.points) points")
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
                    Text("You need \(friendsModel.friends.first!.points - myPoints) points to reach first place!")
                        .font(.body)
                    //                    .foregroundColor(.white)
                        .padding()
                    //                    .background(Color.gray)
                    
                    NavigationLink(
                        destination:  AddFriendsView(friendsModel: friendsModel),
                        label: {
                            Text("Add Friends")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                    )
                    .padding(80)
                    
                    
                    
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

}

struct Previews_FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


//func getLeaderboardDataFromBackend() -> [Player] {
//    var playerList : [Player] = []
//    guard let url = URL(string: "http://localhost:4000/get_leaderboard") else {
//        print("Invalid URL")
//        return [];
//    }
//
//    let userData = [
//        "username": UserData.username,
//    ] as [String : Any]
//
//
//
//    guard let jsonData = try? JSONSerialization.data(withJSONObject: userData) else {
//        print("Error serializing JSON")
//        return [];
//    }
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpBody = jsonData
//
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error: \(error.localizedDescription)")
//            return
//        }
//
//        if let response = response as? HTTPURLResponse {
//            print("Response status code: \(response.statusCode)")
//        }
//
//        do {
//            if let data = data {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Int] {
//                    // Process the JSON dictionary here
//                    var itemList: [Player] = []
//                    for (key, value) in json {
//                        let item = Player(name: key, points: value)
//                        itemList.append(item)
//                    }
//                    playerList = itemList;
//                    // Now itemList contains a list of Item objects
//                    print("Received Item list: \(itemList)")
//                }
//            }
//        }catch
//        {
//                        print("Error parsing JSON: \(error.localizedDescription)")
//                    }
//
//        }
//    .resume()
//    return playerList;
//}
