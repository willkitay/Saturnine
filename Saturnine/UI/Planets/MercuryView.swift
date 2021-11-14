//
//  MercuryView.swift
//  Saturnine
//
//  Created by William Kitay on 10/31/21.
//

import SwiftUI

struct MercuryView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "mercury").padding([.leading, .trailing])
                Group {
                    planetTitle(title: "Mercury")
                    planetText(text: mercurySummary1)
                    planetImage(name: "mercury2").padding(.top)
                    planetImageSubtext(text: "Size comparison of Mercury and Earth. Approximate scale is 29 km/px.")
                    planetText(text: mercurySummary2)
                    planetImage(name: "mercury3").padding(.top)
                    planetImageSubtext(text: "Mercury's relative geological makeup consists of a solid inner core, and a liquid outer core beneath the mantle.")
                    planetText(text: mercurySummary3)
                    planetImage(name: "mercury4").padding(.top)
                    planetImageSubtext(text: "The cratered surface of Mercury. Courtesy of NASA.")
                }
            }
        }
    }
}

struct MercuryView_Previews: PreviewProvider {
    static var previews: some View {
        MercuryView()
    }
}

private let mercurySummary1 = "Mercury is the smallest planet in the Solar System and the closest to the Sun. Its orbit around the Sun takes ~87 Earth days, the shortest of all the Sun's planets. Mercury may appear as a bright star-like object, but is more difficult to observe than Venus. From Earth, the planet telescopically displays the complete range of phases, similar to Venus and the Moon, which recurs over approximately 116 days.\n\nMercury's surface is similar to the Moon, showing extensive cratering and basaltic plains which indicate that it has been geologically inactive for billions of years. The mantle is chemically heterogenous, which means that it likely went through a magma ocean phase in its development."

private let mercurySummary2 = "Mercury is one of four terrestrial planets in the Solar System, and is a rocky body like Earth. It is the smallest planet in the Solar System, with an equatorial radius of 2,440 kilometres. Mercury is also smaller than the largest natural satellites in the Solar System, Ganymede and Titan. Mercury consists of approximately 70% metallic and 30% silicate material.\n\nDespite its small size and slow, 59-day rotation, Mercury has a significant global magnetic field. Current estimates place it at ~1.1% the strength of Earth's. It is likely that this is generated by a dynamo effect similar to that of Earths, which results from the circulation of the planet's iron-rich liquid core."

private let mercurySummary3 = "Even though Mercury is the closest planet to the sun, its surface can still become incredibly cold. During the day temperatures can reach 840 degrees fahrenheit, and can plunge as low as -275 degrees fahrenheit.\n\nScientists think that a huge asteroid slammed into the planet around 4 billion years ago, which created a crater larger than Texas. Based on the size of the crater, the asteroid was probably around 60 miles wide."
