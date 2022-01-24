//
//  PageView.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/6.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State var currentPage: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().featureds.map({ FeatureCard(landmark: $0)}))
            .aspectRatio(3/2, contentMode: .fit)
    }
}
