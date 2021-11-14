//
//  DataSource.swift
//  Saturnine
//
//  Created by Will on 4/19/21.
//

import Foundation
import SwiftUI

enum Endpoint {
    case PictureOfTheDay
    case Perseverance
    case Opportunity
    case Curiosity
    case Spirit
    case SpaceX
    case Spacecraft
    case Astronaut
    case Events
}

enum DataSourceError {
    case NetworkError
    case DataError
}

class DataSource {
    private var startDate: Date
    private var endDate: Date
    private var date: Date
    var restClient: RESTClient!
        
    init(withClient client: RESTClient) {
        self.restClient = client
        startDate = Date()
        endDate = Date()
        date = Date()
    }
    
    func setDate(currentDate: Date) {
        date = currentDate
    }
    
    func getPicturesOfTheDay(completion: @escaping([PictureOfTheDay]?, DataSourceError?) -> Void) {
        getData(atEndpoint: .PictureOfTheDay, withType: [PictureOfTheDay].self) { data, error in
            let picturesOfTheDay = data as? [PictureOfTheDay]
            completion(picturesOfTheDay, error)
        }
    }
    
    func getPerseverancePhotos(completion: @escaping(Perseverance?, DataSourceError?) -> Void) {
        getData(atEndpoint: .Perseverance, withType: Perseverance.self) { data, error in
            let perseverancePhotos = data as? Perseverance
            completion(perseverancePhotos, error)
        }
    }
    
    func getOpportunityPhotos(completion: @escaping(Opportunity?, DataSourceError?) -> Void) {
        getData(atEndpoint: .Opportunity, withType: Opportunity.self) { data, error in
            let opportunityPhotos = data as? Opportunity
            completion(opportunityPhotos, error)
        }
    }
    
    func getCuriosityPhotos(completion: @escaping(Curiosity?, DataSourceError?) -> Void) {
        getData(atEndpoint: .Curiosity, withType: Curiosity.self) { data, error in
            let curiosityPhotos = data as? Curiosity
            completion(curiosityPhotos, error)
        }
    }
    
    func getSpiritPhotos(completion: @escaping(Spirit?, DataSourceError?) -> Void) {
        getData(atEndpoint: .Spirit, withType: Spirit.self) { data, error in
            let spiritPhotos = data as? Spirit
            completion(spiritPhotos, error)
        }
    }
    
    func getSpaceXLaunches(completion: @escaping([SpaceX]?, DataSourceError?) -> Void) {
        getData(atEndpoint: .SpaceX, withType: [SpaceX].self) { data, error in
            let spaceXLaunches = data as? [SpaceX]
            completion(spaceXLaunches, error)
        }
    }
    
    func getSpacecraft(completion: @escaping(SpacecraftList?, DataSourceError?) -> Void) {
        getData(atEndpoint: .Spacecraft, withType: SpacecraftList.self) { data, error in
            let spacecraftList = data as? SpacecraftList
            completion(spacecraftList, error)
        }
    }
    
    func getAstronauts(completion: @escaping(AstronautList?, DataSourceError?) -> Void) {
        getData(atEndpoint: .Astronaut, withType: AstronautList.self) { data, error in
            let astronautList = data as? AstronautList
            completion(astronautList, error)
        }
    }
    
    func getEvents(completion: @escaping(EventList?, DataSourceError?) -> Void) {
        getData(atEndpoint: .Events, withType: EventList.self) { data, error in
            let eventList = data as? EventList
            completion(eventList, error)
        }
    }
}

//MARK:- Private

extension DataSource {
    private func getData<T>(atEndpoint endpoint: Endpoint, withType type:T.Type, completion:@escaping (Decodable?, DataSourceError?) ->Void) where T:Decodable {
        guard let url = getURL(forEndpoint: endpoint) else {
            completion(nil, .NetworkError)
            return
        }
        restClient.getData(atURL: url, completion: { (data) in
            guard let data = data else {
                completion(nil, .NetworkError)
                return
            }
            let decodedData = self.decodeData(data: data, type:type)
            var error: DataSourceError?
            if decodedData == nil {
                error = .DataError
            }
            completion(decodedData, error)
        })
    }
    
    private func decodeData<T>(data:Data, type:T.Type) -> Decodable? where T:Decodable {
        let decoder = JSONDecoder()
        var decodedData:Decodable?
        do {
            decodedData = try decoder.decode(type, from: data)
        }
        catch {
            print("decodeData: cannot decode object error: \(error)")
        }
        return decodedData
    }
    
    private func getURL(forEndpoint endpoint: Endpoint) -> URL? {
        let nasaAPIKey = nasaAPIKey
        var urlString: URL?
        var components = URLComponents()
        switch endpoint {
            case .PictureOfTheDay:
                components.scheme = "https"
                components.host = "api.nasa.gov"
                components.path = "/planetary/apod/"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: nasaAPIKey),
                    URLQueryItem(name: "start_date", value: decrementStartDate()),
                    URLQueryItem(name: "end_date", value: decrementEndDate())
                ]
                urlString = components.url
            case .Perseverance:
                components.scheme = "https"
                components.host = "api.nasa.gov"
                components.path = "/mars-photos/api/v1/rovers/perseverance/photos"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: nasaAPIKey),
                    URLQueryItem(name: "earth_date", value: dateToString(date: date))
                ]
                urlString = components.url
            case .Opportunity:
                components.scheme = "https"
                components.host = "api.nasa.gov"
                components.path = "/mars-photos/api/v1/rovers/opportunity/photos"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: nasaAPIKey),
                    URLQueryItem(name: "earth_date", value: dateToString(date: date))
                ]
                urlString = components.url
            case .Curiosity:
                components.scheme = "https"
                components.host = "api.nasa.gov"
                components.path = "/mars-photos/api/v1/rovers/curiosity/photos"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: nasaAPIKey),
                    URLQueryItem(name: "earth_date", value: dateToString(date: date))
                ]
                urlString = components.url
            case .Spirit:
                components.scheme = "https"
                components.host = "api.nasa.gov"
                components.path = "/mars-photos/api/v1/rovers/spirit/photos"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: nasaAPIKey),
                    URLQueryItem(name: "earth_date", value: dateToString(date: date))
                ]
                urlString = components.url
            case .SpaceX:
                components.scheme = "https"
                components.host = "api.spacexdata.com"
                components.path = "/v4/launches/"
                urlString = components.url
            case .Spacecraft:
                components.scheme = "https"
                components.host = "ll.thespacedevs.com"
                components.path = "/2.2.0/config/spacecraft/"
                urlString = components.url
            case .Astronaut:
                components.scheme = "https"
                components.host = "ll.thespacedevs.com"
                components.path = "/2.2.0/astronaut/"
                components.queryItems = [
                    URLQueryItem(name: "ordering", value: "-date_of_birth"),
                    URLQueryItem(name: "limit", value: "75"),
                ]
                urlString = components.url
            case .Events:
                components.scheme = "https"
                components.host = "ll.thespacedevs.com"
                components.path = "/2.2.0/event/upcoming/"
                components.queryItems = [
                    URLQueryItem(name: "limit", value: "75")
                ]
                urlString = components.url
            }
        return urlString
    }
    
    private func decrementStartDate() -> String {
        endDate = startDate
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        dateComponents.day! -= 25 
        let newStartDate = Calendar.current.date(from: dateComponents)
        dateComponents.day! -= 1
        startDate = Calendar.current.date(from: dateComponents)!

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let decrementedDate = dateFormatter.string(from: newStartDate!)
        return decrementedDate
    }
    
    private func decrementEndDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: endDate)
        return formattedDate
    }
    
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

