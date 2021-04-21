//
//  LiveStreamISS.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import AVKit
import SwiftUI

struct LiveStreamISSView: View {
    private let player = AVPlayer(url: URL(string: "https://www.nasa.gov/2abf7fc6-a77e-423e-a786-a28f3464d827")!)
    
    var body: some View {
        VideoPlayer(player: player)
//            .onTap() { player.play() }
    }
}
