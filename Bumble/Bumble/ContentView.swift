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
    
//    @Environment(\.router) var router
    
    
    var body: some View {
        
           

                    HomeView()
                
            
        }
    }




#Preview {
    RouterView { _ in
        ContentView()
    }
}
