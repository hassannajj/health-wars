//
//  ActivityCard.swift
//  HealthKitLearner
//
//  Created by Angela on 3/7/24.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}

struct ActivityCard: View {
    @State var activity: Activity
    var body: some View {
        ZStack {
            VStack {
                HStack (alignment: .top) {
                    VStack{
                        Text(activity.title)
                            .font(.system(size:16))
                        
                        Text(activity.subtitle)
                            .font(.system(size:12))
                            .foregroundColor(.gray)
                    }
                    
                    
                    Spacer()
                    
                    Image(systemName: activity.image).foregroundColor(.green)
                    
                }

                Text(activity.amount)
                    .font(.system(size:24))

                
            }
            .padding()
        .cornerRadius(15)
        }
        
    }
}

#Preview {
    ContentView()
}
