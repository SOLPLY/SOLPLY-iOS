//
//  CustomBottomSheetModifier.swift
//  Solply
//
//  Created by 김승원 on 8/4/25.
//

import SwiftUI

struct CustomBottomSheetModifier<SheetContent: View>: ViewModifier {
    
    // MARK: - Properties
    
    @State private var currentHeight: CGFloat = 0
    
    private let bottomSheetType: CustomBottomSheetType
    private let sheetContent: () -> SheetContent
    
    // MARK: - Initializer
    
    init(
        bottomSheetType: CustomBottomSheetType,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self.bottomSheetType = bottomSheetType
        self.sheetContent = sheetContent
        self._currentHeight = State(initialValue: bottomSheetType.defaultHeight)
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            sheet
                .frame(height: currentHeight)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Subviews

extension CustomBottomSheetModifier {
    private var sheet: some View {
        ZStack(alignment: .top) {
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
                let newHeight = currentHeight - value.translation.height
                let clampedHeight = min(max(newHeight, bottomSheetType.minHeight),bottomSheetType.maxHeight)
                currentHeight = clampedHeight
            }
            .onEnded { value in
                let newHeight = currentHeight - value.translation.height
                let midPoint = (bottomSheetType.defaultHeight + bottomSheetType.maxHeight) / 2
                
                withAnimation(.easeInOut(duration: 0.25)) {
                    if newHeight <= bottomSheetType.defaultHeight {
                        currentHeight = bottomSheetType.defaultHeight
                    } else if newHeight > midPoint {
                        currentHeight = bottomSheetType.maxHeight
                    } else {
                        currentHeight = bottomSheetType.defaultHeight
                    }
                }
            }
    }
}

extension View {
    func customBottomSheet<SheetContent: View>(
        _ bottomSheetType: CustomBottomSheetType,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(
            CustomBottomSheetModifier(
                bottomSheetType: bottomSheetType,
                sheetContent: sheetContent
            )
        )
    }
}
