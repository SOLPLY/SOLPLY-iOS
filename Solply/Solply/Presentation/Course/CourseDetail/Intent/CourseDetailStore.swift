//
//  CourseDetailStore.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

@MainActor
final class CourseDetailStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = CourseDetailState()
    private let effect: CourseDetailEffect
    
    let townId: Int
    let courseId: Int
    let fromArchive: Bool
    
    // MARK: - Initializer
    
    init(
        effect: CourseDetailEffect = CourseDetailEffect(
            courseService: CourseService(),
            placeService: PlaceService()
        ),
        townId: Int,
        courseId: Int,
        fromArchive: Bool
    ) {
        self.effect = effect
        self.townId = townId
        self.courseId = courseId
        self.fromArchive = fromArchive
    }
    
    // MARK: - dispatch
    
    func dispatch(_ action: CourseDetailAction) {
        CourseDetailReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .findDirection(let mapRouteType):
            let focusedPlaceIndex = state.focusedPlaceIndex
            
            switch mapRouteType {
            case .naver:
                effect.findDirection(
                    with: .naver,
                    startLatitude: state.userLatitude,
                    startLongitude: state.userLongitude,
                    destinationLatitude: state.places[focusedPlaceIndex].latitude,
                    destinationLongitude: state.places[focusedPlaceIndex].longitude,
                    destinationName: state.places[focusedPlaceIndex].placeName
                )
            case .apple:
                effect.findDirection(
                    with: .apple,
                    startLatitude: state.userLatitude,
                    startLongitude: state.userLongitude,
                    destinationLatitude: state.places[focusedPlaceIndex].latitude,
                    destinationLongitude: state.places[focusedPlaceIndex].longitude,
                    destinationName: nil
                )
            case .kakao:
                effect.findDirection(
                    with: .kakao,
                    startLatitude: state.userLatitude,
                    startLongitude: state.userLongitude,
                    destinationLatitude: state.places[focusedPlaceIndex].latitude,
                    destinationLongitude: state.places[focusedPlaceIndex].longitude,
                    destinationName: nil
                )
            }
        
        case .droppedInDeleteZone:
            if state.places.count > 2 {
                self.dispatch(.deletePlace)
            } else {
                self.dispatch(
                    .showToastView(
                        ToastContent(
                            toastType: .withIconToast,
                            message: "코스 안에 2개 이상의 장소가 남아있어야 해요.",
                            bottomPadding: 96.adjustedHeight
                        )
                    )
                )
                
                self.dispatch(.deletePlaceFailed)
            }
            
        case .startEditing:
            if state.focusedPlaceIndex != -1 {
                for index in state.places.indices {
                    state.places[index].isFocused = false
                    state.focusedPlaceIndex = -1
                }
                
                Task {
                    let result = await effect.delayEditing()
                    self.dispatch(result)
                }
            } else {
                self.dispatch(.delayEditing)
            }
            
        case .fetchCourseDetail(let courseId, _):
            Task {
                let result = await effect.fetchCourseDetail(courseId: courseId)
                self.dispatch(result)
            }
            
        case .submitCourseBookmark:
            Task {
                let result = await effect.submitCourseBookmark(courseId: courseId)
                self.dispatch(result)
            }
            
        case .courseBookmarkSubmitted:
            AmplitudeManager.shared.track(.successCourseSave(courseId: courseId, saveAction: .save))
            
        case .removeCourseBookmark:
            Task {
                let result = await effect.removeCourseBookmark(courseId: courseId)
                self.dispatch(result)
            }
            
        case .courseBookmarkRemoved:
            AmplitudeManager.shared.track(.successCourseSave(courseId: courseId, saveAction: .unsave))
            
        case .submitPlaceBookmark(let index):
            Task {
                let result = await effect.submitPlaceBookmark(placeId: state.places[index].placeId)
                self.dispatch(result)
            }
            
        case .removePlaceBookmark(let index):
            Task {
                let result = await effect.removePlaceBookmark(placeId: state.places[index].placeId)
                self.dispatch(result)
            }
            
        case .updateCourseDetail:
            let request = CourseUpdateRequestDTO(
                courseName: state.courseName,
                courseDescription: state.courseDescription,
                courseTagId: state.courseTag?.id ?? 31,
                places: state.places.enumerated().map { index, place in
                    PlaceOrderDTO(
                        placeId: place.placeId,
                        placeOrder: index + 1
                    )
                }
            )
            
            Task {
                let result = await effect.updateCourseDetail(courseId: courseId, request: request)
                self.dispatch(result)
            }
            
        case .submitCreateCourseDetail:
            let request = CourseCreateRequestDTO(
                courseName: state.courseName.truncated(excludeEndRange: " ("),
                courseDescription: state.courseDescription,
                courseTagId: state.courseTag?.id ?? 31,
                places: state.places.enumerated().map { index, place in
                    PlaceOrderDTO(placeId: place.placeId, placeOrder: index + 1)
                },
                isCourseNameUniqueRequired: state.isCourseNameUniqueRequired
            )
            
            Task {
                let result = await effect.submitCreateCourseDetail(request: request)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
