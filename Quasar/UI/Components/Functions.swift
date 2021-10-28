//
//  Functions.swift
//  Quasar
//
//  Created by William Kitay on 9/14/21.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

func formatDate(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    guard let date = dateFormatter.date(from: date) else { return "error: date is nil" }
    dateFormatter.dateStyle = .medium
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}

func formatDateYearToSecond(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    guard let date = dateFormatter.date(from: date) else { return "error: date is nil" }

    dateFormatter.dateStyle = .medium
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}

func formatDateYearToSecondZ(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    guard let date = dateFormatter.date(from: date) else { return "error: date is nil" }
    
    dateFormatter.dateStyle = .medium
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}


func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void){
    guard let url = URL.init(string: urlString) else {
        return  imageCompletionHandler(nil)
    }
    let resource = ImageResource(downloadURL: url)
    
    KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
        switch result {
        case .success(let value):
            imageCompletionHandler(value.image)
        case .failure:
            imageCompletionHandler(nil)
        }
    }
}

func shareSheet(url: String) {
    downloadImage(with: url) { image in
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}


