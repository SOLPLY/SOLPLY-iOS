//
//  AIRecommendPromptEffect.swift
//  Solply
//
//  Created by 김승원 on 4/26/26.
//

import Foundation

struct AIRecommendPromptEffect {
    private let recommendService: RecommendAPI
    private let townService: TownAPI
    
    init(recommendService: RecommendAPI, townService: TownAPI) {
        self.recommendService = recommendService
        self.townService = townService
    }
}

// MARK: - RecommendAPI

extension AIRecommendPromptEffect {
    func submitAIPlaceRecommend(request: AIRecommendRequestDTO) async -> AIRecommendPromptAction {
        do {
            let response = try await recommendService.submitAIPlaceRecommend(request: request)
            
            guard let data = response.data else {
                return .submitAIPlaceRecommendFailed(error: .responseError)
            }
            
            let result = data.places.map { place in
                AIRecommendCard.place(
                    AIRecommendPlaceCardItem(
                        id: place.placeId,
                        mainTag: MainTagType(rawValue: place.mainTag) ?? .book,
                        placeName: place.placeName,
                        townName: place.townName,
                        tipText: place.reason,
                        filters: place.optionTags,
                        thumbnailImageUrl: place.thumbnailImageUrl
                    )
                )
            }
            
            return .submitAIPlaceRecommendSuccess(result: result)
            
        } catch let error as NetworkError {
            return .submitAIPlaceRecommendFailed(error: error)
        } catch {
            return .submitAIPlaceRecommendFailed(error: .unknownError)
        }
    }
    
    func submitAICourseRecommend(request: AIRecommendRequestDTO) async -> AIRecommendPromptAction {
        do {
            let response = try await recommendService.submitAICourseRecommend(request: request)
            
            guard let data = response.data else {
                return .submitAICourseRecommendFailed(error: .responseError)
            }
            
            // TODO: - 데이터 매핑 필요
            let result = data.courses.map { course in
                let courseCounts = Dictionary(grouping: course.placeMainTags, by: { $0 })
                    .map { AIRecommendCourseCountItem(mainTag: $0.key, count: $0.value.count) }
                
                let aiRecommendCourseCardItems = AIRecommendCourseCardItem(
                    id: course.courseId,
                    courseTagType: CourseTagType(rawValue: course.courseTag) ?? .daily,
                    courseName: course.courseName,
                    townName: course.townName,
                    tipText: course.reason,
                    courseCounts: courseCounts,
                    thumbnailImageUrl: course.thumbnailImageUrl
                )
                
                return AIRecommendCard.course(aiRecommendCourseCardItems)
            }
            
            return .submitAICourseRecommendSuccess(result: result)
            
        } catch let error as NetworkError {
            return .submitAICourseRecommendFailed(error: error)
        } catch {
            return .submitAICourseRecommendFailed(error: .unknownError)
        }
    }
}

// MARK: - Town API

extension AIRecommendPromptEffect {
    func fetchTowns() async -> AIRecommendPromptAction {
        do {
            let response = try await townService.fetchTownList()
            
            guard let data = response.data else {
                return .fetchTownsFailure(error: .responseError)
            }
            
            let towns = data.toEntity()
            
            return .fetchTownsSuccess(townList: towns)
        } catch let error as NetworkError {
            return .fetchTownsFailure(error: error)
        } catch {
            return .fetchTownsFailure(error: .unknownError)
        }
    }
}
