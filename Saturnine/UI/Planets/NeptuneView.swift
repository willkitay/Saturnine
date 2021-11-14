//
//  NeptuneView.swift
//  Saturnine
//
//  Created by William Kitay on 10/31/21.
//

import SwiftUI

struct NeptuneView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "neptune").padding([.leading, .trailing])
                Group {
                    planetTitle(title: "Neptune")
                    planetText(text: neptuneSummary1)
                    planetImage(name: "neptune2").padding(.top)
                    planetImageSubtext(text: "Voyager 2 Narrow Angle Camera image of Neptune taken on August 20, 1989 as the spacecraft approached the planet for a flyby on August 25. The Great Dark Spot, flanked by cirrus clouds, is at center. A smaller dark storm, Dark Spot Jr., is rotating into view at bottom left. Credit NASA / JPL / Voyager-ISS / Justin Cowart")
                    planetText(text: neptuneSummary2)
                    planetImage(name: "neptune3").padding(.top)
                    planetImageSubtext(text: "A Voyager 2 view of Neptune processed by an amateur image processor. The image was taken on August 31st 1989 around 17:00 UTC by Voyager 2’s narrow angle camera.")
                    planetText(text: neptuneSummary3)
                    planetImage(name: "neptune4").padding(.top)
                    planetImageSubtext(text: "This image of the planet Neptune was obtained during the testing of the Narrow-Field adaptive optics mode of the MUSE/GALACSI instrument on ESO’s Very Large Telescope.")
                }
            }
        }
    }
}

struct Neptune_Previews: PreviewProvider {
    static var previews: some View {
        NeptuneView()
    }
}

private let neptuneSummary1 = "​Dark, cold, and whipped by supersonic winds, ice giant Neptune is the eighth and most distant planet in our solar system. More than 30 times as far from the Sun as Earth, Neptune is the only planet in our solar system not visible to the naked eye. In 2011 Neptune completed its first 165-year orbit since its discovery in 1846.\n\nNeptune is so far from the Sun that high noon on the big blue planet would seem like dim twilight to us. The warm light we see here on our home planet is roughly 900 times as bright as sunlight on Neptune."

private let neptuneSummary2 = "With a radius of 15,299.4 miles (24,622 kilometers), Neptune is about four times wider than Earth. If Earth were the size of a nickel, Neptune would be about as big as a baseball.\n\nNeptune has 14 known moons. Neptune's largest moon Triton was discovered on October 10, 1846, by William Lassell, just 17 days after Johann Gottfried Galle discovered the planet. Since Neptune was named for the Roman god of the sea, its moons are named for various lesser sea gods and nymphs in Greek mythology.\n\nNeptune has 14 known moons. Neptune's largest moon Triton was discovered on October 10, 1846, by William Lassell, just 17 days after Johann Gottfried Galle discovered the planet. Since Neptune was named for the Roman god of the sea, its moons are named for various lesser sea gods and nymphs in Greek mythology."

private let neptuneSummary3 = "Neptune took shape when the rest of the solar system formed about 4.5 billion years ago when gravity pulled swirling gas and dust in to become this ice giant. Like its neighbor Uranus, Neptune likely formed closer to the Sun and moved to the outer solar system about 4 billion years ago.\n\nNeptune does not have a solid surface. Its atmosphere (made up mostly of hydrogen, helium, and methane) extends to great depths, gradually merging into water and other melted ices over a heavier, solid core with about the same mass as Earth.\n\nNeptune's atmosphere is made up mostly of hydrogen and helium with just a little bit of methane. Neptune's neighbor Uranus is a blue-green color due to such atmospheric methane, but Neptune is a more vivid, brighter blue, so there must be an unknown component that causes the more intense color."

