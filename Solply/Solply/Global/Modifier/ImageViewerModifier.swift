//
//  ImageViewerModifier.swift
//  Solply
//
//  Created by 김승원 on 3/15/26.
//

import SwiftUI

import Kingfisher

struct ImageViewerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var selectedIndex: Int?
    private let imageUrls: [String]
    
    // MARK: - Initializer
    
    init(
        selectedIndex: Binding<Int?>,
        imageUrls: [String]
    ) {
        self._selectedIndex = selectedIndex
        self.imageUrls = imageUrls
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(
                isPresented: Binding(
                    get: { selectedIndex != nil },
                    set: { if !$0 { selectedIndex = nil } }
                )
            ) {
                if let index = selectedIndex {
                    ImageViewerView(
                        imageUrls: imageUrls,
                        selectedIndex: index
                    )
                }
            }
    }
}

// MARK: - ImageViewerView

private struct ImageViewerView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex: Int
    
    private let imageUrls: [String]
    private let selectedIndex: Int
    
    private var imageCount: String {
        "\(currentIndex + 1) / \(imageUrls.count)"
    }
    
    // MARK: - Initializer
    
    init(imageUrls: [String], selectedIndex: Int) {
        self.imageUrls = imageUrls
        self.selectedIndex = selectedIndex
        self._currentIndex = State(initialValue: selectedIndex)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TabView(selection: $currentIndex) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    ZoomableImageView(
                        imageUrl: imageUrls[index],
                        currentIndex: currentIndex,
                        index: index
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Color.clear
                .customNavigationBar(
                    .dismissWithImageCount(
                        dismissAction: { dismiss() },
                        imageCount: imageCount
                    )
                )
        }
        .ignoresSafeArea(edges: .bottom)
        .background(.coreBlack)
    }
}

// MARK: - ZoomableImageView

private struct ZoomableImageView: UIViewRepresentable {
    
    // MARK: - Properties
    
    private let imageUrl: String?
    private let currentIndex: Int
    private let index: Int
    
    // MARK: - Initializer
    
    init(imageUrl: String?, currentIndex: Int, index: Int) {
        self.imageUrl = imageUrl
        self.currentIndex = currentIndex
        self.index = index
    }
    
    // MARK: - Functions
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delegate = context.coordinator
        scrollView.bouncesZoom = false
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let urlString = imageUrl,
           let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }
        
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
        let doubleTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if currentIndex != index {
            uiView.setZoomScale(1.0, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, UIScrollViewDelegate {
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            scrollView.subviews.first
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let imageView = scrollView.subviews.first else { return }
            
            let imageFrame = imageView.frame
            let scrollViewSize = scrollView.bounds.size
            
            let maxOffsetX = max(imageFrame.width - scrollViewSize.width, 0)
            let maxOffsetY = max(imageFrame.height - scrollViewSize.height, 0)
            
            let clampedX = min(max(scrollView.contentOffset.x, 0), maxOffsetX)
            let clampedY = min(max(scrollView.contentOffset.y, 0), maxOffsetY)
            
            if scrollView.contentOffset.x != clampedX || scrollView.contentOffset.y != clampedY {
                scrollView.contentOffset = CGPoint(x: clampedX, y: clampedY)
            }
        }
        
        @objc
        func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
            guard let scrollView = gesture.view as? UIScrollView else { return }
            
            if scrollView.zoomScale > 1.0 {
                scrollView.setZoomScale(1.0, animated: true)
            } else {
                let point = gesture.location(in: scrollView)
                let rectangle = CGRect(x: point.x - 50, y: point.y - 50, width: 100, height: 100)
                scrollView.zoom(to: rectangle, animated: true)
            }
        }
    }
}

// MARK: - View

extension View {
    func imageViewer(
        selectedIndex: Binding<Int?>,
        imageUrls: [String]
    ) -> some View {
        self.modifier(ImageViewerModifier(
            selectedIndex: selectedIndex,
            imageUrls: imageUrls
        ))
    }
}
