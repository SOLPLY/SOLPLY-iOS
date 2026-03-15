//
//  ImageViewerModifier.swift
//  Solply
//
//  Created by 김승원 on 3/15/26.
//

import SwiftUI

import Kingfisher

// MARK: - ImageViewerModifier
// 이미지 자세히 보기 기능을 어느 뷰에서든 재사용할 수 있도록 ViewModifier로 구현
// selectedIndex: 선택된 이미지 인덱스 (nil이면 뷰어 닫힘)
// imageUrls: 표시할 이미지 URL 배열

struct ImageViewerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var selectedIndex: Int?
    private let imageUrls: [String?]
    
    // MARK: - Initializer
    
    init(
        selectedIndex: Binding<Int?>,
        imageUrls: [String?]
    ) {
        self._selectedIndex = selectedIndex
        self.imageUrls = imageUrls
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
        // selectedIndex가 nil이 아닐 때 fullScreenCover로 뷰어 표시
        // set에서 nil을 받으면 (뷰어가 닫히면) selectedIndex를 nil로 초기화
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
// 전체화면 이미지 뷰어 UI
// TabView의 page 스타일로 좌우 스와이프하여 이미지 탐색 가능

private struct ImageViewerView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex: Int
    
    private let imageUrls: [String?]
    private let selectedIndex: Int
    
    // 현재 페이지 / 전체 페이지 표시용 연산프로퍼티
    private var imageCount: String {
        "\(currentIndex + 1) / \(imageUrls.count)"
    }
    
    // MARK: - Initializer
    
    init(imageUrls: [String?], selectedIndex: Int) {
        self.imageUrls = imageUrls
        self.selectedIndex = selectedIndex
        self._currentIndex = State(initialValue: selectedIndex) // 선택된 이미지 인덱스를 초기 페이지로 설정
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
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
// 핀치 줌과 더블탭 줌을 지원하는 이미지 뷰
// UIScrollView를 UIViewRepresentable로 래핑하여 구현

private struct ZoomableImageView: UIViewRepresentable {
    
    // MARK: - Properties
    
    private let imageUrl: String?
    private let currentIndex: Int // 현재 TabView에서 보여지는 페이지 인덱스
    private let index: Int // 이 뷰 자신의 인덱스
    
    // MARK: - Initializer
    
    init(imageUrl: String?, currentIndex: Int, index: Int) {
        self.imageUrl = imageUrl
        self.currentIndex = currentIndex
        self.index = index
    }
    
    // MARK: - Functions
    
    func makeUIView(context: Context) -> UIScrollView {
        // 스크롤뷰 기본 설정!
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delegate = context.coordinator
        scrollView.bouncesZoom = false
        
        // 이미지뷰 기본 설정!
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false // 오토레이아웃 오랜만..ㅎ
        
        if let urlString = imageUrl,
           let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        }
        
        scrollView.addSubview(imageView)
        
        // 스크롤뷰 꽉차게 제약조건 걸어요
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
        // 더블탭 제스처로 줌인 & 줌아웃 토글
        // handleDoubleTap()함수는 아래에 자세히 주석 달아놨어요
        let doubleTap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // UI가 업데이트 될 때 즉, 다른 페이지로 넘어가면 이전 이미지 크기 초기화
        if currentIndex != index {
            uiView.setZoomScale(1.0, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, UIScrollViewDelegate { // UIScrollViewDelegate를 채택!
        // 줌 대상 뷰를 반환하는 함수(핀치 줌할 때 실제로 확대/축소될 뷰)
        // nil을 반환하면 줌이 동작하지 않는다고 합니다.
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            scrollView.subviews.first
        }
        
        // 스크롤이 발생할 때마다 호출되는 함수
        // 스크롤 했을 때(줌 상태에서) 이미지가 경계 밖으로 나가지 않도록 offset을 조절
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard let imageView = scrollView.subviews.first else { return }
            
            let imageFrame = imageView.frame // <- 현재 이미지 뷰의 실제 프레임
            let scrollViewSize = scrollView.bounds.size // <- ScrollView 화면에 보이는 영역 크기
            
            // 이미지가 ScrollView보다 작으면 0, 크면 그 차이만큼이 최대 스크롤 가능 범위!!
            // ex) 이미지 너비 800, ScrollView 너비 390 → maxOffsetX = 410
            // ex) 이미지 너비 200, ScrollView 너비 390 → maxOffsetX = 0 (스크롤 불가)
            let maxOffsetX = max(imageFrame.width - scrollViewSize.width, 0)
            let maxOffsetY = max(imageFrame.height - scrollViewSize.height, 0)
            
            // offset을 0 ~ max 범위로 강제로 제한(삐져나가지 않게!)
            // min(max(x, 0), maxOffset) → 0보다 작으면 0, maxOffset보다 크면 maxOffset으로 강제로 제한!
            // 덕분에 줌 한 상태에서 스크롤 했을 때 이미지가 적정 선 안으로만 움직여요
            let clampedX = min(max(scrollView.contentOffset.x, 0), maxOffsetX)
            let clampedY = min(max(scrollView.contentOffset.y, 0), maxOffsetY)
            
            // set마다 호출되니까 조건 체크해서 현재 offset이 강제로 제한된 값이랑 다를 때만 보정하도록 조건을 걸었읍니다.
            if scrollView.contentOffset.x != clampedX || scrollView.contentOffset.y != clampedY {
                scrollView.contentOffset = CGPoint(x: clampedX, y: clampedY)
            }
        }
        
        @objc
        func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
            guard let scrollView = gesture.view as? UIScrollView else { return }
            
            // 이미 줌이 된 상태면 원래크기로 줌 아웃
            if scrollView.zoomScale > 1.0 {
                scrollView.setZoomScale(1.0, animated: true)
            // 기본 크기 상태에서 더블 탭 하면
            } else {
                // 가로 100, 새로 100 크기의 정사각형을 만들고, 그 크기를 꽉 채우도록 줌
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
        imageUrls: [String?]
    ) -> some View {
        self.modifier(ImageViewerModifier(
            selectedIndex: selectedIndex,
            imageUrls: imageUrls
        ))
    }
}
