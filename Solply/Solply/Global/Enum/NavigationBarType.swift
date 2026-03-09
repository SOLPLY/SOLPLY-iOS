//
//  NavigationBarType.swift
//  Solply
//
//  Created by 김승원 on 7/8/25.
//

import Foundation

/// 네비게이션 바 타입입니다.
enum NavigationBarType {
    case auth(exploreAction: (() -> Void))
    case backWithTitleAndHome(title: String, backAction: (() -> Void), homeAction: (() -> Void))
    case backWithTitle(title: String, backAction: (() -> Void))
    case backOnly(backAction: (() -> Void))
    case titleWithNotification(title: String, notificationAction: (() -> Void))
    case townFilterWithSearch(filterTitle: String, isLoading: Bool, filterAction: (() -> Void), aiAction: (() -> Void), searchAction: (() -> Void))
    case floating(backAction: (() -> Void), homeAction: (() -> Void))
}
