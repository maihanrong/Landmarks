//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/2.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State var showFavoritesOnly = true
    var filterLandmarks: [Landmark] {
        modelData.landmarks.filter { Landmark in
            !showFavoritesOnly || Landmark.isFavorite
        }
    }
    var body: some View {
        NavigationView{
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                ForEach(filterLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
//        ForEach(["iPhone SE (2nd generation)", "iPhone 13"], id: \.self) {
//            deviceName in
//            LandmarkList()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//        }
    }
}
