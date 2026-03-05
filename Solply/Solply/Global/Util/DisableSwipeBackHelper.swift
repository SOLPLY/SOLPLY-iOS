//
//  DisableSwipeBackHelper.swift
//  Solply
//
//  Created by 김승원 on 9/26/25.
//

import SwiftUI

private struct DisableSwipeBackHelper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = SwipeBackDisablingController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - SwipeBackDisablingController

private class SwipeBackDisablingController: UIViewController {
    private var originalGestureState: Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let controller = navigationController {
            originalGestureState = controller.interactivePopGestureRecognizer?.isEnabled
            controller.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let controller = navigationController,
           let original = originalGestureState {
            controller.interactivePopGestureRecognizer?.isEnabled = original
        }
    }
}

struct DisableSwipeBack: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(DisableSwipeBackHelper())
    }
}

extension View {
    func disableSwipeBack() -> some View {
        self.modifier(DisableSwipeBack())
    }
}
