//
//  ChatPreviewCell.swift
//  Bumble
//
//  Created by ALYSSON MENEZES on 06/08/25.
//

import SwiftUI

struct ChatPreviewCell: View {
    
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    var userName: String = "Alysson"
    var lastChatMessage: String? = "This is the last message."
    var isYourMove: Bool = true
    
    var body: some View {
        HStack {
            ProfileImageCell(
                imageName: imageName,
                percentageRemaining: percentageRemaining,
                hasNewMessage: hasNewMessage
            )
            
            VStack (alignment: .leading, spacing: 2){
                HStack (spacing: 0){
                    Text(userName)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if isYourMove {
                        Text("Your Move")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(.bumbleYellow)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                    }
                }
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.bumbleGray)
                        .padding(.trailing, 16)
                }
            }
            .lineLimit(1)
           // .background(Color.blue)
        }
    }
}

#Preview {
    ZStack {
        ChatPreviewCell()
    }
    .padding()
}
