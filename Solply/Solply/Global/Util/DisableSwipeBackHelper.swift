//
//  DisableSwipeBackHelper.swift
//  Solply
//
//  Created by 김승원 on 9/26/25.
//

import SwiftUI

struct DisableSwipeBackHelper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            controller.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension View {
    /// 뒤로가기 제스처를 막습니다.
    func disableSwipeBack() -> some View {
        self.background(DisableSwipeBackHelper())
    }
}
