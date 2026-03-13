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
    
    private let width: CGFloat
    private let height: CGFloat
    
    // MARK: - Initializer
    
    init(profileImageUrl: String?, size: CGFloat = 80.adjusted) {
        self.profileImageUrl = profileImageUrl
        self.width = size
        self.height = size
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
                .frame(width: width * 0.75, height: height * 0.75)
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
