//
//  CustomNavigationBarModifier.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct CustomNavigationBarModifier: ViewModifier {
    
    // MARK: - Properties
    
    private let navigationBarType: NavigationBarType
    
    // MARK: - Initializer
    
    init(_ navigationBarType: NavigationBarType) {
        self.navigationBarType = navigationBarType
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        switch navigationBarType {
        case .auth(let exploreAction):
            content.modifier(
                LayoutNavigationBarModifier(
                    centerView: { EmptyView() },
                    leftView: { EmptyView() },
                    rightView: { exploreBarButtonItem(action: exploreAction) },
                    backgroundColor: .gray100
                )
            )
        case .backWithTitleAndHome(let title, let backAction, let homeAction):
            content.modifier(
                LayoutNavigationBarModifier(
                    centerView: {
                        Group {
                            if let title {
                                titleItem(title)
                            } else {
                                EmptyView()
                            }
                        }
                    },
                    leftView: { barButtonItem(.backIconIos, action: backAction) },
                    rightView: { barButtonItem(.homeIcon, action: homeAction) },
                    backgroundColor: .coreWhite
                )
            )
        case .backWithTitle(let title, let backAction):
            content.modifier(
                LayoutNavigationBarModifier(
                    centerView: { titleItem(title) },
                    leftView: { barButtonItem(.backIconIos, action: backAction) },
                    rightView: { EmptyView() },
                    backgroundColor: .coreWhite
                )
            )
        case .backOnly(let backAction):
            content.modifier(
                LayoutNavigationBarModifier(
                    centerView: { EmptyView() },
                    leftView: { barButtonItem(.backIconIos, action: backAction) },
                    rightView: { EmptyView() },
                    backgroundColor: .clear
                )
            )
        case .titleWithNotification(let title, let notificationAction):
            content.modifier(
                LayoutNavigationBarModifier(
                    centerView: { EmptyView() },
                    leftView: { titleItem(title, isLargeTitle: true) },
                    rightView: { barButtonItem(.alarmIcon, action: notificationAction) },
                    backgroundColor: .clear
                )
            )
        case .townFilterWithSearch(let filterTitle, let isLoading, let filterAction, let aiAction, let searchAction):
            content.modifier(
                LayoutNavigationBarModifier(
                    centerView: { EmptyView() },
                    leftView: { townFilterBarButtonItem(filterTitle, isLoading: isLoading, action: filterAction) },
                    rightView: {
                        HStack(alignment: .center, spacing: 0) {
                            aiBarButtonItem(action: aiAction)
                            barButtonItem(.searchIcon, leadingPadding: 0, action: searchAction)
                        }
                    },
                    backgroundColor: .clear
                )
            )
        case .floating(let backAction, let homeAction):
            content.modifier(
                LayoutNavigationBarModifier(
                    centerView: { EmptyView() },
                    leftView: { floatingBarButtonItem(.backIconIos, action: backAction)},
                    rightView: { floatingBarButtonItem(.homeIcon, action: homeAction) },
                    backgroundColor: .clear,
                    isFloatingBar: true
                )
            )
        }
    }
}

// MARK: - Layout

struct LayoutNavigationBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    
    // MARK: - Properties
    
    let centerView: (() -> C)?
    let leftView: (() -> L)?
    let rightView: (() -> R)?
    let backgroundColor: Color
    let isFloatingBar: Bool
    
    // MARK: - Initializer
    
    init(
        centerView: (() -> C)? = nil,
        leftView: (() -> L)? = nil,
        rightView: (() -> R)? = nil,
        backgroundColor: Color,
        isFloatingBar: Bool = false
    ) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
        self.backgroundColor = backgroundColor
        self.isFloatingBar = isFloatingBar
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        if isFloatingBar {
            floatingNavigationBar(content)
        } else {
            defaultNavigationBar(content)
        }
    }
}

extension LayoutNavigationBarModifier {
    private func defaultNavigationBar(_ content: Content) -> some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .center) {
                HStack(spacing: 0) {
                    self.leftView?()
                    
                    Spacer()
                    
                    self.rightView?()
                }
                
                self.centerView?()
                
            }
            .frame(width: 375.adjustedWidth, height: 56.adjustedHeight)
            .background(backgroundColor)
            
            content
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    private func floatingNavigationBar(_ content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .ignoresSafeArea(edges: .vertical)
            
            HStack(spacing: 0) {
                self.leftView?()
                
                Spacer()
                
                self.rightView?()
            }
            .padding(.horizontal, 20.adjustedWidth)
        }
        .navigationBarHidden(true)
    }
}

extension View {
    func customNavigationBar(_ navigationBarType: NavigationBarType) -> some View {
        self.modifier(CustomNavigationBarModifier(navigationBarType))
    }
}

// MARK: - Subviews

extension CustomNavigationBarModifier {
    private func exploreBarButtonItem(action: (() -> Void)?) -> some View {
        Button {
            action?()
        } label: {
            Text("둘러보기")
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.gray800)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private func barButtonItem(
        _ icon: ImageResource,
        leadingPadding: CGFloat = 4.adjusted,
        trailingPadding: CGFloat = 4.adjusted,
        action: (() -> Void)?
    ) -> some View {
        Button {
            action?()
        } label: {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24.adjusted, height: 24.adjusted)
                .padding(12.adjusted)
        }
        .buttonStyle(.plain)
        .padding(.leading, leadingPadding)
        .padding(.trailing, trailingPadding)
    }
    
    private func aiBarButtonItem(action: (() -> Void)?) -> some View {
        Button {
            action?()
        } label: {
            Image(.aiIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48.adjusted, height: 48.adjusted)
        }
        .buttonStyle(.plain)
    }
    
    private func floatingBarButtonItem(_ icon: ImageResource, action: (() -> Void)?) -> some View {
        Button {
            action?()
        } label: {
            ZStack(alignment: .center) {
                Circle()
                    .foregroundStyle(.coreWhite)
                    .frame(width: 40.adjusted, height: 40.adjusted)
                
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
        }
        .buttonStyle(.plain)
        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
    }
    
    private func titleItem(_ title: String, isLargeTitle: Bool = false) -> some View {
        Text(title)
            .applySolplyFont(isLargeTitle ? .display_20_sb : .head_16_m)
            .foregroundStyle(.coreBlack)
            .padding(.horizontal, isLargeTitle ? 20.adjustedWidth : 0)
    }
    
    private func townFilterBarButtonItem(_ filterTitle: String, isLoading: Bool, action: (() -> Void)?) -> some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                Image(.townIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
                
                Text(filterTitle)
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.coreBlack)
                    .customLoading(.JGDButtonLoading, isLoading: isLoading)
                
                Image(.arrowRightIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
        }
        .buttonStyle(.plain)
        .allowsHitTesting(!isLoading)
        .padding(.horizontal, 16.adjustedWidth)
    }
}
