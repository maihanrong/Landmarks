//
//  Profile.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/6.
//

import Foundation

struct Profile {
    var username: String
    var perfersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
    static let `default` = Profile(username: "maimai")
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        
        var id: String { self.rawValue }
    }
}
