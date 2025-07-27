//
//  BumbleHomeView.swift
//  Bumble
//
//  Created by ALYSSON MENEZES on 22/07/25.
//

import SwiftUI

struct HomeView: View {

    @State var allUsers: [User] = []
    @State var selectedIndex: Int = 0
    
    @State  var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("home_filter")  var selectedFilter = "Everyone"
    /*Salvando ultimo estado em que o app se encontrava, caso feche o app e a opcao: Everyone ou Trending tenha sido selecionada ao abrir ele retornará ao ultimo estado */

    var body: some View {
        ZStack {
            Color.bumbleBackgroundYellow.ignoresSafeArea()
            
            VStack (spacing: 12) {
                header
                
                FilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                //CardView()
                VStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            Rectangle()
                            .fill(Color.red)
                            .overlay (
                                Text("\(index)")
                            )
                        }
                        
                    } else {
                        ProgressView()
                    }
                    
                }
                .frame(maxHeight: .infinity)
              
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    func getData() async {
       guard allUsers.isEmpty else { return }
       
       do {
           allUsers = try await DatabaseHelper().getUsers()
       } catch {
           
       }
   }
    
    private var header: some View {
        HStack (spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          //  .background(Color.red)
            
            
            Text("Bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            //    .background(Color.blue)
                
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            //    .background(Color.red)
            
        }
    

.font(.title2)
.fontWeight(.medium)
.foregroundStyle(.bumbleBlack)
    }
}


#Preview {
    HomeView()
}
