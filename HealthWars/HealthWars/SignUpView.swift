//
//  SignUpView.swift
//  HealthWars
//
//  Created by Angela on 2/21/24.
//
//  Notes: This is the starter login page, pressing Sign In Button will take
//  user to the home page with the navigation tabs at the bottom. No backend implemented.

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
      VStack(spacing: 16) {
        Text("Create an Account")
          .font(.largeTitle)
          .padding()

        // Name section
        Section {
          VStack(spacing: 8) {
            TextField("First Name", text: $firstName)
              .padding()
              .background(Color.gray.opacity(0.2))
              .cornerRadius(8)

            TextField("Last Name", text: $lastName)
              .padding()
              .background(Color.gray.opacity(0.2))
              .cornerRadius(8)
          }
        }
        .contentShape(Rectangle())

        // Username, Password section
        VStack(spacing: 8) { // Add spacing between fields
          TextField("Username", text: $username)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)

          SecureField("Password", text: $password)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)

          SecureField("Confirm Password", text: $confirmPassword)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
        }

          // Error message
          if let errorMessage = errorMessage {
            Text(errorMessage)
              .foregroundColor(.red)
              .font(.caption) // Adjust font size for better visibility
              .padding(.bottom) // Add some padding below the error message
          }

        Button("Sign Up") {
          handleSignUp()
            presentationMode.wrappedValue.dismiss()

        }
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(8)
        .disabled( !isValidForm() ) // Disable button if form is invalid

        Spacer()

        Button("Back to Login") {
          presentationMode.wrappedValue.dismiss()
        }
        .padding()
        .foregroundColor(.blue)
      }
      .navigationTitle("Sign Up")
      .navigationBarHidden(true)
    }

    private func isValidForm() -> Bool {
      if firstName.isEmpty {
        errorMessage = "First name cannot be empty"
        return false
      }
      if lastName.isEmpty {
        errorMessage = "Last name cannot be empty"
        return false
      }
      if username.isEmpty {
        errorMessage = "Username cannot be empty"
        return false
      }
      if password.isEmpty {
        errorMessage = "Password cannot be empty"
        return false
      }
      if confirmPassword != password {
        errorMessage = "Passwords do not match"
        return false
      }
      errorMessage = nil  // Clear any previous error message
      return true
    }

    private func handleSignUp() {
      sendSignUpDataToBackend()
    }
    
    func sendSignUpDataToBackend() {
        guard let url = URL(string: "http://localhost:4000/set_user") else {
            print("Invalid URL")
            return
        }
        
        let userData = [
            "name_first": firstName,
            "name_last": lastName,
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
                }
            }
        }.resume()
    }
  }
