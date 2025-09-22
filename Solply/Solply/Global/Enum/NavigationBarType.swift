//
//  NavigationBarType.swift
//  Solply
//
//  Created by 김승원 on 7/8/25.
//

import Foundation

/// 네비게이션 바 타입입니다.
enum NavigationBarType {
    case onboarding(backAction: () -> Void)
    case recommend(filterTitle: String, filterAction: () -> Void, settingAction: () -> Void)
    case placeDetail(backAction: () -> Void, homeAction: () -> Void)
    case courseDetail(backAction: () -> Void, homeAction: () -> Void)
    case archive(backAction: () -> Void)
    case archiveList(title: String, backAction: () -> Void)
    case frequentTown(backAction: () -> Void)
    case reports(backAction: () -> Void)
    case myPage(backAction: () -> Void)
    case myPageTitled(title: String, backAction: () -> Void)
}
