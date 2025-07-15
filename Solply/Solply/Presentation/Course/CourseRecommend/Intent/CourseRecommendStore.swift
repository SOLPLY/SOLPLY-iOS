//
//  CourseRecommendStore.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import Foundation

@MainActor
final class CourseRecommendStore: ObservableObject {
    @Published private(set) var state = CourseRecommendState()
    
    func dispatch(_ action: CourseRecommendAction) {
        
    }
}
