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
//
        self.friends = [Player(name: "name1", points: 50)]
//        self.friends  = getLeaderboardDataFromBackend();
    }
}

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let points: Int
}

struct FriendsView: View {
    @State var players = [Player]()
    let myPoints = 200
    @StateObject var friendsModel = FriendsModel() // Initialize the data model

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                VStack {
                    Text("Leaderboard")
                        .padding(.top, 35)
                        .font(.largeTitle)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)

                    List(players.indices, id: \.self) { index in
                        let player = players[index]

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
                        .cornerRadius(10)
                    }
                    .cornerRadius(20)
                }
                .background(Color.orange)
                .cornerRadius(20)
                .edgesIgnoringSafeArea(.all)
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        // Action to perform when the button is tapped
                        getLeaderboardDataFromBackend()
                    }) {
                        Text("Fetch Leaderboard")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    NavigationLink(
                        destination: AddFriendsView(friendsModel: friendsModel),
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
                .cornerRadius(20)
                .padding()
            }
            .cornerRadius(20)
            .edgesIgnoringSafeArea(.all)
        }
    }

    func getLeaderboardDataFromBackend() {
        guard let url = URL(string: "http://localhost:4000/get_leaderboard") else {
            print("Invalid URL")
            return
        }

        let userData = [
            "username": UserData.username,
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

            do {
                if let data = data {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Int] {
                        var itemList: [Player] = []
                        for (key, value) in json {
                            let item = Player(name: key, points: value)
                            itemList.append(item)
                        }
                        // Sort itemList by points
                        itemList.sort(by: { $0.points > $1.points })
                        DispatchQueue.main.async {
                            self.players = itemList // Update the state on the main queue
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

}


//struct Previews_FriendsView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}


//func getLeaderboardDataFromBackend() -> [Player] {
////    var playerList : [Player] = []
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
//    request.httpMethod = "POST"
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
//                    return itemList;
//                    // Now itemList contains a list of Item objects
////                    print("Received player list: \(playerList)")
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
