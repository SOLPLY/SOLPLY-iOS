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
    private let effect: CourseDetailEffect = CourseDetailEffect()
    
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
            
        default:
            break
        }
    }
}
