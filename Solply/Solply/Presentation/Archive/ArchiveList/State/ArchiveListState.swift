//
//  ArchiveListState.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

struct ArchiveListState {
    var selectedCourseIds: Set<Int> = []
    var selectedPlaceIds: Set<Int> = []
    var activeDelete: Bool = false
    var activeCancel: Bool = false
    
    var isPresented: Bool = false
    var courses: [CourseArchiveDTO] = []
    var places: [PlaceDTO] = []
}
