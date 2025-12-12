//
//  LongPressRecognizerView.swift
//  Solply
//
//  Created by 김승원 on 12/12/25.
//

import SwiftUI

struct LongPressRecognizerView: UIViewRepresentable {
    
    // MARK: - Properties
    
    let minimumPressDuration: TimeInterval
    let allowableMovement: CGFloat
    let onLongPress: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        minimumPressDuration: TimeInterval = 0.1,
        allowableMovement: CGFloat = 10,
        onLongPress: (() -> Void)? = nil
    ) {
        self.minimumPressDuration = minimumPressDuration
        self.allowableMovement = allowableMovement
        self.onLongPress = onLongPress
    }
    
    // MARK: - Functions

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true

        let longPressGesture = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleLongPress)
        )
        
        longPressGesture.minimumPressDuration = minimumPressDuration
        longPressGesture.cancelsTouchesInView = false
        longPressGesture.delaysTouchesBegan = false
        longPressGesture.delaysTouchesEnded = false
        longPressGesture.delegate = context.coordinator
        
        view.addGestureRecognizer(longPressGesture)

        context.coordinator.gesture = longPressGesture
        context.coordinator.hostView = view

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator

extension LongPressRecognizerView {
    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        // MARK: - Properties
        
        private var beganLocation: CGPoint?
        private var movedTooFar = false

        weak var gesture: UILongPressGestureRecognizer?
        weak var hostView: UIView?
        
        var parent: LongPressRecognizerView
        
        // MARK: - Initializer

        init(_ parent: LongPressRecognizerView) {
            self.parent = parent
        }
        
        // MARK: - Functions

        @objc
        func handleLongPress(_ longPressGesture: UILongPressGestureRecognizer) {
            guard let host = hostView else { return }
            let location = longPressGesture.location(in: host)

            switch longPressGesture.state {
            case .began:
                beganLocation = location
                movedTooFar = false
                
            case .changed:
                if let start = beganLocation {
                    let dx = location.x - start.x
                    let dy = location.y - start.y
                    let distance = sqrt(dx*dx + dy*dy)
                    if distance > parent.allowableMovement {
                        movedTooFar = true
                    }
                }
                
            case .ended:
                if movedTooFar == false {
                    parent.onLongPress?()
                }
                
                beganLocation = nil
                movedTooFar = false
                
            case .cancelled, .failed:
                beganLocation = nil
                movedTooFar = false
                
            default:
                break
            }
        }

        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
            return true
        }
    }
}
