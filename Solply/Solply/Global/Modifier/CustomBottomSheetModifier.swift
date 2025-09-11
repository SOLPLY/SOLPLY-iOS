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
    private let isBookmarked: Bool
    private let topContent: () -> TopContent
    private let sheetContent: () -> SheetContent
    private let bookmarkAction: (() -> Void)?
    
    @State private var dragOffset: CGFloat = 0
    @State private var expandBarOpacity: Double = 0.0
    
    // MARK: - Initializer
    
    init(
        bottomSheetType: CustomBottomSheetType,
        isBookmarked: Bool,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent,
        bookmarkAction: (() -> Void)?
    ) {
        self.bottomSheetType = bottomSheetType
        self.isBookmarked = isBookmarked
        self.topContent = topContent
        self.sheetContent = sheetContent
        self.bookmarkAction = bookmarkAction
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            sheet
                .offset(y: bottomSheetType.defaultOffset + dragOffset)
                .shadow(color: .coreBlack.opacity(0.1), radius: 8, x: 0, y: -1)
                .ignoresSafeArea(edges: .bottom)
            
            expandBar
                .opacity(expandBarOpacity)
        }
    }
}

// MARK: - Subviews

extension CustomBottomSheetModifier {
    private var sheet: some View {
        ZStack(alignment: .top) {
            topContent()
                .opacity(1.0 - expandBarOpacity * 2)
                .offset(y: -60)
            
            VStack(alignment: .center, spacing: 0){
                dragIndicator
                
                sheetContent()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(.coreWhite)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
    }
    
    private var dragIndicator: some View {
        Rectangle()
            .foregroundStyle(.gray300)
            .frame(width: 30.adjustedWidth, height: 5.adjustedHeight)
            .cornerRadius(2, corners: [.allCorners])
            .frame(maxWidth: .infinity)
            .frame(height: 28.adjustedHeight)
            .background(.coreWhite)
            .gesture(dragGesture)
    }
    
    private var expandBar: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    dragOffset = 0
                    expandBarOpacity = 0.0
                }
            } label: {
                Image(.arrowDownIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Button {
                bookmarkAction?()
            } label: {
                ZStack(alignment: .center) {
                    Circle()
                        .frame(width: 40.adjustedWidth, height: 40.adjustedHeight)
                        .foregroundStyle(.gray200)
                    
                    Image(isBookmarked ? .bookmarkSavedIcon : .bookmarkIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.bottom, 10.adjustedHeight)
        .background(.coreWhite)
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
                
                updateExpandBarOpacity()
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
                    
                    updateExpandBarOpacity()
                }
            }
    }
}

// MARK: - Functions

extension CustomBottomSheetModifier {
    private func updateExpandBarOpacity() {
        let fadeInRange: CGFloat = 100
        let minY = bottomSheetType.maxOffset - bottomSheetType.defaultOffset
        
        let distanceFromMax = abs(dragOffset - minY)
        
        if distanceFromMax < fadeInRange {
            expandBarOpacity = max(0.0, min(1.0, (fadeInRange - distanceFromMax) / fadeInRange))
        } else {
            expandBarOpacity = 0.0
        }
    }
}

extension View {
    func customBottomSheet<TopContent: View, SheetContent: View>(
        _ bottomSheetType: CustomBottomSheetType,
        isBookmarked: Bool,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent,
        bookmarkAction: (() -> Void)?
    ) -> some View {
        self.modifier(
            CustomBottomSheetModifier(
                bottomSheetType: bottomSheetType,
                isBookmarked: isBookmarked,
                topContent: topContent,
                sheetContent: sheetContent,
                bookmarkAction: bookmarkAction
            )
        )
    }
}
