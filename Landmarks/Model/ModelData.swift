//
//  Model.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/2.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    
    var featureds: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    var category: [String: [Landmark]] {
        Dictionary(grouping: landmarks) { $0.category.rawValue }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("main bundle中找不到资源\(filename)")
    }
    do {
        data = try Data(contentsOf: fileUrl)
    } catch {
        fatalError("加载资源\(filename)失败:\n\(error)")
    }
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("json数据解析失败:\n\(error)")
    }
}
