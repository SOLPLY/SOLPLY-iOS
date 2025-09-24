//
//  SolplyPhotosPicker.swift
//  Solply
//
//  Created by 김승원 on 9/14/25.
//

import PhotosUI
import SwiftUI

struct SolplyPhotosPicker: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var alertManager: AlertManager
    @State private var isPickerPresented: Bool = false
    @State private var isAlertPresented: Bool = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    private let maxSelectionCount: Int = 3
    private let onComplete: (([String]) -> Void)?
    
    // MARK: - Initializer
    
    init(onComplete: (([String]) -> Void)? = nil) {
        self.onComplete = onComplete
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 12.adjustedWidth) {
            ForEach(0..<maxSelectionCount, id: \.self) { index in
                if index < selectedImages.count {
                    selectedPhotoCell(selectedImages[index])
                } else if index == selectedImages.count {
                    addPhotoCell
                } else {
                    emptyPhotoCell
                }
            }
        }
        .photosPicker(
            isPresented: $isPickerPresented,
            selection: $selectedItems,
            maxSelectionCount: maxSelectionCount,
            matching: .images
        )
        .onChange(of: selectedItems) { _, newItems in
            Task {
                selectedImages.removeAll()
//                var imageKeys: [String] = []
                
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        
                        selectedImages.append(image)
                        
                        // TODO: - presigned url 발급 API 연동, imageKeys에 append
                    }
                }
                
                // TODO: - 상위 뷰로 imageKeys 전달
//                onComplete?(imageKeys)
                onComplete?([""])
            }
        }
        
    }
}

// MARK: - Subviews

extension SolplyPhotosPicker {
    private var emptyPhotoCell: some View {
        Rectangle()
            .frame(width: 72.adjustedWidth, height: 72.adjustedHeight)
            .foregroundStyle(.coreWhite)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray400, style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
            )
    }
    
    private var addPhotoCell: some View {
        Button {
            requestPhotoAuthorization()
        } label: {
            Rectangle()
                .frame(width: 72.adjustedWidth, height: 72.adjustedHeight)
                .foregroundStyle(.gray200)
                .cornerRadius(12, corners: .allCorners)
                .overlay {
                    Image(.plusIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20.adjustedWidth, height: 20.adjustedHeight)
                }
        }
        .buttonStyle(.plain)
    }
    
    private func selectedPhotoCell(_ image: UIImage) -> some View {
        Button {
            requestPhotoAuthorization()
        } label: {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 72.adjustedWidth, height: 72.adjustedHeight)
                .cornerRadius(12, corners: .allCorners)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Functions

extension SolplyPhotosPicker {
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
    SolplyPhotosPicker()
}
