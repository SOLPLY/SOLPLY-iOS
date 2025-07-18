<img src="https://github.com/user-attachments/assets/92a6a8f2-c387-4570-8602-e684ba97529f" width="1200">

# <img width="30" height="30" alt="image" src="https://github.com/user-attachments/assets/f9d51f5a-e868-4276-975e-1e4275667fe5" /> 솔플리 

> 혼자보내는 여가가 일상이 된 지금, 나만의 방식과 취향에 맞는 시간을 보내고 싶은 사람들을 위한 장소 및 코스 큐레이션 서비스


# 🍏 iOS Developer
|    김승원   |    이수용   |   서주영   |    선영주    |
| :-------------: | :----------: | :----------: |:----------: |
| <img src = "https://github.com/user-attachments/assets/15bbd7a5-bb83-4573-9244-343db687020f" width ="250"> | <img src = "https://github.com/user-attachments/assets/9673cecd-0049-41a1-9526-c51fff959f8b" width ="250">  | <img src = "https://github.com/user-attachments/assets/6e71a47c-9702-4db8-a573-5064c8b76c19" width ="250"> | <img src = "https://github.com/user-attachments/assets/b6ed38a6-b0b1-4a1d-b969-8a34f472e23b" width ="250"> | 
|   `장소, 코스 상세`<br>`지도` |    `수집함`   |  `장소, 코스 추천`    |    `온보딩`   |

# 📷 Screenshot
|    온보딩   |    장소 추천   |    코스 추천   |
| :-------------: | :----------: | :----------: |
| <img src = "https://github.com/user-attachments/assets/8205340c-1164-4f0c-80f3-979561215996" width ="200"> | <img src = "https://github.com/user-attachments/assets/4c1e517e-eb20-4c43-a5d2-870d0793db76" width ="200">  | <img src = "https://github.com/user-attachments/assets/a31cb5e4-0561-49c6-b5b2-7603049fab2a" width ="200">  | 

|    자주 가는 동네 설정 <br> & 탭바 스와이핑   |    장소 필터링   |    장소 상세   |
| :-------------: | :----------: | :----------: |
| <img src = "https://github.com/user-attachments/assets/8205340c-1164-4f0c-80f3-979561215996" width ="200"> | <img src = "https://github.com/user-attachments/assets/0c061bf5-edfd-4854-9ad9-98b04724f067" width ="200">  | <img src = "https://github.com/user-attachments/assets/8f63672e-9531-49e6-9ea2-5bf7dc93b2eb" width ="200">  | 

|  수집함   |    수집함 삭제   |    길찾기   |
| :-------------: | :----------: | :----------: |
| <img src = "https://github.com/user-attachments/assets/c55878fe-46dd-46a5-866e-d68a519ca632" width ="200"> | <img src = "https://github.com/user-attachments/assets/3bbae3e8-f41b-418d-9e37-b8eab7019c8e" width ="200">  | <img src = "https://github.com/user-attachments/assets/6716aca5-8ad4-4a94-ab68-981ab77193e0" width ="200">  | 

|  내 코스에 추가   |    코스 상세   |    코스 수정   |
| :-------------: | :----------: | :----------: |
| <img src = "https://github.com/user-attachments/assets/66bd0472-1e7d-4fdf-9502-d828958ced59" width ="200"> | <img src = "https://github.com/user-attachments/assets/75f94b39-d99c-4bd2-93d6-79e752a23331" width ="200">  | <img src = "https://github.com/user-attachments/assets/2027212f-d3c0-4096-ac32-0ed5dbb09d21" width ="200">  | 

# 🛠️ Tech stack & Architecture
<img src = "https://github.com/user-attachments/assets/d09f4f01-6bb1-4d4c-a57f-7e75a7367b0b" width ="600">

MVI 패턴을 도입해 단방향 데이터 흐름과 역할을 명확히 했고, DIP 기반의 의존성 분리로 테스트와 유지보수가 유연해졌습니다.

# 🎨 Project Design
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
| **사용자 위치 정보**	 |  **CoreLocation**	 | 사용자 위치 정보를 받아오기 위함	 | -  |
| **Lottie** | **lottie-ios** | 애니메이션 구현하기 위함 | 4.5.2 |

# 🔥 Coding Convention
[Swift 스타일쉐어 가이드](https://github.com/StyleShare/swift-style-guide)를 기반으로 합니다.<br>
이는 솔플리 iOS 컨벤션에 따라 일부 수정되었으며, 구성원들의 의사결정에 따라 수시로 변경될 수 있습니다. <br>
🎧 [SOPLY 코딩 컨벤션](https://rectangular-cream-d39.notion.site/215bbb00234d803d99c4c2f0342f88eb?source=copy_link)
코딩 컨벤션 문서를 참고해주세요!

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

```
(기본 커밋 메세지)
[feat/#1] 로그인 기능 구현

(원격 develop → 로컬 develop merge)
[merge/#1] pull develop

(원격 develop merge)
[merge/#1] feat/#1 -> develop

(충돌 해결)
[conflict/#1] 충돌 해결
```

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
