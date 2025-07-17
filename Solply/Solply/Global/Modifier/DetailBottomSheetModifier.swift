//
//  CustomBottomSheetModifier.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import SwiftUI

struct DetailBottomSheetModifier<TopContent: View, SheetContent: View>: ViewModifier {
    
    // MARK: - Properties
    
    let topContent: () -> TopContent
    let sheetContent: () -> SheetContent
    private let maxState: DetailBottomSheetState
    
    @State private var dragOffset: CGFloat = 0
    @State private var bottomSheetSize: CGSize = .zero
    @State private var sheetState: DetailBottomSheetState = .collapsed
    
    // MARK: - Initializer
    
    init(
        maxState: DetailBottomSheetState,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self.maxState = maxState
        self.topContent = topContent
        self.sheetContent = sheetContent
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                VStack {
                    topContent()
                    
                    VStack(alignment: .center, spacing: 0) {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundStyle(.gray300)
                                .frame(width: 30.adjustedWidth, height: 5.adjustedHeight)
                                .cornerRadius(2, corners: [.allCorners])
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 28.adjustedHeight)
                        .background(.coreWhite)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if dragOffset + value.translation.height > 0 {
                                        dragOffset += value.translation.height
                                    }
                                }
                                .onEnded { value in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        dragOffset = 0
                                    }
                                }
                        )
                        
                        sheetContent()
                            .frame(maxHeight: sheetState.maxHeight)
                            .clipped()
                    }
                    .sizeState(size: $bottomSheetSize)
                    .background(.coreWhite)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .onAppear {
//                        withAnimation(.easeInOut(duration: 0.4)) {
                            sheetState = maxState
//                        }
                    }
                }
                .offset(y: 0 + dragOffset)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

extension View {
    func detailBottomSheet<TopContent: View, SheetContent: View>(
        maxState: DetailBottomSheetState,
        @ViewBuilder topContent: @escaping () -> TopContent,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(
            DetailBottomSheetModifier(
                maxState: maxState,
                topContent: topContent,
                sheetContent: sheetContent,
            )
        )
    }
}
