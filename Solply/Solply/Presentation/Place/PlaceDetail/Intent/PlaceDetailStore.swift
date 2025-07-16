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
    // TODO: 추후 plaecService만들면 주입
//    private let effect = PlaceDetailEffect(courseService: CourseService(), placeService: PlaceService())
    private let effect = PlaceDetailEffect(courseService: CourseService())
    
    func dispatch(_ action: PlaceDetailAction) {
        PlaceDetailReducer.reduce(state: &state, action: action)
        
        switch action {
        case .fetchCourseArchive(let townId, let placeId):
            Task {
                let result = await effect.fetchCourseArchive(townId: townId, placeId: placeId)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
