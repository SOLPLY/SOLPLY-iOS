//
//  CustomNavigationBarModifier.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct CustomNavigationBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    
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
            
            
        // MARK: - Auth
            
        case .auth(let exploreAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        EmptyView()
                    },
                    leftView: {
                        EmptyView()
                    },
                    rightView: {
                        Button {
                            exploreAction()
                        } label: {
                            Text("둘러보기")
                                .applySolplyFont(.body_14_m)
                                .foregroundStyle(.gray800)
                        }
                        .buttonStyle(.plain)
                    },
                    backgroundColor: .gray100
                )
            )
            
        // MARK: - Onboarding
            
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
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .gray100
                )
            )
            
        // MARK: - Recommend
            
        case .recommend(let isLoading, let filterTitle, let filterAction, let settingAction):
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
                                .frame(width: 24.adjusted, height: 24.adjusted)
                            
                            Button {
                                filterAction()
                            } label: {
                                HStack(alignment: .center, spacing: 4.adjustedWidth) {
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
                            .allowsHitTesting(!isLoading)
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
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    backgroundColor: .gray100
                )
            )
            
        // MARK: - PlaceDetail
            
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
                                    .frame(width: 40.adjusted, height: 40.adjusted)
                                
                                Image(.backIconIos)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjusted, height: 24.adjusted)
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
                                    .frame(width: 40.adjusted, height: 40.adjusted)
                                
                                Image(.homeIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                            }
                        }
                        .buttonStyle(.plain)
                        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
                    },
                    backgroundColor: .clear,
                    isFloatingBar: true
                )
            )
            
        // MARK: - CourseDetail
            
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
                                    .frame(width: 40.adjusted, height: 40.adjusted)
                                
                                Image(.backIconIos)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjusted, height: 24.adjusted)
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
                                    .frame(width: 40.adjusted, height: 40.adjusted)
                                
                                Image(.homeIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                            }
                        }
                        .buttonStyle(.plain)
                        .shadow(color: .coreBlack.opacity(0.05), radius: 2, x: 0, y: 5.55)
                    },
                    backgroundColor: .clear,
                    isFloatingBar: true
                )
            )
            
        // MARK: - Archive
            
        case .archive(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("수집함")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - ArchiveList
            
        case .archiveList(let title, let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text(title)
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - FrequentTown
            
        case .frequentTown(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("동네 설정")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - Reports
            
        case .reports(let reportsStep, let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Group {
                            if reportsStep == .reportsComplete {
                                Text(" ")
                            } else {
                                Text("제보하기")
                                    .foregroundStyle(.coreBlack)
                            }
                        }
                        .applySolplyFont(.head_16_m)
                    },
                    leftView: {
                        Group {
                            if reportsStep == .reportsComplete {
                                EmptyView()
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                            } else {
                                Button {
                                    backAction()
                                } label: {
                                    Image(.backIconIos)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted, height: 24.adjusted)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - PlaceSearch
        
        case .placeSearch(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("검색하기")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - MyPage
            
        case .myPage(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: { EmptyView() },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: { EmptyView() },
                    backgroundColor: .gray100
                )
            )
            
        // MARK: - MyPageEdit
            
        case .myPageEdit(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("프로필 수정")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: { EmptyView() },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - RegisteredPlace
        case .registeredPlace(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("내가 등록한 장소")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
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
                    rightView: { EmptyView() },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - Register
            
        case .register(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("장소 등록하기")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: { EmptyView() },
                    backgroundColor: .coreWhite
                )
            )
            
        // MARK: - Withdraw
            
        case .withdraw(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("탈퇴하기")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .coreWhite
                )
            )
            
        case .customerCenter(let backAction):
            self.modifier(
                CustomNavigationBarModifier(
                    centerView: {
                        Text("고객센터")
                            .applySolplyFont(.head_16_m)
                            .foregroundStyle(.coreBlack)
                    },
                    leftView: {
                        Button {
                            backAction()
                        } label: {
                            Image(.backIconIos)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjusted, height: 24.adjusted)
                        }
                        .buttonStyle(.plain)
                    },
                    rightView: {
                        EmptyView()
                    },
                    backgroundColor: .coreWhite
                )
            )
        }
    }
}
