//
//  JupiterView.swift
//  Quasar
//
//  Created by William Kitay on 10/31/21.
//

import SwiftUI

struct JupiterView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "jupiter")
                Group {
                    planetTitle(title: "Jupiter")
                    planetText(text: jupiterSummary1)
                    planetImage(name: "jupiter2").padding(.top)
                    planetImageSubtext(text: "Jupiter's diameter is one order of magnitude smaller (×0.10045) than that of the Sun, and one order of magnitude larger (×10.9733) than that of Earth. The Great Red Spot is roughly the same size as Earth.")
                    planetText(text: jupiterSummary2)
                    planetImage(name: "jupiter3").padding(.top)
                    planetImageSubtext(text: "Close up of The Great Red Spot, Taken by the Juno spacecraft, in April 2018.")
                    planetText(text: jupiterSummary3)
                    planetImage(name: "jupiter4").padding(.top)
                    planetImageSubtext(text: "A photograph of Jupiter taken by the Juno spacecraft, at the end of a close flyby in September 2018")
                }
            }
        }
    }
}

struct JupiterView_Previews: PreviewProvider {
    static var previews: some View {
        JupiterView()
    }
}

private let jupiterSummary1 = "​Jupiter is the fifth planet from our Sun and is, by far, the largest planet in the solar system – more than twice as massive as all the other planets combined. Jupiter's stripes and swirls are actually cold, windy clouds of ammonia and water, floating in an atmosphere of hydrogen and helium. Jupiter’s iconic Great Red Spot is a giant storm bigger than Earth that has raged for hundreds of years\n\nJupiter’s environment is probably not conducive to life as we know it. The temperatures, pressures, and materials that characterize this planet are most likely too extreme and volatile for organisms to adapt to. While planet Jupiter is an unlikely place for living things to take hold, the same is not true of some of its many moons. Europa is one of the likeliest places to find life elsewhere in our solar system.\n\nThere is evidence of a vast ocean just beneath its icy crust, where life could possibly be supported. Jupiter is surrounded by dozens of moons. Jupiter also has several rings, but unlike the famous rings of Saturn, Jupiter’s rings are very faint and made of dust, not ice."

private let jupiterSummary2 = "Jupiter took shape when the rest of the solar system formed about 4.5 billion years ago when gravity pulled swirling gas and dust in to become this gas giant. Jupiter took most of the mass left over after the formation of the Sun, ending up with more than twice the combined material of the other bodies in the solar system. In fact, Jupiter has the same ingredients as a star, but it did not grow massive enough to ignite. About 4 billion years ago, Jupiter settled into its current position in the outer solar system, where it is the fifth planet from the Sun.\n\nAs a gas giant, Jupiter doesn’t have a true surface. The planet is mostly swirling gases and liquids. While a spacecraft would have nowhere to land on Jupiter, it wouldn’t be able to fly through unscathed either. The extreme pressures and temperatures deep inside the planet crush, melt, and vaporize spacecraft trying to fly into the planet."

private let jupiterSummary3 = "Jupiter's appearance is a tapestry of colorful cloud bands and spots. The gas planet likely has three distinct cloud layers in its 'skies' that, taken together, span about 44 miles (71 kilometers). The top cloud is probably made of ammonia ice, while the middle layer is likely made of ammonium hydrosulfide crystals. The innermost layer may be made of water ice and vapor.\n\nThe vivid colors you see in thick bands across Jupiter may be plumes of sulfur and phosphorus-containing gases rising from the planet's warmer interior. Jupiter's fast rotation – spinning once every 10 hours – creates strong jet streams, separating its clouds into dark belts and bright zones across long stretches.\n\nWith no solid surface to slow them down, Jupiter's spots can persist for many years. Stormy Jupiter is swept by over a dozen prevailing winds, some reaching up to 335 miles per hour (539 kilometers per hour) at the equator. The Great Red Spot, a swirling oval of clouds twice as wide as Earth, has been observed on the giant planet for more than 300 years. More recently, three smaller ovals merged to form the Little Red Spot, about half the size of its larger cousin."
