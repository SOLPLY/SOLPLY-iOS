//
//  PlaceDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct PlaceDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var store = PlaceDetailStore()
    @StateObject private var toastManager = ToastManager()
    
    // MARK: - Body
    
    var body: some View {
        PlaceDetailMapView(place: PlaceDetail.mockData())
            .customNavigationBar(
                .placeDetail(
                    title: "이거는 받아야지",
                    backAction: {
                        appCoordinator.goBack()
                    },
                    homeAction: {
                        appCoordinator.goToRoot()
                    }
                )
            )
            .detailBottomSheet(maxState: .placeExpended) {
                bottomSheetTopButtons
            } sheetContent: {
                bottomSheetContent
            }
            .onChange(of: store.state.toastContent) { _, toastContent in
                guard let toastContent else { return }
                
                toastManager.showToast(content: toastContent) {
                    // TODO: courseId 바인딩 필요
                    appCoordinator.navigate(to: .courseDetail(courseId: 1, fromArchive: true))
                }
            }
            .toast(toastManager: toastManager)
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    private var bottomSheetTopButtons: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            FindDirectionButton(isEnabled: store.state.findDirectionEnabled) {
                store.dispatch(.requestFindDirection)
            }
            
            Spacer()
            
            AddToCourseButton(isSelected: store.state.addButtonSelected) {
                store.dispatch(.toggleAddToCourse)
                
                if store.state.selectedCourseIndex != -1 {
                    store.dispatch(.selectCourseToAdd(index: -1))
                }
            }
            .animation(.easeIn(duration: 0.2), value: store.state.saveButtonSelected)
            
            SolplySaveButton(
                contentType: .place,
                isEnabled: store.state.saveButtonEnabled,
                isSelected: store.state.saveButtonSelected
            ) {
                store.dispatch(.toggleSavePlace)
                if store.state.saveButtonSelected {
                    store.dispatch(
                        .showToastView(
                            ToastContent(
                                toastType: .defaultToast,
                                message: "장소가 수집함에 저장되었어요.",
                                buttonTitle: nil
                            )
                        )
                    )
                }
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var bottomSheetContent: some View {
        ZStack {
            if store.state.addButtonSelected {
                AddPlaceToCourseView(
                    courses: store.state.courses,
                    selectedIndex: store.state.selectedCourseIndex
                ) { index in
                    store.dispatch(.selectCourseToAdd(index: index))
                } addAction: { index in
                    store.dispatch(.addPlaceToCourse(index: index))
                    store.dispatch(.toggleAddToCourse)
                    store.dispatch(
                        .showToastView(
                            ToastContent(
                                toastType: .withActionToast,
                                // TODO: 데이터 바인딩
                                message: "‘오감으로 수집하..’에 추가되었어요.",
                                buttonTitle: "자세히 보기"
                            )
                        )
                    )
                } backAction: {
                    store.dispatch(.toggleAddToCourse)
                    store.dispatch(.selectCourseToAdd(index: -1))
                }
                .transition(.move(edge: .trailing))
                .onAppear {
                    store.dispatch(.fetchCourseArchive(townId: 1, placeId: 1))
                }
            } else {
                PlaceInformationView()
                    .padding(.top, 8.adjustedHeight)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: store.state.addButtonSelected)
    }
}

#Preview {
    PlaceDetailView()
        .environmentObject(AppCoordinator())
}
