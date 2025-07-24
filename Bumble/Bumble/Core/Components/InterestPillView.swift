//
//  InterestPillView.swift
//  Bumble
//
//  Created by ALYSSON MENEZES on 24/07/25.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName : String? = "heart.fill"
    var emoji: String? = "🤙🏻"
    var text: String = "Some Graduate Degree"
    
    var body: some View {
        HStack (spacing: 4) {
            if let iconName {
                Image(systemName: iconName)
            } else if let emoji {
                Text(emoji)
            }
            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightYellow)
        .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    VStack {
        InterestPillView(iconName: nil )
        InterestPillView()
        InterestPillView()
    }
}
