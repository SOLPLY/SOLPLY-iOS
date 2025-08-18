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
    private let topContent: () -> TopContent
    private let sheetContent: () -> SheetContent
    
    @State private var dragOffset: CGFloat = 0
    
    // MARK: - Initializer
    
    init(
        bottomSheetType: CustomBottomSheetType,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self.bottomSheetType = bottomSheetType
        self.topContent = topContent
        self.sheetContent = sheetContent
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
            
            VStack(alignment: .center, spacing: 12.adjustedHeight) {
                Spacer()
                
                topContent()
                
                sheet
            }
            .offset(y: bottomSheetType.defaultOffset + dragOffset)
            .shadow(color: .coreBlack.opacity(0.1), radius: 8, x: 0, y: -1)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// MARK: - Subviews

extension CustomBottomSheetModifier {
    private var sheet: some View {
        VStack(alignment: .center, spacing: 0){
            ZStack(alignment: .center) {
                dragIndicator
            }
            .frame(maxWidth: .infinity)
            .frame(height: 28.adjustedHeight)
            .background(.coreWhite)
            .gesture(dragGesture)
            
            sheetContent()
                .frame(maxHeight: .infinity)
        }
        .background(.coreWhite)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
    
    private var dragIndicator: some View {
        Rectangle()
            .foregroundStyle(.gray300)
            .frame(width: 30.adjustedWidth, height: 5.adjustedHeight)
            .cornerRadius(2, corners: [.allCorners])
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
                    if fromDefault > minThreshold {
                        dragOffset = bottomSheetType.minOffset - bottomSheetType.defaultOffset
                    } else if fromDefault < maxThreshold {
                        dragOffset = bottomSheetType.maxOffset - bottomSheetType.defaultOffset
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
