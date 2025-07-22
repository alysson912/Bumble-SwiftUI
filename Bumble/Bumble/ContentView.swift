//
//  ContentView.swift
//  Bumble
//
//  Created by ALYSSON MENEZES on 22/07/25.
//


import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @Environment(\.router) var router
    
    
    var body: some View {
        List {
          //  Button("Open Spotify") {
              //  router.showScreen(.fullScreenCover){ router in
               //     HomeView(viewModel: HomeViewModel(router: router))
            HomeView()
                }
            }
        }
        



#Preview {
    RouterView { _ in
        ContentView()
    }
}
