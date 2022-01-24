//
//  Landmark.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/2.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var state: String
    var park: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, Codable, CaseIterable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
    
    private var imageName: String
    var image: Image{
        Image(imageName)
    }
    
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    private var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
}
