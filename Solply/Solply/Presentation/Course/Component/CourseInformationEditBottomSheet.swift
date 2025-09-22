//
//  CourseInformationEditBottomSheet.swift
//  Solply
//
//  Created by 김승원 on 9/22/25.
//

import SwiftUI

struct CourseInformationEditBottomSheet: View {
    
    // MARK: - Properties
    
    @State private var courseName: String
    @State private var courseDescription: String
    @State private var isCourseNameValid: Bool = true
    @State private var isCourseDescriptionValid: Bool = true
    
    private var dismissAction: (() -> Void)?
    private var completeAction: ((CourseInformation) -> Void)?
    private let minCourseNameLength: Int = 1
    private let maxCourseNameLenght: Int = 18
    private let minCourseDescriptionLength: Int = 0
    private let maxCourseDescriptionLength: Int = 20
    
    // MARK: - Initializer
    
    init(
        courseName: String,
        courseDescription: String,
        dismissAction: (() -> Void)? = nil,
        completeAction: ((CourseInformation) -> Void)? = nil
    ) {
        self.courseName = courseName
        self.courseDescription = courseDescription
        self.dismissAction = dismissAction
        self.completeAction = completeAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 36.adjustedWidth) {
            navigationBar
            
            courseNameEdit
            
            courseDescriptionEdit
            
            Spacer()
            
            completeButton
        }
        .ignoresSafeArea(.keyboard)
        .background(.coreWhite)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - Subviews

extension CourseInformationEditBottomSheet {
    private var navigationBar: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Button {
                    dismissAction?()
                } label: {
                    Image(.xIconLg)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                }
                .buttonStyle(.plain)
            }
            
            Text("코스 정보 수정")
        }
        .frame(width: 343.adjustedWidth, height: 24.adjustedHeight)
        .padding(.top, 16.adjustedHeight)
    }
    
    private var courseNameEdit: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            Text("코스 이름")
                .applySolplyFont(.title_14_m)
                .foregroundStyle(.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            CourseInformationEditTextField(
                text: $courseName,
                minLength: minCourseNameLength,
                maxLength: maxCourseNameLenght
            ) { isCourseNameValid in
                self.isCourseNameValid = isCourseNameValid
                print("isCourseNameValid: \(isCourseNameValid)")
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var courseDescriptionEdit: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            Text("코스 한 줄 소개")
                .applySolplyFont(.title_14_m)
                .foregroundStyle(.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            CourseInformationEditTextField(
                text: $courseDescription,
                minLength: minCourseDescriptionLength,
                maxLength: maxCourseDescriptionLength
            ) { isCourseDescriptionValid in
                self.isCourseDescriptionValid = isCourseDescriptionValid
                print("isCourseDescriptionValid: \(isCourseDescriptionValid)")
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var completeButton: some View {
        CTAMainButton(
            title: "완료",
            isEnabled: isCourseNameValid && isCourseDescriptionValid
        ) {
            completeAction?(
                CourseInformation(
                    courseName: courseName,
                    courseDescription: courseDescription
                )
            )
        }
        .frame(width: 335.adjustedWidth, height: 64.adjustedHeight)
    }
}

#Preview {
    CourseInformationEditBottomSheet(
        courseName: "오감으로 수집할까말까 ",
        courseDescription: "오감 육감 칠감 ㅋㅋㅋ"
    )
}
