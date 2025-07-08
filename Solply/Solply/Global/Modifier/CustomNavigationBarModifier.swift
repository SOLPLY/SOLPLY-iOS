//
//  CustomNavigationBarModifier.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct CustomNavigationBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    let centerView: (() -> C)?
    let leftView: (() -> L)?
    let rightView: (() -> R)?
    let backgroundColor: Color
    
    init(
        centerView: (() -> C)? = nil,
        leftView: (() -> L)? = nil,
        rightView: (() -> R)? = nil,
        backgroundColor: Color = .coreWhite
    ) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                HStack(spacing: 0) {
                    self.leftView?()
                    
                    Spacer()
                    
                    self.rightView?()
                }
                
                self.centerView?()
                
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.vertical, 16.adjustedHeight)
            .background(backgroundColor)
            
            content
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

extension View {
    @ViewBuilder
    func customNavigationBar(_ navigationBarType: NavigationBarType) -> some View {
        switch navigationBarType {
        case .onboarding(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        EmptyView()
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    }
                )
            )
            
        case .recommend(let filterTitle, let filterAction, let settingAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        EmptyView()
                    },
                    leftView: {
                        HStack(alignment: .center, spacing: 4.adjustedWidth) {
                            Image(.townIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                            
                            Button {
                                filterAction()
                            } label: {
                                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                                    Text(filterTitle)
                                        .applySolplyFont(.body_16_m)
                                    
                                    Image(.arrowRightIcon)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    },
                    rightView: {
                        Button {
                            settingAction()
                        } label: {
                            Image(.settingIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    }
                )
            )
            
        case .placeDetail(let title, let backAction, let homeAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text(title)
                            .applySolplyFont(.head_16_m)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        Button {
                            homeAction()
                        } label: {
                            Image(.homeIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    }
                )
            )
            
        case .courseDetail(let backAction, let homeAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("코스 상세보기")
                            .applySolplyFont(.head_16_m)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        Button {
                            homeAction()
                        } label: {
                            Image(.homeIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    }
                )
            )
            
        case .archive(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("수집함")
                            .applySolplyFont(.head_16_m)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    }
                )
            )
            
        case .archiveList(let title, let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text(title)
                            .applySolplyFont(.head_16_m)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    }
                )
            )
        }
    }
}
