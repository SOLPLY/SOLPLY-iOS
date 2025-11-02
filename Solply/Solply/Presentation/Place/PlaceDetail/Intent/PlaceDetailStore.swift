//
//  PlaceDetailStore.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

@MainActor
final class PlaceDetailStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = PlaceDetailState()
    private let effect: PlaceDetailEffect
    
    let townId: Int
    let placeId: Int
    let fromSearch: Bool
    
    // MARK: - Initializer
    
    init(
        effect: PlaceDetailEffect = PlaceDetailEffect(
            courseService: CourseService(),
            placeService: PlaceService(),
            userService: UserService()
        ),
        townId: Int,
        placeId: Int,
        fromSearch: Bool
    ) {
        self.effect = effect
        self.townId = townId
        self.placeId = placeId
        self.fromSearch = fromSearch
    }
    
    // MARK: - dispatch
    
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
            
        case .fetchCourseArchive:
            Task {
                let result = await effect.fetchCourseArchive(placeId: placeId)
                self.dispatch(result)
            }
            
        case .fetchPlaceDetail:
            Task {
                let result = await effect.fetchPlaceDetail(placeId: placeId)
                self.dispatch(result)
            }
            
        case .placeDetailFetched(let placeDetailInformation):
            if fromSearch &&
            print(placeDetailInformation.townName)
            
        case .submitPlaceBookmark:
            Task {
                let result = await effect.submitPlaceBookmark(placeId: placeId)
                self.dispatch(result)
            }
            
        case .removePlaceBookmark:
            Task {
                let result = await effect.removePlaceBookmark(placeId: placeId)
                self.dispatch(result)
            }
            
        case .submitAddPlace(let courseId):
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
