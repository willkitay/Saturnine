//
//  EarthView.swift
//  Saturnine
//
//  Created by William Kitay on 10/31/21.
//

import SwiftUI

struct EarthView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "earth").padding([.leading, .trailing])
                Group {
                    planetTitle(title: "Earth")
                    planetText(text: earthSummary1)
                    planetImage(name: "earth2").padding(.top)
                    planetImageSubtext(text: "The famous 'Earthrise' photo taken by Apollo 8 astronauts during their trip around the moon on Dec. 24, 1968.")
                    planetText(text: earthSummary2)
                    planetImage(name: "earth3").padding(.top)
                    planetImageSubtext(text: "Through the brilliance of Saturn’s rings, Cassini caught a glimpse of a far-away planet and its moon. At a distance of just under 900 million miles, Earth shines bright among the many stars in the sky, distinguished by its bluish tint.")
                    planetText(text: earthSummary3)
                    planetImage(name: "earth4").padding(.top)
                    planetImageSubtext(text: "Earth as seen from the ISS at night. Courtesy of NASA.")
                }
            }
        }
    }
}

struct EarthView_Previews: PreviewProvider {
    static var previews: some View {
        EarthView()
    }
}

private let earthSummary1 = "Our home planet is the third planet from the Sun, and the only place we know of so far that’s inhabited by living things. While Earth is only the fifth largest planet in the solar system, it is the only world in our solar system with liquid water on the surface.\n\nJust slightly larger than nearby Venus, Earth is the biggest of the four planets closest to the Sun, all of which are made of rock and metal. The name Earth is at least 1,000 years old."

private let earthSummary2 = "Earth's outer layer is divided into several rigid tectonic plates that migrate across the surface over many millions of years, while its interior remains active with a solid iron inner core, a liquid outer core that generates Earth's magnetic field, and a convective mantle that drives plate tectonics.\n\nEarth's atmosphere consists mostly of nitrogen and oxygen. Chemical reactions led to the first self-replicating molecules about four billion years ago. A half billion years later, the last common ancestor of all current life arose.\n\nThe evolution of photosynthesis allowed the Sun's energy to be harvested directly by life forms. The resultant molecular oxygen accumulated in the atmosphere and due to interaction with ultraviolet solar radiation, formed a protective ozone layer in the upper atmosphere."

private let earthSummary3 = "Because carbon dioxide (CO2) has a long lifespan in the atmosphere, moderate human CO2 emissions may postpone the next glacial inception by 100,000 years. Earth's expected long-term future is tied to that of the Sun. Over the next 1.1 billion years, solar luminosity will increase by 10%, and over the next 3.5 billion years by 40%.\n\nEarth's increasing surface temperature will accelerate the inorganic carbon cycle, reducing CO2 concentration to levels lethally low for plants (10 ppm for C4 photosynthesis) in approximately 100–900 million years. The lack of vegetation will result in the loss of oxygen in the atmosphere, making animal life impossible.\n\nThe Sun will evolve to become a red giant in about 5 billion years. Models predict that the Sun will expand to roughly 1 AU (150 million km; 93 million mi), about 250 times its present radius. Earth's fate is less clear.\n\nAs a red giant, the Sun will lose roughly 30% of its mass, so, without tidal effects, Earth will move to an orbit of 160 million miles from the Sun when the star reaches its maximum radius, otherwise, with tidal effects, it may enter the Sun's atmosphere and be vaporized."
