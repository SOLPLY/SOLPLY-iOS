//
//  CustomBottomSheetModifier.swift
//  Solply
//
//  Created by 김승원 on 8/4/25.
//

import SwiftUI

struct CustomBottomSheetModifier<TopContent: View, SheetContent: View>: ViewModifier {
    
    // MARK: - Properties
    
    private let bottomSheetType: CustomBottomSheetType
    // TODO: - topContent 삭제하기
    private let topContent: () -> TopContent
    private let sheetContent: () -> SheetContent
    
    @State private var dragOffset: CGFloat = 0
    
    // MARK: - Initializer
    
    init(
        bottomSheetType: CustomBottomSheetType,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent,
    ) {
        self.bottomSheetType = bottomSheetType
        self.topContent = topContent
        self.sheetContent = sheetContent
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            sheet
                .offset(y: bottomSheetType.defaultOffset + dragOffset)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

// MARK: - Subviews

extension CustomBottomSheetModifier {
    private var sheet: some View {
        ZStack(alignment: .top) {
            topContent()
                .offset(y: -60)
            
            dragArea
            
            VStack(alignment: .center, spacing: 8.adjustedHeight){
                indicator
                
                sheetContent()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var indicator: some View {
        Rectangle()
            .foregroundStyle(.gray300)
            .frame(width: 30.adjustedWidth, height: 5.adjustedHeight)
            .cornerRadius(2, corners: [.allCorners])
            .frame(maxWidth: .infinity)
            .frame(height: 28.adjustedHeight)
    }
    
    private var dragArea: some View {
        Color.white
            .simultaneousGesture(dragGesture)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .shadow(color: .coreBlack.opacity(0.1), radius: 8, x: 0, y: -1)
    }
}

// MARK: - Gestures

extension CustomBottomSheetModifier {
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let proposedOffset = dragOffset + value.translation.height
                
                let minY = bottomSheetType.maxOffset - bottomSheetType.defaultOffset
                let maxY = bottomSheetType.minOffset - bottomSheetType.defaultOffset
                
                dragOffset = min(max(proposedOffset, minY), maxY)
            }
            .onEnded { value in
                let finalOffset = dragOffset + value.translation.height
                
                let fromDefault = finalOffset
                let minThreshold = bottomSheetType.minThreshold
                let maxThreshold = -bottomSheetType.maxThreshold
                
                withAnimation(.easeInOut(duration: 0.25)) {
                    if fromDefault < maxThreshold {
                        dragOffset = bottomSheetType.maxOffset - bottomSheetType.defaultOffset
                    } else if fromDefault > minThreshold {
                        // TODO: - 추후 바텀시트를 내릴 수 있기 떄문에 남겨놓음
                        dragOffset = 0
                    } else {
                        dragOffset = 0
                    }
                }
            }
    }
}

extension View {
    func customBottomSheet<TopContent: View, SheetContent: View>(
        _ bottomSheetType: CustomBottomSheetType,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(
            CustomBottomSheetModifier(
                bottomSheetType: bottomSheetType,
                topContent: topContent,
                sheetContent: sheetContent,
            )
        )
    }
}
