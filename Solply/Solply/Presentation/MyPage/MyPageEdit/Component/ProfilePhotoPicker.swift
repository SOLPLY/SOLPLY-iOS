//
//  ProfilePhotoPicker.swift
//  Solply
//
//  Created by 김승원 on 11/14/25.
//

import PhotosUI
import SwiftUI

import Kingfisher

struct ProfilePhotoPicker: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var alertManager: AlertManager
    @State private var isPickerPresented: Bool = false
    @State private var isDialogPresented: Bool = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var didDelete: Bool = false
    
    private let profileImageUrl: String?
    private let onComplete: ((String, Data) -> Void)?
    private let onDelete: (() -> Void)?
    
    private let width: CGFloat = 80.adjusted
    private let height: CGFloat = 80.adjusted
    
    // MARK: - Initializer
    
    init(
        profileImageUrl: String?,
        onComplete: ((String, Data) -> Void)? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self.profileImageUrl = profileImageUrl
        self.onComplete = onComplete
        self.onDelete = onDelete
    }
    
    // MARK: - Body
    
    var body: some View {
        profileImagePicker
            .photosPicker(
                isPresented: $isPickerPresented,
                selection: $selectedItem,
                matching: .images
            )
            .confirmationDialog(
                "원하는 작업을 선택하세요",
                isPresented: $isDialogPresented,
                titleVisibility: .visible
            ) {
                Button("삭제", role: .destructive) {
                    selectedImage = nil
                    selectedItem = nil
                    didDelete = true
                    onDelete?()
                }
                
                Button("편집") {
                    requestPhotoAuthorization()
                }
                
                Button("취소", role: .cancel) { }
            }
            .onChange(of: selectedItem) { _, newItem in
                guard let newItem else { return }
                
                Task { @MainActor in
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        
                        selectedImage = image
                        didDelete = false
                        
                        if let (fileName, data) = image.convertToJPGFile() {
                            onComplete?(fileName, data)
                        }
                    }
                }
            }
    }
}

// MARK: - Subviews

extension ProfilePhotoPicker {
    private var profileImagePicker: some View {
        Button {
            if didDelete {
                requestPhotoAuthorization()
            } else if let _ = profileImageUrl {
                isDialogPresented = true
            } else if let _ = selectedImage {
                isDialogPresented = true
            } else {
                requestPhotoAuthorization()
            }
        } label: {
            Group {
                if didDelete {
                    defaultProfileImage
                    
                } else if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: height)
                        .background(.gray800)
                        .circleClipped()
                    
                } else if let profileImageUrl {
                    KFImage(URL(string: profileImageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: height)
                        .circleClipped()
                    
                } else {
                    defaultProfileImage
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    private var defaultProfileImage: some View {
        ZStack(alignment: .center) {
            Circle()
                .frame(width: width, height: height)
                .foregroundColor(.gray800)
            
            Image(.myNavIcon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60.adjusted, height: 60.adjusted)
                .foregroundColor(.green100)
        }
    }
}

// MARK: - Functions

extension ProfilePhotoPicker {
    private func requestPhotoAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    isPickerPresented = true
                    
                case .notDetermined, .restricted, .denied:
                    isPickerPresented = false
                    showAlert()
                    
                @unknown default:
                    isPickerPresented = false
                    showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        alertManager.showAlert(alertType: .photoPermissionDenied, onCancel: nil) {
            guard let url = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(url) else { return }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
#Preview {
    ProfilePhotoPicker(profileImageUrl: "https://i.pinimg.com/1200x/29/0a/41/290a41a756c7b1482af1897fdcb65a7a.jpg")
    
    ProfilePhotoPicker(profileImageUrl: nil)
}
