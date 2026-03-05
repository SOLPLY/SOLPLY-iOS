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
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    private let maxSelectionCount: Int = 3
    private let onComplete: (([(String, Data)]) -> Void)?
    
    // MARK: - Initializer
    
    init(onComplete: (([(String, Data)]) -> Void)? = nil) {
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
            Task { @MainActor in
                selectedImages.removeAll()
                var imageData: [(String, Data)] = []
                
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        
                        selectedImages.append(image)
                        
                        if let data = image.convertToJPGFile() {
                            imageData.append(data)
                        }
                    }
                }
                
                onComplete?(imageData)
            }
        }
        
    }
}

// MARK: - Subviews

extension SolplyPhotosPicker {
    private var emptyPhotoCell: some View {
        Rectangle()
            .frame(width: 72.adjusted, height: 72.adjusted)
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
                .frame(width: 72.adjusted, height: 72.adjusted)
                .foregroundStyle(.gray200)
                .cornerRadius(12, corners: .allCorners)
                .overlay {
                    Image(.plusIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20.adjusted, height: 20.adjusted)
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
                .frame(width: 72.adjusted, height: 72.adjusted)
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
