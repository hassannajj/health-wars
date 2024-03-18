//
//  BeActivTabView.swift
//  BeActiv
//
//  Created by Jason Dubon on 6/23/23.
//

import SwiftUI

struct BeActivTabView: View {
    @EnvironmentObject var manager: HealthManager
    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                }
                .environmentObject(manager)
            /*
            ChartsView()
                .environmentObject(manager)
                .tag("Charts")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
             */
            
            ContentView()
                .tag("Content")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}


/*
 struct BeActivTabView_Previews: PreviewProvider {
 static var previews: some View {
 BeActivTabView()
 .environmentObject(HealthManager())
 }
 }
 */
