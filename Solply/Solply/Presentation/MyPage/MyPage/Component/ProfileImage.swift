//
//  ProfileImage.swift
//  Solply
//
//  Created by 김승원 on 11/14/25.
//

import SwiftUI

import Kingfisher

struct ProfileImage: View {
    
    // MARK: - Properties
    
    private let profileImageUrl: String?
    
    private let width: CGFloat = 80.adjusted
    private let height: CGFloat = 80.adjusted
    
    // MARK: - Initializer
    
    init(profileImageUrl: String?) {
        self.profileImageUrl = profileImageUrl
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .frame(width: width, height: height)
                .foregroundColor(.gray800)
            
            Image(.myNavIcon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60.adjusted, height: 60.adjusted)
                .foregroundColor(.green100)
            
            if let profileImageUrl {
                KFImage(URL(string: profileImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .circleClipped()
            }
        }
    }
}

#Preview {
    ProfileImage(profileImageUrl: "https://i.pinimg.com/1200x/29/0a/41/290a41a756c7b1482af1897fdcb65a7a.jpg")
    
    ProfileImage(profileImageUrl: nil)
}
