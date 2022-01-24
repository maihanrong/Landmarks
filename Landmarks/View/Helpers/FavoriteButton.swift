//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/3.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    var body: some View {
        Button {
            isSet.toggle()
        }label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
