//
//  PlaceDetailStore.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

@MainActor
final class PlaceDetailStore: ObservableObject {
    @Published private(set) var state = PlaceDetailState()
    private let effect = PlaceDetailEffect(
        courseService: CourseService(),
        placeService: PlaceService(),
        userService: UserService()
    )
    
    func dispatch(_ action: PlaceDetailAction) {
        PlaceDetailReducer.reduce(state: &state, action: action)
        
        switch action {
        case .requestFindDirection:
            effect.findDirection(
                startLatitude: state.userLatitude,
                startLongitude: state.userLongitude,
                destinationLatitude: state.latitude,
                destinationLongitude: state.longtitude,
                destinationName: state.placeName
            )
            
        case .fetchCourseArchive(let placeId):
            Task {
                let result = await effect.fetchCourseArchive(placeId: placeId)
                self.dispatch(result)
            }
            
        case .fetchPlaceDetail(let placeId):
            Task {
                let result = await effect.fetchPlaceDetail(placeId: placeId)
                self.dispatch(result)
            }
            
        case .placeDetailFetched(let placeDetailInformation):
            print(placeDetailInformation.townName)
            
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
            
        case .submitAddPlace(let courseId, let placeId):
            Task {
                let result = await effect.submitAddPlace(courseId: courseId, placeId: placeId)
                self.dispatch(result)
            }
            
        case .updateUserTowns(let newTownId):
            Task {
                let result = await effect.updateUserTowns(selectedTownId: newTownId)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
