//
//  Model.swift
//  MinischoolOne
//
//  Created by JONGYOUNG CHUNG on 06/07/2019.
//  Copyright © 2019 Minischool. All rights reserved.
//

import Foundation
import WebRTC

public struct Frame: Codable {
    
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var zIndex: CGFloat = 0.0
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
}

public struct WebRTCParameter: Codable{
    
    var constraints: AVConstraint
    var iceConfiguration: ICEConfiguration
}

public struct AVConstraint: Codable{
    
    var audio: Bool
    var video: [String: [String: Int]]
}

public struct ICEConfiguration: Codable{
    
    var iceServers: [Url]
}

public struct MovieClipList: Codable{
    
    var videoList: [MovieClip]
}

public struct MovieClip: Codable{
    
    var id: Int
    var src: String
}

public struct MovieClipFrame: Codable{
    
    var id: Int = 0
    
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var zIndex: CGFloat = 0.0
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
}


public struct Base: Codable{
    
    var id: Int
}

public struct Url: Codable{
    var credential: String?
    var url: String
    var urls: String
    var username: String?
}

@objc
public enum MSPlayerStatus: Int, Codable {
    case waiting = 100
    case started = 200
    case ended = 300
    case errorOcccured = 900
}
