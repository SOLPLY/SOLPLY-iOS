//
//  CourseDetailStore.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

@MainActor
final class CourseDetailStore: ObservableObject {
    @Published private(set) var state = CourseDetailState()
    private let effect: CourseDetailEffect = CourseDetailEffect(
        courseService: CourseService(),
        placeService: PlaceService()
    )
    
    func dispatch(_ action: CourseDetailAction) {
        CourseDetailReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .requestFindDirection(
            let destinationLatitude,
            let destinationLongitude,
            let destinationName
        ):
            effect.findDirection(
                startLatitude: state.userLatitude,
                startLongitude: state.userLongitude,
                destinationLatitude: destinationLatitude,
                destinationLongitude: destinationLongitude,
                destinationName: destinationName
            )
            
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
            
        case .fetchCourseDetail(let courseId):
            Task {
                let result = await effect.fetchCourseDetail(courseId: courseId)
                self.dispatch(result)
            }
            
        case .submitCourseBookmark(let courseId):
            Task {
                let result = await effect.submitCourseBookmark(courseId: courseId)
                self.dispatch(result)
            }
            
        case .removeCourseBookmark(let courseId):
            Task {
                let result = await effect.removeCourseBookmark(courseId: courseId)
                self.dispatch(result)
            }
            
        case .submitPlaceBookmark(let placeId):
            Task {
                let result = await effect.submitPlaceBookmark(placeId: placeId)
                self.dispatch(result)
            }
            
        case .removePlaceBookmark(let placeId):
            Task {
                let result = await effect.removePlaceBookmark(placeId: placeId)
                self.dispatch(result)
            }
            
        case .updateCourseDetail(let courseId, let request):
            Task {
                let result = await effect.updateCourseDetail(courseId: courseId, request: request)
                self.dispatch(result)
            }
            
        case .submitCreateCourseDetail(let request):
            Task {
                let result = await effect.submitCreateCourseDetail(request: request)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
