//  ContentView.swift
//  HealthWars
//
//  Created by Angela on 2/21/24.
//
//  Notes: This is the starter login page, pressing Sign In Button will take
//  user to the home page with the navigation tabs at the bottom. No backend implemented.

import SwiftUI

class UserData {
    static var username: String = "";
}

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignUpActive: Bool = false
    @State private var isSignInActive: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Health Wars")
                    .font(.largeTitle)
                    .padding()

                TextField("Username", text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack {
                    Button("Sign In") {
                        sendSignInDataToBackend()
                        UserData.username = username;
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 247/255, green: 141/255, blue: 42/255))
                    .cornerRadius(8)
                    .fullScreenCover(isPresented: $isSignInActive, content: {
                        BeActivTabView()
                    })
                }
                    Spacer()
                    
                    NavigationLink(
                        destination: SignUpView(),
                        isActive: $isSignUpActive,
                        label: {
                            Text("Sign Up")
                                .padding()
                                .foregroundColor(.blue)
                        }
                    )
                }
                .padding()

                Spacer()
            }
            .navigationBarHidden(true)
        }
    
    
    func sendSignInDataToBackend() {
        guard let url = URL(string: "http://localhost:4000/login") else {
            print("Invalid URL")
            return
        }
        
        let userData = [
            "username": username,
            "password": password
        ]
        
    
        
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
                    if responseString == "True" {
                        isSignInActive = true
                    }
                }
            }
        }.resume()
    }
    
}
        
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
