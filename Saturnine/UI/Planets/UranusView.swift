//
//  UranusView.swift
//  Saturnine
//
//  Created by William Kitay on 11/4/21.
//

import SwiftUI

struct UranusView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "uranus")
                Group {
                    planetTitle(title: "Uranus")
                    planetText(text: uranusSummary1)
                    planetImage(name: "uranus2").padding(.top)
                    planetImageSubtext(text: "Diameter comparison of Uranus and Earth. Approximate scale is 90 km/px")
                    planetText(text: uranusSummary2)
                    planetImage(name: "uranus3").padding(.top)
                    planetImageSubtext(text: "This 2006 image taken by the Hubble Space Telescope shows bands and a new dark spot in Uranus' atmosphere.")
                    planetText(text: uranusSummary3)
                    planetImage(name: "uranus4").padding(.top)
                    planetImageSubtext(text: "This image shows a crescent Uranus, a view that Earthlings never witnessed until Voyager 2 flew near and then beyond Uranus on January 24, 1986.")
                }
            }
        }
    }
}

struct UranusView_Previews: PreviewProvider {
    static var previews: some View {
        UranusView()
    }
}

private let uranusSummary1 = "​The seventh planet from the Sun with the third largest diameter in our solar system, Uranus is very cold and windy. The ice giant is surrounded by 13 faint rings and 27 small moons as it rotates at a nearly 90-degree angle from the plane of its orbit. This unique tilt makes Uranus appear to spin on its side, orbiting the Sun like a rolling ball.\n\nThe first planet found with the aid of a telescope, Uranus was discovered in 1781 by astronomer William Herschel, although he originally thought it was either a comet or a star. It was two years later that the object was universally accepted as a new planet, in part because of observations by astronomer Johann Elert Bode."

private let uranusSummary2 = "Uranus' environment is not conducive to life as we know it. The temperatures, pressures, and materials that characterize this planet are most likely too extreme and volatile for organisms to adapt to.\n\nWith a radius of 15,759.2 miles (25,362 kilometers), Uranus is 4 times wider than Earth. If Earth was the size of a nickel, Uranus would be about as big as a softball.\n\nOne day on Uranus takes about 17 hours (the time it takes for Uranus to rotate or spin once). And Uranus makes a complete orbit around the Sun (a year in Uranian time) in about 84 Earth years (30,687 Earth days)."

private let uranusSummary3 = "As an ice giant, Uranus doesn’t have a true surface. The planet is mostly swirling fluids. While a spacecraft would have nowhere to land on Uranus, it wouldn’t be able to fly through its atmosphere unscathed either. The extreme pressures and temperatures would destroy a metal spacecraft.\n\nUranus' atmosphere is mostly hydrogen and helium, with a small amount of methane and traces of water and ammonia. The methane gives Uranus its signature blue color.\n\nWhile Voyager 2 saw only a few discrete clouds, a Great Dark Spot, and a small dark spot during its flyby in 1986 – more recent observations reveal that Uranus exhibits dynamic clouds as it approaches equinox, including rapidly changing bright features."

