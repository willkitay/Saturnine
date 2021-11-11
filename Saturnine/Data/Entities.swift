//
//  Entities.swift
//  Saturnine
//
//  Created by Will on 4/19/21.
//

import Foundation

struct PictureOfTheDay: Decodable, Identifiable {
    var title: String
    var url: String
    var media_type: String?
    var service_version: String?
    var explanation: String
    var date: String
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
    let camera: Camera
    let earthDate: String
    let id: Int
    let url: String
    let rover: Rover
    let sol: Int
    
    enum CodingKeys: String, CodingKey {
        case camera = "camera"
        case earthDate = "earth_date"
        case id = "id"
        case url = "img_src"
        case rover = "rover"
        case sol = "sol"
    }
}

struct Camera: Codable {
    let fullName: String
    let id: Int
    let name: String
    let roverId: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case id = "id"
        case name = "name"
        case roverId = "rover_id"
    }
}

struct Rover: Codable {
    let id: Int
    let landingDate: String
    let launchDate: String
    let name: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case name = "name"
        case status = "status"
    }
}

struct SpaceX: Codable {
    let name: String
    let date: String
    let details: String?
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "date_utc"
        case details = "details"
        case links = "links"
    }
}

struct SpacecraftList: Codable {
    let count: Int
    let next: String
    let results: [Spacecraft]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case results = "results"
    }
}

struct Spacecraft: Codable {
    let id: Int
    let name: String
    let inUse: Bool
    let capability: String
    let maidenLaunch: String
    let imageUrl: String
    let wikiLink: String
    let agency: Agency
    
    enum CodingKeys: String, CodingKey {
        case id, name, capability, agency
        case maidenLaunch = "maiden_flight"
        case inUse = "in_use"
        case imageUrl = "image_url"
        case wikiLink = "wiki_link"
    }
}

struct Events: Codable {
    let id: Int
    let name: String
    let description: String
    let location: String?
    let newsUrl: String?
    let videoUrl: String?
    let url: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, location, date
        case newsUrl = "news_url"
        case url = "feature_image"
        case videoUrl = "video_url"
    }
}

struct EventList: Codable {
    let count: Int
    let next: String
    let results: [Events]?
    
    enum CodingKeys: String, CodingKey {
        case count, next, results
    }
}

struct AstronautList: Codable {
    let count: Int
    let next: String
    let results: [Astronaut]?
    
    enum CodingKeys: String, CodingKey {
        case count, next, results
    }
}

struct Astronaut: Codable {
    let id: Int
    let name: String
    let nationality: String
    let dob: String
    let bio: String
    let wiki: String?
    let profileImage: String?
    let profileThumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, nationality, bio, wiki
        case dob = "date_of_birth"
        case profileImage = "profile_image"
        case profileThumbnail = "profile_image_thumbnail"
    }
}

extension Astronaut {
    static func == (lhs: Astronaut, rhs: Astronaut) -> Bool {
        lhs.id == rhs.id
    }
}


struct Agency: Codable {
    let name: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case name, description
    }
}

struct Links: Codable {
    let wikipedia: String?
    let flickr: Flickr
    
    enum CodingKeys: String, CodingKey {
        case wikipedia = "wikipedia"
        case flickr =  "flickr"
    }
}

struct Flickr: Codable {
    let original: [String]?
    
    enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}
