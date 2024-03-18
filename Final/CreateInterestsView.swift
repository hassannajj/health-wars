// CreateInterestsView.swift
// HealthWars


import SwiftUI



struct CreateInterestsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var interestsModel: InterestsModel // Use the data model
    
    
    @State private var nextRank: Int
    
    
    init(interestsModel: InterestsModel) {
        self.interestsModel = interestsModel
        _nextRank = State(initialValue: interestsModel.maxRank + 1)
    }

  let possibleInterests: [String] = ["hiking",
                                     "running",
                                     "cycling",
                                     "swimming",
                                     "meditating",
                                     "strength",
                                     "reading",
                                     "studying",
                                     "arts",
                                     "climbing",]
    @State private var refreshView = false // State variable to trigger view refresh

    
    
    
  var body: some View {
    NavigationView { // Wrap the view in NavigationView for navigation
      VStack {
        Text("Rank Your Interests")
          .font(.title)
          .padding()

        // Display a list of selectable interests
          List {
            ForEach(possibleInterests, id: \.self) { interest in
              HStack {
                Text(interest)
                Spacer()
                  if let rank = interestsModel.selectedInterests[interest] {
                      Text("\(rank)") // Display rank if selected
                          .foregroundColor(.orange)
                  }
              }
              .onTapGesture {
                          if let rank = interestsModel.selectedInterests[interest] {
                              if rank == interestsModel.selectedInterests.values.max() {
                                  interestsModel.selectedInterests.removeValue(forKey: interest)
                                  nextRank -= 1
                              }
                          } else {
                              interestsModel.selectedInterests[interest] = nextRank
                              nextRank += 1
                          }
                          // Toggle the state variable to trigger view refresh
                          self.refreshView.toggle()
                      }
                  }
              }

              Button(action: {
                  sendInterestDataToBackend() // BACKEND
                  presentationMode.wrappedValue.dismiss()
              }) {
                  Text("Save Interests")
                      .foregroundColor(.white)
                      .padding()
                      .background(Color.orange)
                      .cornerRadius(10)
              }
              .padding(.top)
          }
          .navigationBarTitle("Interests")
      }
      .onChange(of: refreshView) { _ in
          // This will be called whenever refreshView changes,
          // triggering the view refresh
      }
  }
    
    
    func sendInterestDataToBackend() {
        guard let url = URL(string: "http://localhost:4000/set_interests") else {
            print("Invalid URL")
            return
        }
        
        let userData = [
            "username": UserData.username,
            "interests": interestsModel.selectedInterests
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
//                    if responseString == "True" {
//                    }
                }
            }
        }.resume()
    }
}

struct CreateInterestsView_Previews: PreviewProvider {
  static var previews: some View {
    CreateInterestsView(interestsModel: InterestsModel())
  }
}
