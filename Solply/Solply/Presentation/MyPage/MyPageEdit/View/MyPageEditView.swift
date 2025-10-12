//
//  MyPageEditView.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import SwiftUI

// MARK: - MyPageEditView

public struct MyPageEditView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = MyPageEditStore()
    
    // MARK: - Body
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24.adjustedHeight) {
                header
                nickname
                persona
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.top, 15.adjustedHeight)
            .padding(.bottom, 24.adjustedHeight)
        }
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            CTAMainButton(
                title: "완료",
                isEnabled: true
            ) {
                store.dispatch(.completeTapped)
                appCoordinator.goBack()
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.vertical, 16.adjustedHeight)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .customNavigationBar(
            .myPageEdit(
                title: "프로필 수정",
                backAction: {
                    store.dispatch(.backTapped)
                    appCoordinator.goBack()
                }
            )
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


// MARK: - Subviews

private extension MyPageEditView {
    
    // MARK: Header
    var header: some View {
        VStack(alignment: .center, spacing: 15.adjustedHeight) {
            ZStack {
                Circle()
                    .frame(width: 80.adjustedWidth, height: 80.adjustedHeight)
                    .foregroundColor(.gray800)
                
                Image(.myNavIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60.adjustedWidth, height: 60.adjustedHeight)
                    .foregroundColor(.gray100)
            }
            .padding(.top, 24.adjustedHeight)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
    
    var nickname: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Text("닉네임")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.gray900)
            
            NicknameTextField(
                state: .editing,
                onChange: { store.dispatch(.nicknameChanged($0)) },
                onSubmit: { store.dispatch(.nicknameChanged($0)) }
            )
        }
    }
    
    var persona: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Text("나의 솔플 스타일")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.gray900)
            
            SolplyDropDown(
                title: "조용한 공간에 오래 머물고 싶어요",
                options: store.state.personaOptions,
                selectedText: store.state.selectedPersona
            ) { chosen in
                store.dispatch(.personaSelected(chosen))
            }
        }
    }
}

// MARK: - Preview

//#Preview {
//    MyPageEditView()
//        .environmentObject(AppCoordinator())
//}
