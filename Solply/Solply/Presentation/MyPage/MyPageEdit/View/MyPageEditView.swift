//
//  MyPageEditView.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import SwiftUI

struct MyPageEditView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var alertManager: AlertManager
    @StateObject private var store: MyPageEditStore
    @FocusState private var isNicknameTextFieldFocused: Bool
    
    // MARK: - Initializer
    
    init(userInformation: UserInformation, profileImageUrl: String) {
        self._store = StateObject(
            wrappedValue: MyPageEditStore(
                userInformation: userInformation,
                profileImageUrl: profileImageUrl
            )
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24.adjustedHeight) {
                header
                nickname
                persona
            }
        }
        .scrollDisabled(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 15.adjustedHeight)
        .padding(.bottom, 24.adjustedHeight)
        .background(.coreWhite)
        .customNavigationBar(.myPageEdit(backAction: {
            if store.state.isUserInformationChanged {
                alertManager.showAlert(alertType: .changesNotSaved, onCancel: nil) {
                    appCoordinator.goBack()
                }
            }
        }))
        .onAppear {
            store.dispatch(.loadUserInformation)
        }
        .onChange(of: isNicknameTextFieldFocused) { _, newValue in
            if !newValue {
                store.dispatch(.fetchUserNicknameCheck)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .disableSwipeBack()
        .overlay(alignment: .bottom) {
            CTAMainButton(
                title: "완료",
                isEnabled: true
            ) {
                store.dispatch(.completeTapped)
                appCoordinator.goBack()
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.vertical, 16.adjustedHeight)
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Subviews

private extension MyPageEditView {
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
                initialText: store.userInformation.nickname,
                placeholder: store.userInformation.nickname,
                state: store.state.nicknameTextFieldState,
                counterVisibility: .whenNotEmpty
            ) { text in
                store.dispatch(.nicknameChanged(text))
            } onSubmit: { _ in
                store.dispatch(.fetchUserNicknameCheck)
            }
            .focused($isNicknameTextFieldFocused)
        }
    }
    
    var persona: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Text("나의 솔플 스타일")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.gray900)
            
            SolplyDropDown(
                title: store.userInformation.persona.personaString,
                options: PersonaType.allCases.map { $0.personaString },
                selectedText: store.state.selectedPersona
            ) { chosen in
                store.dispatch(.personaSelected(chosen))
            }
        }
    }
}
