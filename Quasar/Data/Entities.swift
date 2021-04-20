//
//  Entities.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import Foundation

struct PictureOfTheDay: Decodable, Identifiable {
    var title: String?
    var url: String?
    var media_type: String?
    var service_version: String?
    var explanation: String?
    var date: String?
    var copyright: String?
    var id: UUID?
}

extension PictureOfTheDay {
    static func == (lhs: PictureOfTheDay, rhs: PictureOfTheDay) -> Bool {
        lhs.url == rhs.url
    }
}

struct Perseverance: Codable {
    var photos: [Photo]?
}

struct Opportunity: Codable {
    var photos: [Photo]?
}

struct Curiosity: Codable {
    var photos: [Photo]?
}

struct Spirit: Codable {
    var photos: [Photo]?
}

struct Photo: Codable {
    let camera: Camera?
    let earthDate: String?
    let id: Int?
    let url: String?
    let rover: Rover?
    let sol: Int?
    
    enum CodingKeys: String, CodingKey {
        case camera = "camera"
        case earthDate = "earth_date"
        case id = "id"
        case url = "img_src"
        case rover = "rover"
        case sol = "sol"
    }
}

extension Photo {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}

struct Camera: Codable {
    let fullName: String
    let id: Int?
    let name: String?
    let roverId: Int?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case id = "id"
        case name = "name"
        case roverId = "rover_id"
    }
}

struct Rover: Codable {
    let id: Int?
    let landingDate: String?
    let launchDate: String?
    let name: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case name = "name"
        case status = "status"
    }
}
