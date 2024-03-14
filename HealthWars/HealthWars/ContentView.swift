//
//  ContentView.swift
//  HealthWars
//
//  Created by Angela on 2/21/24.
//
//  Notes: This is the starter login page, pressing Sign In Button will take
//  user to the home page with the navigation tabs at the bottom. No backend implemented.

import SwiftUI

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
                        // Implement sign-in logic
                        print("Signing In...")
                        isSignInActive = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 247/255, green: 141/255, blue: 42/255))
                    .cornerRadius(8)
                    .fullScreenCover(isPresented: $isSignInActive, content: {
                        TabbedView()
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
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

