//
//  FindDirectionDialog.swift
//  Solply
//
//  Created by 김승원 on 1/13/26.
//

import SwiftUI

struct FindDirectionDialog: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var isPresented: Bool
    private let onFindDirectionAction: ((MapRouteType) -> Void)?
    
    // MARK: - Initializer
    
    init(
        isPresented: Binding<Bool>,
        onFindDirectionAction: ((MapRouteType) -> Void)?
    ) {
        self._isPresented = isPresented
        self.onFindDirectionAction = onFindDirectionAction
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                "원하는 작업을 선택하세요",
                isPresented: $isPresented,
                titleVisibility: .visible
            ) {
                Button("네이버 지도") {
                    onFindDirectionAction?(.naver)
                }
                
                Button("카카오 지도") {
                    onFindDirectionAction?(.kakao)
                }
                
                Button("Apple 지도") {
                    onFindDirectionAction?(.apple)
                }
                
                Button("취소", role: .cancel) { }
            }
    }
}

// MARK: - View

extension View {
    func findDirectionDialog(
        isPresented: Binding<Bool>,
        onFindDirectionAction: ((MapRouteType) -> Void)?
    ) -> some View {
        self.modifier(
            FindDirectionDialog(
                isPresented: isPresented,
                onFindDirectionAction: onFindDirectionAction
            )
        )
    }
}
