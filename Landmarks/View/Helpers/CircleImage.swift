//
//  Circle.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/1.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct Circle_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
