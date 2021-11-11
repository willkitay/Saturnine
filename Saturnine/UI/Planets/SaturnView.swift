//
//  SaturnView.swift
//  Saturnine
//
//  Created by William Kitay on 10/31/21.
//

import SwiftUI

struct SaturnView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "saturn")
                Group {
                    planetTitle(title: "Saturn")
                    planetText(text: saturnSummary1)
                    planetImage(name: "saturn2").padding(.top)
                    planetImageSubtext(text: "Saturn's northern polar vortex captured by Cassini. (NASA/JPL-Caltech/Space Science Institute.)")
                    planetText(text: saturnSummary2)
                    planetImage(name: "saturn3").padding(.top)
                    planetImageSubtext(text: "This image made available by NASA in April 2017 shows the Cassini spacecraft diving between Saturn and the planet's innermost rings. Cassini was launched in 1997 and reached Saturn in 2004.")
                    planetText(text: saturnSummary3)
                    planetImage(name: "saturn4").padding(.top)
                    planetImageSubtext(text: "'THE DAY THE EARTH SMILED' In this rare image taken on 19 July 2013, the wide-angle camera on NASA's Cassini spacecraft has captured Saturn's rings and our planet Earth and its Moon in the same frame. Courtesy of NASA/JPL-Caltech/SSI")
                }
            }
        }
    }
}

struct SaturnView_Previews: PreviewProvider {
    static var previews: some View {
        SaturnView()
    }
}

private let saturnSummary1 = "​Saturn is the sixth planet from the Sun and the second-largest planet in our solar system. Like fellow gas giant Jupiter, Saturn is a massive ball made mostly of hydrogen and helium. Saturn is not the only planet to have rings, but none are as spectacular or as complex as Saturn's. Saturn also has dozens of moons. From the jets of water that spray from Saturn's moon Enceladus to the methane lakes on smoggy Titan, the Saturn system is a rich source of scientific discovery and still holds many mysteries.\n\nSaturn's environment is not conducive to life as we know it. The temperatures, pressures, and materials that characterize this planet are most likely too extreme and volatile for organisms to adapt to. While planet Saturn is an unlikely place for living things to take hold, the same is not true of some of its many moons. Satellites like Enceladus and Titan, home to internal oceans, could possibly support life."

private let saturnSummary2 = "With a radius of 36,183.7 miles (58,232 kilometers), Saturn is 9 times wider than Earth. If Earth were the size of a nickel, Saturn would be about as big as a volleyball. From an average distance of 886 million miles (1.4 billion kilometers), Saturn is 9.5 astronomical units away from the Sun. One astronomical unit (abbreviated as AU), is the distance from the Sun to Earth. From this distance, it takes sunlight 80 minutes to travel from the Sun to Saturn.\n\nSaturn has the second-shortest day in the solar system. One day on Saturn takes only 10.7 hours (the time it takes for Saturn to rotate or spin around once), and Saturn makes a complete orbit around the Sun (a year in Saturnian time) in about 29.4 Earth years (10,756 Earth days). Saturn is home to a vast array of intriguing and unique worlds.\n\nFrom the haze-shrouded surface of Titan to crater-riddled Phoebe, each of Saturn's moons tells another piece of the story surrounding the Saturn system. Currently, Saturn has 53 confirmed moons with 29 additional provisional moons awaiting confirmation."

private let saturnSummary3 = "Saturn's rings are thought to be pieces of comets, asteroids, or shattered moons that broke up before they reached the planet, torn apart by Saturn's powerful gravity. They are made of billions of small chunks of ice and rock coated with other materials such as dust. The ring particles mostly range from tiny, dust-sized icy grains to chunks as big as a house. A few particles are as large as mountains. The rings would look mostly white if you looked at them from the cloud tops of Saturn, and interestingly, each ring orbits at a different speed around the planet.\n\nAs a gas giant, Saturn doesn’t have a true surface. The planet is mostly swirling gases and liquids deeper down. While a spacecraft would have nowhere to land on Saturn, it wouldn’t be able to fly through unscathed either. The extreme pressures and temperatures deep inside the planet would crush, melt, and vaporize any spacecraft trying to fly into the planet.\n\nSaturn took shape when the rest of the solar system formed about 4.5 billion years ago when gravity pulled swirling gas and dust in to become this gas giant. About 4 billion years ago, Saturn settled into its current position in the outer solar system, where it is the sixth planet from the Sun. Like Jupiter, Saturn is mostly made of hydrogen and helium, the same two main components that make up the Sun."
