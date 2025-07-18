<img src="https://github.com/user-attachments/assets/92a6a8f2-c387-4570-8602-e684ba97529f" width="1200">

# ☀️ 솔플리

> 혼자보내는 여가가 일상이 된 지금, 나만의 방식과 취향에 맞는 시간을 보내고 싶은 사람들을 위한 장소 및 코스 큐레이션 서비스


# 🍏 iOS Developer
|    김승원   |    이수용   |   서주영   |    선영주    |
| :-------------: | :----------: | :----------: |:----------: |
| <img src = "https://github.com/user-attachments/assets/15bbd7a5-bb83-4573-9244-343db687020f" width ="250"> | <img src = "https://github.com/user-attachments/assets/9673cecd-0049-41a1-9526-c51fff959f8b" width ="250">  | <img src = "https://github.com/user-attachments/assets/6e71a47c-9702-4db8-a573-5064c8b76c19" width ="250"> | <img src = "https://github.com/user-attachments/assets/b6ed38a6-b0b1-4a1d-b969-8a34f472e23b" width ="250"> | 
|   `장소, 코스 상세`   |    `수집함`   |  `장소, 코스 추천`    |    `온보딩`   |

# 🛠️ Project Design
<img src = "https://github.com/user-attachments/assets/2ffcc061-2fd2-4888-910a-866f78c72570" width ="800">

# 📚 Library
| 계층 | 기술 / 도구 | 역할 | 버전 |
| --- | --- | --- | --- |
| **IDE & SDK** | **Xcode** | Apple 공식 개발 도구 (Swift 6, iOS 18 SDK 포함) | 16.4 |
| **UI 프레임워크** | **SwiftUI** | 선언형 UI 구성, <br>뷰 간 상태 동기화 및 반응형 업데이트 | Xcode 16.4 |
| **상태 관리 / 아키텍처** | **MVI** | 단방향 데이터 흐름을 통한 구조적 상태 관리 및 사용자 이벤트 반영<br>직관적인 상태 흐름과 빠른 UI 구성에 적합 | — |
| **네트워크 계층** | **Moya** | `URLSession` 위에 구축된 추상화 네트워크 레이어, 간편한 API 관리 및 테스트 지원<br> API 요청의 타입 안정성과 테스트 편의성을 높임 | 15.0.3 |
| **이미지 처리** | **Kingfisher** | 이미지 비동기 다운로드 및 캐싱 처리, <br>스크롤 성능 최적화 이미지 로딩 성능과 UI 반응성 향상에 기여 | 8.3.3 |
| **지도** | **NMapsMap** | 네이버 지도를 활용한 지도 기능을 구현하기 위함 | 3.22.0 |
| **카카오 SDK** | **KakaoSDKAuth** | 카카오 소셜 로그인을 구현하기 위함 | 2.24.4 |
| **Lottie** | **lottie-ios** | 애니메이션 구현하기 위함 | 4.5.2 |

# 🔥 Coding Convention
[Swift 스타일쉐어 가이드](https://github.com/StyleShare/swift-style-guide)를 기반으로 <br>
팀원의 기존 스타일을 반영하였습니다.

# 📂 Foldering

```bash
├── 📁 Application
│   └── 📃 SolplyApp.swift
│   └── 📃 RootView.swift
├── 📁 Global
│   ├── 📁 Component
│   ├── 📁 Enum
│   ├── 📁 Extension
│   ├── 📁 Coordinator
│   │   ├── 📁 Destination
│   │   │   ├── 📃 AppDestination.swift
│   │   │   └── 📃 RootDestination.swift
│   │   └── 📃 AppCoordinator.swift
│   ├── 📁 Util
│   └── 📁 Resource
│       ├── 📃 Assets.xcassets
│       └── 📁 Fonts
├── 📁 Presentation
│   ├── 📁 Core
│   │   ├── 📁 Component
│   │   └── 📃 TabBarView.swift
│   ├── 📁 Place
│   │   ├── 📁 PlaceRecommend
│   │   │    ├── 📁 Effect
│   │   │    │    └── 📃 PlaceRecommendEffect.swift
│   │   │    ├── 📁 Entity
│   │   │    ├── 📁 Intent
│   │   │    │    ├── 📃 PlaceRecommendAction.swift
│   │   │    │    └── 📃 PlaceRecommendStore.swift
│   │   │    ├── 📁 State
│   │   │    │    ├── 📃 PlaceRecommendReducer.swift
│   │   │    │    └── 📃 PlaceRecommendState.swift
│   │   │    └── 📁 View
│   │   │         └── 📃 PlaceRecommendView.swift
│   │   └── 📁 PlaceDetail
│   └── 📁 Course
└── 📁 Network
    ├── 📁 API
    │   └── 📃 PlaceRecommendAPI.swift
    ├── 📁 Base
    ├── 📁 DTO
    ├── 📁 Mock
    │   └── 📃 PlaceMockService.swift
    ├── 📁 Service
    │   └── 📃 PlaceService.swift
    └── 📁 TargetType
        └── 📃 PlaceTargetType.swift
```

# 🔖 Tag Convention

|  init   |    가장 처음 Initial Commit에 태그 붙이기   |
| :-------------: | :----------: |
|   feat   |    새로운 기능 구현 시 사용  | 
|   fix   |    버그나 오류 해결 시 사용   | 
|   docs |    README, 템플릿 등 프로젝트 내 문서 수정 시 사용   | 
|   setting  |    프로젝트 관련 설정 변경 시 사용  | 
|   add   |    사진 등 에셋이나 라이브러리 추가 시 사용   | 
|   refactor  |    기존 코드를 리팩토링하거나 수정할 시 사용   | 
|   chore  |    별로 중요한 수정이 아닐 시 사용 (애매하면 이걸로!)   | 
|   merge    |    브랜치 병합 시 사용  | 
|   conflict   |    충돌 해결  |


# 🌊 Git Flow
```
1. 작업할 내용에대한 이슈를 판다

2. 이슈 번호 확인 + 브랜치 컨벤션에 맞게 브랜치를 판다

   a. 반드시 가장 최신화 된`develop`브랜치에서 파생된 것이어야 함 (깃허브에서 파기!)

   b. 브랜치 파기 전 최신화 된 `develop`브랜치 pull 받기

3. 작업 중 내용을 적당히 쪼개어 로컬에서 `commit`을 해둔다

4. 작업이 완료되면 (깃크라켄을 통해) `push` 후 PR을 자세히 작성한다

   a. `push`전 `develop`브랜치를 작업 완료한 브랜치에 `merge` 후 빌드가 되는지 꼭 확인해야 함

5. 코드 리뷰 후 모든 팀원의 `approve`를 받은 후에 `develop`브랜치에 `merge`한다

   a. `merge`후, 브랜치를 삭제한다. (로컬은 남겨두는 것이 좋음)

6. `merge`가 된 후, 팀원에게 노티! 모든 팀원은 로컬 `develop` 브랜치 최신화를 진행한다

```
