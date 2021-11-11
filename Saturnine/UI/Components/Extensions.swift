//
//  Extensions.swift
//  Saturnine
//
//  Created by William Kitay on 9/15/21.
//

import Foundation
import SwiftUI

extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}
