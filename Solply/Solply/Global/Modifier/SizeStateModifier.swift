//
//  SizeStateModifier.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import SwiftUI

/// 뷰의 크기를 측정하여 상태 변수에 바인딩하는 뷰 모디파이어입니다.
///
/// 이 모디파이어는 `GeometryReader`를 사용하여 뷰의 크기를 측정하고,
/// 뷰가 나타날 때 바인딩된 `CGSize` 값을 업데이트합니다.
///
/// - 사용 예시:
/// ```swift
/// @State private var viewSize: CGSize = .zero
///
/// Text("안녕하세요")
///     .sizeState(size: $viewSize)
/// ```
struct SizeStateModifier: ViewModifier {
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        return content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            size = geometry.size
                        }
                }
            )
    }
}

/// 뷰의 크기를 측정하여 상태 변수에 바인딩합니다.
///
/// - Parameter size: 뷰의 크기로 업데이트될 `CGSize` 바인딩
/// - Returns: 크기 측정 기능이 추가된 뷰
extension View {
    func sizeState(size: Binding<CGSize>) -> some View {
        self.modifier(SizeStateModifier(size: size))
    }
}
