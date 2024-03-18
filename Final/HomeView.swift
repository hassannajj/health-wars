//
//  HomeView.swift
//  HealthWars
//
//  Created by Hassan on 2/21/24.
//

import SwiftUI


var recs: [Rec] = []

struct Rec: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let score: Float
}



struct HomeView: View {
    @State var recs = [Rec]()
    var emojiDictionary = [
        "hiking": "🥾",
        "cycling": "🚴‍♂️",
        "running": "🏃‍♂️",
        "swimming": "🏊‍♂️",
        "climbing": "🧗",
        "meditating": "🧘",
        "strength": "🏋️‍♀️",
        "reading": "📖",
        "studying": "🤓",
        "arts": "🎨"
    ]
    func getRecomendationDataFromBackend() {
        guard let url = URL(string: "http://localhost:4000/get_recs") else {
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
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Any]] {
                        var itemList: [Rec] = []
                        for (key, value) in json {
                            let strCategory = value[0] as? String ?? ""
                            let floatScore = value[1] as? Float ?? 0.0
                            let item = Rec(title: key, category: strCategory, score: floatScore)
                            itemList.append(item)
                        }
                        // Sort itemList by points
                        itemList.sort(by: { $0.score > $1.score })
                        DispatchQueue.main.async {
                            self.recs = itemList // Update the state on the main queue
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

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
            HStack {
                Spacer()
                VStack {
                    Text("Activity").bold()
                    Image("steps")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                    Text("8207").bold() + Text(" steps")
                }
                Spacer()
                VStack {
                    Text("Sleep").bold()
                    Image("sleep")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                    Text("7.5").bold() + Text(" hrs")
                }

                
                Spacer()
                VStack {
                    Text("Screen Time").bold()
                    Image("screen-time")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                        .offset(x: 10)
                    Text("4.6").bold() + Text(" hrs")
                }
                Spacer()
            }
            .padding(.bottom, 30)
            Spacer()
            
            
            Button(action: {
                getRecomendationDataFromBackend()
            }) {
                Text("Get Recommendations")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
                    
            }
        
            VStack(alignment: .leading, spacing: 10) {
                
                
                ForEach(recs, id: \.title) { recommendation in
                    VStack(alignment: .leading) {
                        Text("\(emojiDictionary[recommendation.category] ?? "") \(recommendation.title)")
                            .font(.headline)
                        Text("Category: \(recommendation.category)")
                            .font(.subheadline)
//                        Text("Score: \(recommendation.score)")
//                            .font(.subheadline)
                    }
                }
            }
            Spacer()
        }

    }
}
