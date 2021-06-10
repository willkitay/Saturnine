//
//  DataSource.swift
//  Quasar
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
    case HubbleNews
//    case HubbleRecentImages
    case SpaceX
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
    
    func getHubbleNews(completion: @escaping([HubbleSite]?, DataSourceError?) -> Void) {
        getData(atEndpoint: .HubbleNews, withType: [HubbleSite].self) { data, error in
            let hubbleNews = data as? [HubbleSite]
            completion(hubbleNews, error)
        }
    }
    
//    func getHubbleRecentImages(completion: @escaping([HubbleImage]?, DataSourceError?) -> Void) {
//        getData(atEndpoint: .HubbleRecentImages, withType: [HubbleImage].self) { data, error in
//            let hubbleImages = data as? [HubbleImage]
//            completion(hubbleImages, error)
//        }
//    }
    
    func getSpaceXLaunches(completion: @escaping([SpaceX]?, DataSourceError?) -> Void) {
        getData(atEndpoint: .SpaceX, withType: [SpaceX].self) { data, error in
            let spaceXLaunches = data as? [SpaceX]
            completion(spaceXLaunches, error)
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
            var error:DataSourceError?
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
            print("decodeData: cannot decode object error \(error)")
        }
        return decodedData
    }
    
    private func getURL(forEndpoint endpoint: Endpoint) -> URL? {
        let nasaAPIKey = "Z1oGFAgJL0yHHorJqZRhpKwb37rnIeENpO1CfA1T"
        
        var urlString: URL?
        var components = URLComponents()
        switch endpoint {
            case .PictureOfTheDay:
                components.scheme = "https"
                components.host = "api.nasa.gov"
                components.path = "/planetary/apod"
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
                    URLQueryItem(name: "earth_date", value: dateToString(date: date)) //FIXME error here?
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
            case .HubbleNews:
                components.scheme = "https"
                components.host = "hubblesite.org"
                components.path = "/api/v3/external_feed/esa_feed"
                urlString = components.url
//            case .HubbleRecentImages:
//                components.scheme = "https"
//                components.host = "hubblesite.org"
//                components.path = "/api/v3/images"
//                urlString = components.url
            case .SpaceX:
                components.scheme = "https"
                components.host = "api.spacexdata.com"
                components.path = "/v4/launches"
                urlString = components.url
            }
        return urlString
    }
    
    private func decrementStartDate() -> String {
        endDate = startDate
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        dateComponents.day! -= 10
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

