import SwiftUI

struct PlaceDataView: View {
    @ObservedObject var store: PlaceSearchStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Text("검색 결과 \(store.state.places.count)개")
                .applySolplyFont(.button_14_m)
                .foregroundColor(.gray800)
                .frame(height: 18.adjustedHeight)
                .padding(.horizontal, 20.adjustedWidth)
                .padding(.bottom, 16.adjustedHeight)

            ForEach(store.state.places, id: \.placeId) { place in
                SearchPlaceCard(
                    thumbnailUrl: place.thumbnailImageUrl,
                    placeName: place.placeName,
                    address: place.address,
                    mainTag: place.primaryTag
                )
            }

            HStack(alignment: .center, spacing: 0) {
                Text("찾는 장소가 없어요")
                    .applySolplyFont(.button_14_m)
                    .foregroundColor(.gray700)
                    .padding(.leading, 20.adjustedWidth)
                    .padding(.top, 16.adjustedHeight)

                Image(.arrowRightIconGray)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjustedWidth, height: 10.adjustedHeight)
            }
        }
    }
}
