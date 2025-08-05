//
//  CardView.swift
//  Bumble
//
//  Created by ALYSSON MENEZES on 24/07/25.
//

import SwiftUI
import SwiftfulUI

struct CardView: View {
    
    var user: User = .mock
    var onSendAComplimentPressed: (() -> Void)? = nil
    var onSuperLikePressed: (() -> Void)? = nil
    var onXmarkPressed: (() -> Void)? = nil
    var onCheckmarkPressed: (() -> Void)? = nil
    var onHideAndReportPressed: (() -> Void)? = nil
    
    
    @State private var cardFrame: CGRect = .zero
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack (spacing: 0){
                //                headerCell
                //                    .frame(height: cardFrame.height)
                
                headerCell
                .frame(height: cardFrame.height)
                
                aboutSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                myInterestsSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                ForEach(user.images, id: \.self ) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                locationSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                footerSection
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 32)
                
                
            }
            
        }
        .scrollIndicators(.hidden)
        .background(Color.bumbleBackgroundYellow)
        .overlay (
            superLikeButton
                .padding(24)
            ,alignment: .bottomTrailing
        )
        
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 60))
            .overlay(
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.system(size: 30, weight: .medium))
            )
            .onTapGesture {
                onSuperLikePressed?( )
            }
    }
    
    
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
    
    private var headerCell: some View {
        ZStack (alignment: .bottomLeading){
            ImageLoaderView(urlString: user.image)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.firstName),\(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack (spacing: 4){
                    Image(systemName: "suitcase")
                    Text(user.work )
                }
                //  .background(Color.green)
                
                HStack {
                    Image(systemName: "graduationcap")
                    Text(user.education )
                }
                
                HeartView()
                    .onTapGesture {
                        
                    }
                
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading )
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
        }
    }
    
    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About me")
            
            Text(user.aboutMe )
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(Color.bumbleBlack)
            
            HStack(spacing: 0) {
                HeartView()
                
                Text("send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
                
            }
            .padding([.horizontal, .trailing], 8)
            .background(Color.bumbleYellow)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .onTapGesture {
                onSendAComplimentPressed?()
            }
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestsSection: some View {
        VStack(alignment: .leading,spacing: 12) {
            VStack(alignment: .leading,spacing: 8 ) {
                sectionTitle(title: "My basics")
                InterestPillGridView(interests: user.basics)
                
            }
            
            VStack(alignment: .leading,spacing: 8 ) {
                sectionTitle(title: "My interests")
                InterestPillGridView(interests: user.interests)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading )
        //.background(Color.black)
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            
            
            Text("10 Km away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emoji: "🇧🇷", text: "Lives in Morada Nova, CE")
        }
        .frame(maxWidth: .infinity, alignment: .leading )
    }
    
    private var footerSection: some View {
        
        VStack (spacing: 24){
            HStack (spacing: 0){
                Circle()
                    .fill(.bumbleYellow)
                    .overlay (
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onXmarkPressed?()
                    }
                
                Spacer(minLength: 0)
                
                Circle()
                    .fill(.bumbleYellow)
                    .overlay (
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        onCheckmarkPressed?()
                    }
                
            }
            
            Text("Hide and Report")
                .font(.title)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    onHideAndReportPressed?()
                }
        }
    }
    
}

#Preview {
    CardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
