//
//  MyPageView.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import SwiftUI

struct MyPageView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = MyPageStore()
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.gray100)
                .ignoresSafeArea(edges: .top)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    userProfileHeader
                    
                    mySolplyRecordSection
                        .padding(.top, 44.adjustedHeight)

                    myRegisteredPlacesSection
                        .padding(.top, 16.adjustedHeight)
                    
                    MyPageSettings(
                        loginProvider: store.state.loginInformation,
                        appVersion: AppEnvironment.appVersion,
                        onTapCustomerCenter: {
                            appCoordinator.navigate(to: .customerCenter)
                        },
                        onTapLogout: {
                            appState.clearUserInformation()
                            store.dispatch(.logout)
                        },
                        onTapDeleteAccount: {
                            appState.clearUserInformation()
                            appCoordinator.navigate(to: .withdraw)
                        }
                    )
                    .padding(.top, 16.adjustedHeight)
                }
                .padding(.bottom, 120.adjustedHeight)
            }
        }
        .onChange(of: store.state.shouldChangeRoot) { _, newValue in
            if newValue {
                appCoordinator.changeRoot(to: .splash)
            }
        }
        .customNavigationBar(
            .titleWithNotification(
                title: "마이페이지",
                notificationAction: { print("알림") }
            )
        )
        .background(.gray100)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            // TODO: - 내 솔플리 기록 삭제하고 돌아왔을 때 반영되지 않아서 임시로 유저정보 Fetch
            // 해결하려면, 회원 정보 Fetch랑 내 솔플리 기록 Fetch랑, 내가 등록한 장소 Fetch를 나눠야 좋을 듯..
            Task {
                await appState.fetchUserInformation()
            }
            store.dispatch(.fetchLoginInformation)
            
            AmplitudeManager.shared.track(.viewMyPage(entryMode: .member))
        }
    }
}

// MARK: - Header

private extension MyPageView {
    var userProfileHeader: some View {
        VStack(alignment: .center, spacing: 15.adjustedHeight) {
            ProfileImage(profileImageUrl: appState.userInformation?.profileImageUrl)
            
            Text(appState.userInformation?.nickname ?? "")
                .applySolplyFont(.title_18_sb)
                .foregroundColor(.coreBlack)
            
            Button {
                guard let userInformation = appState.userInformation else { return }
                
                appCoordinator.navigate(to: .myPageEdit(userInformation: userInformation))
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("프로필 수정")
                        .applySolplyFont(.button_14_m)
                        .foregroundColor(.gray600)
                        .frame(width: 68.adjustedWidth, height: 18.adjustedHeight)
                        .padding(.leading, 12.adjustedWidth)
                    
                    Image(.arrowRightIcon)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        .foregroundColor(.gray600)
                }
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var mySolplyRecordSection: some View {
        VStack(alignment: .center, spacing: 16.adjustedHeight) {
            sectionHeader(
                title: "내 솔플리 기록",
                isButtonEnabled: appState.userInformation?.hasMoreReviews ?? false) {
                    appCoordinator.navigate(to: .mySolplyRecords)
                    
                }
            
            mySolplyRecordList()
        }
        .padding(.vertical, 16.adjustedHeight)
        .padding(.horizontal, 20.adjustedWidth)
        .background(.coreWhite)
    }
    
    var myRegisteredPlacesSection: some View {
        VStack(alignment: .center, spacing: 16.adjustedHeight) {
            sectionHeader(
                title: "내가 등록한 장소",
                isButtonEnabled: !(appState.userInformation?.myPlacePreviews.isEmpty ?? true)
            ) {
                guard let userId = appState.userInformation?.userId else { return }
                
                appCoordinator.navigate(to: .registeredPlaces(userId: userId))
            }
            .padding(.horizontal, 20.adjustedWidth)
            
            myRegisteredPlacesList()
        }
        .padding(.vertical, 16.adjustedHeight)
        .background(.coreWhite)
    }
    
    func mySolplyRecordList() -> some View {
        Group {
            if let mySolplyRecordPreviews = appState.userInformation?.mySolplyRecordPreviews, !mySolplyRecordPreviews.isEmpty {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(Array(mySolplyRecordPreviews.enumerated()), id: \.offset) { index, mySolplyRecordPreview in
                        mySolplyRecordRow(mySolplyRecordPreview, showsDivider: mySolplyRecordPreviews.count - 1 != index)
                    }
                }
            } else {
                emptyView(title: "등록한 기록이 없어요")
            }
        }
    }
    
    func mySolplyRecordRow(_ mySolplyRecordPreview: MySolplyRecordPreview, showsDivider: Bool) -> some  View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .top, spacing: 12.adjustedWidth) {
                ThumbnailImage(
                    mySolplyRecordPreview.previewImageUrl,
                    width: 72.adjusted,
                    height: 72.adjusted,
                    radius: 12
                )
                
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    Text(mySolplyRecordPreview.placeName)
                        .applySolplyFont(.title_15_m)
                        .foregroundStyle(.coreBlack)
                    
                    Text(mySolplyRecordPreview.content)
                        .applySolplyFont(.body_14_r)
                        .foregroundStyle(.gray900)
                        .lineLimit(2)
                }
                .frame(width: 251.adjustedWidth, alignment: .leading)
            }
            
            if showsDivider {
                Rectangle()
                    .frame(height: 1.adjustedHeight)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray200)
                    .padding(.vertical, 16.adjustedHeight)
            }
        }
    }
    
    func myRegisteredPlacesList() -> some View {
        Group {
            if let myPlacePreviews = appState.userInformation?.myPlacePreviews, !myPlacePreviews.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16.adjustedWidth) {
                        ForEach(myPlacePreviews, id: \.id) { item in
                            PlaceCard(
                                isSaved: item.isBookmarked,
                                thumbnailUrl: item.thumbnail,
                                placeName: item.name,
                                placeCategory: item.mainTag,
                                isSelected: false,
                                size: 145.adjusted
                            )
                        }
                    }
                }
                .contentMargins(.horizontal, 20.adjustedWidth)
            } else {
                emptyView(title: "등록한 장소가 없어요")
            }
        }
    }
    
    func sectionHeader(
        title: String,
        isButtonEnabled: Bool,
        action: (() -> Void)?
    ) -> some View {
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .applySolplyFont(.body_16_m)
                .foregroundColor(.coreBlack)
            
            Spacer()
            
            if isButtonEnabled {
                Button {
                    action?()
                } label: {
                    HStack(spacing: 0) {
                        Text("전체 보기")
                            .applySolplyFont(.body_14_r)
                            .foregroundColor(.gray600)
                        
                        Image(.arrowRightIconThin)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24.adjusted, height: 24.adjusted)
                            .foregroundColor(.gray600)
                    }
                    .padding(.leading, 12.adjustedWidth)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    func emptyView(title: String) -> some View {
        Text(title)
            .applySolplyFont(.body_16_r)
            .foregroundColor(.gray400)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 40.adjustedHeight)
    }
}
