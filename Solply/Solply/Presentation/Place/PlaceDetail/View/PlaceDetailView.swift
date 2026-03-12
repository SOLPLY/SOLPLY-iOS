//
//  PlaceDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct PlaceDetailView: View {
    
    // MARK: - Properties
    
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: PlaceDetailStore
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - Initializer
    
    init(townId: Int, placeId: Int, fromSearch: Bool) {
        _store = StateObject(
            wrappedValue: PlaceDetailStore(
                townId: townId,
                placeId: placeId,
                fromSearch: fromSearch
            )
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            scrollOffsetTracker
            
            VStack(alignment: .center, spacing: 20.adjustedHeight) {
                placeNameWithIntroduction
                
                actionBar
                
                placeImages
                
                placeInformationCard
                
                map
                
                reportsButton
                
                separator
                
                bottomPadding
            }
            .customLoading(.placeDetailLoading, isLoading: store.state.isPlaceDetailLoading)
        }
        .coordinateSpace(name: "scroll")
        .customNavigationBar(.backWithTitleAndHome(
            title: store.state.navigationBarTitle,
            backAction: { appCoordinator.goBack() },
            homeAction: { appCoordinator.goToRoot() }
            )
        )
        .ignoresSafeArea(edges: .bottom)
        .findDirectionDialog(
            isPresented: Binding(
                get: { store.state.shouldShowFindDirectionDialog },
                set: { _ in
                    store.dispatch(.findDirectionFinished)
                }
            ),
            onFindDirectionAction: { mapRouteType in
                store.dispatch(.findDirection(mapRouteType: mapRouteType))
            }
        )
        .onAppear {
            store.dispatch(.fetchPlaceDetail)
            store.dispatch(.fetchCourseArchive)
            if appState.userSession == .authenticated {
                store.dispatch(.compareUserTownId(userTownId: appState.townId))
            }
        }
        .onReceive(locationManager.$latitude.combineLatest(locationManager.$longitude)) { latitude, longitude in
            store.dispatch(.updateUserCoordinate(latitude: latitude, longitude: longitude))
        }
        .onChange(of: store.state.addPlaceCourseInformation) { _, newValue in
            guard let addPlaceCourseInformation = newValue else { return }
            
            ToastManager.shared.showToast(
                .withActionToast(
                    buttonTitle: "자세히 보기",
                    action: {
                        appCoordinator.navigate(to: .courseDetail(
                            townId: store.townId,
                            courseId: addPlaceCourseInformation.courseId,
                            fromArchive: true)
                        )
                    }
                ),
                message: "‘\(addPlaceCourseInformation.courseName.truncated(length: 8))’에 추가되었어요."
            )
        }
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    // 네비바 타이틀 오프셋 트래커
    private var scrollOffsetTracker: some View {
        GeometryReader { geometry in
            Color.clear
                .onChange(of: geometry.frame(in: .named("scroll")).minY) { _, newValue in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if newValue >= -45 {
                            store.dispatch(.hideNavigationBarTitle)
                        } else {
                            store.dispatch(.showNavigationBarTitle)
                        }
                    }
                }
        }
        .frame(height: 0)
    }
    
    // 태그, 제목, 설명
    private var placeNameWithIntroduction: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                PlaceCategoryTag(placeCategory: store.state.primaryTag)
                
                Text(store.state.placeName)
                    .applySolplyFont(.title_18_sb)
                    .foregroundStyle(.coreBlack)
                    .frame(height: 23.adjustedHeight)
            }
            
            Text(store.state.introduction)
                .applySolplyFont(.caption_14_r)
                .foregroundStyle(.gray900)
                .frame(height: 21.adjustedHeight)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
    
    // 버튼들
    private var actionBar: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            actionButton(
                title: "저장",
                icon: store.state.isBookmarked ? .bookmarkSavedIcon : .bookmarkIcon,
            ) {
                appState.requireLoginWithAlert {
                    bookmarkPlace()
                } onExplore: {
                    AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .savePlace))
                    appCoordinator.changeRoot(to: .auth)
                }
            }
            
            actionButton(title: "길찾기", icon: .tolinkIcon) {
                store.dispatch(.requestFindDirection)
                
                AmplitudeManager.shared.track(
                    .clickPlaceDirections(
                        placeId: store.placeId,
                        placeName: store.state.placeName,
                        fromContext: .placeDetail
                    )
                )
            }
            
            addToCourseButton {
                appState.requireLoginWithAlert {
                    store.dispatch(.fetchCourseArchive)
                    store.dispatch(.toggleAddToCourse)
                    
                    if store.state.selectedCourseIndex != -1 {
                        store.dispatch(.selectCourseToAdd(index: -1))
                    }
                    
                    AmplitudeManager.shared.track(
                        .viewAddToCourse(
                            placeId: store.placeId,
                            hasCourse: !store.state.courses.isEmpty
                        )
                    )
                } onExplore: {
                    AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .addToCourse))
                    appCoordinator.changeRoot(to: .auth)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    // 이미지
    private var placeImages: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                ForEach(store.state.imageURLs, id: \.self) { imageUrl in
                    ThumbnailImage(
                        imageUrl,
                        width: 307.adjustedWidth,
                        height: 204.adjustedHeight,
                        radius: 12
                    )
                }
            }
            .padding(.horizontal, 16.adjustedWidth)
        }
    }
    
    // 상세 정보 카드
    private var placeInformationCard: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            PlaceInformationWithCopyRow(title: "주소", value: store.state.address) {
                store.dispatch(.copyToClipboard(text: store.state.address))
                ToastManager.shared.showToast(.defaultToast, message: "클립보드에 복사되었습니다.")
            }
            
            if !store.state.contactNumber.isEmpty {
                PlaceInformationWithCopyRow(title: "전화번호", value: store.state.contactNumber) {
                    store.dispatch(.copyToClipboard(text: store.state.contactNumber))
                    ToastManager.shared.showToast(.defaultToast, message: "클립보드에 복사되었습니다.")
                }
            } else {
                PlaceInformationRow(title: "전화번호", value: "")
            }
            
            PlaceInformationRow(title: "운영시간", value: store.state.openingHours)
            
            if !store.state.snsLink.isEmpty {
                // TODO: - 바로가기에 인스타 말고 더 생기면 로직 수정하기
                PlaceInformationRow(
                    title: "바로가기",
                    value: store.state.snsLink[0].snsPlatform
                ) {
                    if let url = URL(string: store.state.snsLink[0].url) {
                        openURL(url)
                    }
                }
            }
        }
        .padding(.vertical, 16.adjustedHeight)
        .padding(.horizontal, 20.adjustedWidth)
        .frame(maxWidth: .infinity, alignment: .leading)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray200,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var map: some View {
        PlaceDetailMapView(
            latitude: store.state.latitude,
            longitude: store.state.longitude
        )
        .frame(width: 343.adjustedWidth, height: 234.adjustedHeight)
        .cornerRadius(20, corners: .allCorners)
    }
    
    private var reportsButton: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Image(.warningIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24.adjusted, height: 24.adjusted)
            
            Text("잘못된 정보가 있어요.")
                .applySolplyFont(.body_14_r)
                .foregroundStyle(.gray800)
            
            Spacer()
            
            Button {
                appState.requireLoginWithAlert {
                    appCoordinator.navigate(to: .reports(placeId: store.placeId))
                } onExplore: {
                    AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .reportError))
                    appCoordinator.changeRoot(to: .auth)
                }
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("오류 제보하기")
                        .applySolplyFont(.button_14_m)
                        .foregroundStyle(.red600)
                    
                    Image(.arrowRightIcon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.red600)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjusted, height: 24.adjusted)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.vertical, 12.adjustedHeight)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray200,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var separator: some View {
        Rectangle()
            .foregroundStyle(.gray100)
            .frame(height: 8.adjustedHeight)
            .frame(maxWidth: .infinity)
    }
    
    private var bottomPadding: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .frame(height: 40.adjustedHeight)
            .frame(maxWidth: .infinity)
    }
    
    private func actionButton(title: String, icon: ImageResource, onTap: (() -> Void)?) -> some View {
        Button {
            onTap?()
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text(title)
                    .applySolplyFont(.button_14_m)
                    .foregroundStyle(.gray800)
                
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20.adjusted, height: 20.adjusted)
            }
            .frame(height: 24.adjustedHeight)
            .padding(.vertical, 8.adjustedHeight)
            .padding(.leading, 16.adjustedWidth)
            .padding(.trailing, 12.adjustedWidth)
            .background(.gray100)
            .capsuleClipped()
            .addBorder(.capsule, borderColor: .gray300, borderWidth: 1)
        }
        .buttonStyle(.plain)
    }
    
    private func addToCourseButton(onTap: (() -> Void)?) -> some View {
        Button {
            onTap?()
        } label: {
            Text("내 코스에 추가")
                .applySolplyFont(.button_14_m)
                .foregroundStyle(.coreWhite)
                .frame(width: 80.adjustedWidth, height: 24.adjustedHeight)
                .padding(.vertical, 8.adjustedHeight)
                .padding(.horizontal, 16.adjustedWidth)
                .background(.gray900)
                .capsuleClipped()
        }
        .buttonStyle(.plain)
    }
    
    // TODO: - 내 코스에 추가 디자인 확정 시 구현
    // bottomSheetContent, addPlaceToCourse, addPlaceToCourseButton
    // 수정될 코드들 ⬇️⬇️

    private var bottomSheetContent: some View {
        ZStack {
            if !store.state.addToCourseButtonSelected {
                
            } else {
                addPlaceToCourse
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: store.state.addToCourseButtonSelected)
    }
    
    private var addPlaceToCourse: some View {
        AddPlaceToCourseView(
            courses: store.state.courses,
            selectedIndex: store.state.selectedCourseIndex
        ) { index in
            if index == -1 { return }
            
            guard index < store.state.courses.count else { return }
            
            guard let isDuplicated = store.state.courses[index].isDuplicated,
                  let isPlaceCountLimited = store.state.courses[index].isPlaceCountLimited else { return }
            
            if isDuplicated {
                ToastManager.shared.showToast(.withIconToast, message: "해당 장소가 코스에 이미 담겨있어요.")
            } else if isPlaceCountLimited {
                ToastManager.shared.showToast(.withIconToast, message: "코스에 이미 6개의 장소가 꽉 차 있어요")
            } else {
                store.dispatch(.selectCourseToAdd(index: index))
            }
        } backAction: {
            store.dispatch(.fetchCourseArchive)
            store.dispatch(.toggleAddToCourse)
            store.dispatch(.selectCourseToAdd(index: -1))
        } goToAddCourseAction: {
            appCoordinator.goToRoot()
            appCoordinator.switchTab(to: .course)
            
            AmplitudeManager.shared.track(.clickFindNewCourse)
        }
    }
    
    private var addPlaceToCourseButton: some View {
        SolplyMainButton(title: "이 코스에 추가할래요") {
            let selectedCourseIndex = store.state.selectedCourseIndex
            
            store.dispatch(.toggleAddToCourse)
            store.dispatch(
                .submitAddPlace(
                    courseId: store.state.courses[selectedCourseIndex].courseId
                )
            )
        }
        .padding(.horizontal, 20.adjustedWidth)
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 16.adjustedHeight)
        }
    }
}

// MARK: - Functions

extension PlaceDetailView {
    private func bookmarkPlace() {
        if store.state.isBookmarked {
            store.dispatch(.removePlaceBookmark)
        } else {
            store.dispatch(.submitPlaceBookmark)
        }
        
        store.dispatch(.toggleBookmarkPlace)
        
        if store.state.isBookmarked {
            ToastManager.shared.showToast(.defaultToast, message: "장소가 수집함에 저장되었어요.")
        }
    }
}
