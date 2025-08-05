//
//  BumbleHomeView.swift
//  Bumble
//
//  Created by ALYSSON MENEZES on 22/07/25.
//

import SwiftUI
import SwiftfulUI

struct HomeView: View {
    
    @State var allUsers: [User] = []
    @State var selectedIndex: Int = 0
    @State var cardOffset: [Int : Bool] = [:] // UserId : (Direction is Right == TRUE)
    
    @State  var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("home_filter")  var selectedFilter = "Everyone"
    /*Salvando ultimo estado em que o app se encontrava, caso feche o app e a opcao: Everyone ou Trending tenha sido selecionada ao abrir ele retornará ao ultimo estado */
    
    @State var currentSwipeOffSet: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.bumbleBackgroundYellow.ignoresSafeArea()
            
            VStack (spacing: 12) {
                header
                
                FilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
   
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            
                            /* Renderizando 3 Cards por vez: anterior, atual e o proximo = igual ao Tinder, ao arrastar ficara outro card (o proximo a baixo) */
                            
                            let isPrevious = selectedIndex - 1 == index
                            let isCurrent = selectedIndex == index
                            let isNext = selectedIndex + 1 == index
                            
                            if isPrevious || isCurrent || isNext {
                                let offsetValue = cardOffset[user.id]
                                
                                userProfileCell(user: user, index: index)
                                
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                        
                    } else {
                        ProgressView()
                    }
                    
                    overlaySwipingIndicatos
                        .zIndex(999999)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffset)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func userDidSeclect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffset[user.id] = isLike
        
        selectedIndex += 1
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
    
    private func userProfileCell(user: User, index: Int) -> some View {
        CardView(
            user: user,
            onSendAComplimentPressed: nil,
            onSuperLikePressed: nil,
            onXmarkPressed: {
                userDidSeclect(index: index, isLike: false)
            },
            onCheckmarkPressed: {
                userDidSeclect(index: index, isLike: true)
            },
            onHideAndReportPressed: {
                
            }
        )
        
        .withDragGesture(
            .horizontal,
            minimumDistance: 10,
            resets: true,
            rotationMultiplier: 1.05,
            //                                    scaleMultiplier: 0.8,
            onChanged: { dragOffSet in
                currentSwipeOffSet = dragOffSet.width
            },
            onEnded: { dragOffSet in
                if dragOffSet.width < -50 {
                    userDidSeclect(index: index, isLike: false)
                } else if dragOffSet.width > 50 {
                    userDidSeclect(index: index, isLike: true)
                }
                //  offset = dragOffSet.width
            }
        )
    }
    
    private var overlaySwipingIndicatos: some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay (
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffSet) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffSet, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
            //  .background(.yellow)
            //   .foregroundStyle(Color.gray)
            
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay (
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffSet) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffSet, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
            // .background(.red)
            //   .foregroundStyle(Color.gray)
        }
    }
}


#Preview {
    HomeView()
}
