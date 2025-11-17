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
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    private let profileImageUrl: String?
    private let onComplete: ((String, Data) -> Void)?
    
    private let width: CGFloat = 80.adjustedWidth
    private let height: CGFloat = 80.adjustedHeight
    
    // MARK: - Initializer
    
    init(profileImageUrl: String?, onComplete: ((String, Data) -> Void)? = nil) {
        self.profileImageUrl = profileImageUrl
        self.onComplete = onComplete
    }
    
    // MARK: - Body
    
    var body: some View {
        profileImagePicker
            .photosPicker(
                isPresented: $isPickerPresented,
                selection: $selectedItem,
                matching: .images
            )
            .onChange(of: selectedItem) { _, newItem in
                guard let newItem else { return }
                
                Task { @MainActor in
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        
                        selectedImage = image
                        
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
            requestPhotoAuthorization()
        } label: {
            Group {
                if let selectedImage {
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
                    ZStack(alignment: .center) {
                        Circle()
                            .frame(width: width, height: height)
                            .foregroundColor(.gray800)
                        
                        Image(.myNavIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60.adjustedWidth, height: 60.adjustedHeight)
                            .foregroundColor(.gray100)
                    }
                }
            }
        }
        .buttonStyle(.plain)
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
