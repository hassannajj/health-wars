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

    var body: some View {
        VStack {
            Text("Create an Account")
                .font(.largeTitle)
                .padding()

            // Add sign-up form fields here

            Button("Sign Up") {
                // Implement sign-up logic
                print("Signing Up...")
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)

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
}
