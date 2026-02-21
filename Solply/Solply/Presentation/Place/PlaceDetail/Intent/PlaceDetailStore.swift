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
        case .compareUserTownId(let userTownId):
            if userTownId != townId {
                dispatch(.showTownToast)
            }
            
        case .findDirection(let mapRouteType):
            switch mapRouteType {
            case .naver:
                effect.findDirection(
                    with: .naver,
                    startLatitude: state.userLatitude,
                    startLongitude: state.userLongitude,
                    destinationLatitude: state.latitude,
                    destinationLongitude: state.longitude,
                    destinationName: state.placeName
                )
            case .apple:
                effect.findDirection(
                    with: .apple,
                    startLatitude: state.userLatitude,
                    startLongitude: state.userLongitude,
                    destinationLatitude: state.latitude,
                    destinationLongitude: state.longitude,
                    destinationName: nil
                )
            case .kakao:
                effect.findDirection(
                    with: .kakao,
                    startLatitude: state.userLatitude,
                    startLongitude: state.userLongitude,
                    destinationLatitude: state.latitude,
                    destinationLongitude: state.longitude,
                    destinationName: nil
                )
            }
            
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
            guard state.shouldShowTownToast && fromSearch else { return }
            
            let townName = placeDetailInformation.townName
            
            ToastManager.shared.showToast(
                .withActionToast(
                    buttonTitle: "동네 변경",
                    action: { [weak self] in
                        guard let self else { return }
                        
                        self.dispatch(.updateUserTowns(newTownId: self.townId))
                    }
                ),
                message: "이 장소는 \(townName)에 위치해있어요."
            )
            
        case .userTownsUpdated(let townName):
            ToastManager.shared.showToast(.defaultToast, message: "동네가 \(townName)으로 변경되었어요.")
            
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
