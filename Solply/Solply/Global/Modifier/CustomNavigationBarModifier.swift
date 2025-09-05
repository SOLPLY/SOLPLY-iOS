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
        backgroundColor: Color
    ) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        if backgroundColor == Color.clear {
            floatingNavigationBar(content)
        } else {
            defaultNavigationBar(content)
        }
    }
}

extension CustomNavigationBarModifier {
    private func defaultNavigationBar(_ content: Content) -> some View {
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
        .ignoresSafeArea(edges: .bottom)
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
                    },
                    backgroundColor: .gray100
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
                            Image(.searchIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    },
                    backgroundColor: .gray100
                )
            )
            
        case .placeDetail(let backAction, let homeAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        EmptyView()
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            ZStack(alignment: .center) {
                                Circle()
                                    .foregroundStyle(.coreWhite)
                                    .frame(width: 40.adjustedWidth, height: 40.adjustedHeight)
                                
                                Image(.backIconIos)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                            }
                        }
                        .buttonStyle(.plain)
                        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
                    },
                    rightView: {
                        Button {
                            homeAction()
                        } label: {
                            ZStack(alignment: .center) {
                                Circle()
                                    .foregroundStyle(.coreWhite)
                                    .frame(width: 40.adjustedWidth, height: 40.adjustedHeight)
                                
                                Image(.homeIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                            }
                        }
                        .buttonStyle(.plain)
                        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
                    },
                    backgroundColor: .clear
                )
            )
            
        case .courseDetail(let backAction, let homeAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        EmptyView()
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            ZStack(alignment: .center) {
                                Circle()
                                    .foregroundStyle(.coreWhite)
                                    .frame(width: 40.adjustedWidth, height: 40.adjustedHeight)
                                
                                Image(.backIconIos)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                            }
                        }
                        .buttonStyle(.plain)
                        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
                    },
                    rightView: {
                        Button {
                            homeAction()
                        } label: {
                            ZStack(alignment: .center) {
                                Circle()
                                    .foregroundStyle(.coreWhite)
                                    .frame(width: 40.adjustedWidth, height: 40.adjustedHeight)
                                
                                Image(.homeIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                            }
                        }
                        .buttonStyle(.plain)
                        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
                    },
                    backgroundColor: .clear
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
                    },
                    backgroundColor: .coreWhite
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
                    },
                    backgroundColor: .coreWhite
                )
            )
            
        case .frequentTown(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("자주 가는 동네")
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
                    },
                    backgroundColor: .gray100
                )
            )
        }
    }
}
