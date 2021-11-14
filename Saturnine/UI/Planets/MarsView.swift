//
//  MarsView.swift
//  Saturnine
//
//  Created by William Kitay on 10/31/21.
//

import SwiftUI

struct MarsView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "mars").padding([.leading, .trailing])
                Group {
                    planetTitle(title: "Mars")
                    planetText(text: marsSummary1)
                    planetImage(name: "mars2").padding(.top)
                    planetImageSubtext(text: "This 2016 self-portrait of the Curiosity Mars rover shows the vehicle at the Quela drilling location in the Murray Buttes area on lower Mount Sharp. Courtesy of JPL-Caltech/MSSS/NASA")
                    planetText(text: marsSummary2)
                    planetImage(name: "mars3").padding(.top)
                    planetImageSubtext(text: "The European Space Agency's Mars Express mission captured this 2018 image of the Korolev crater, more than 50 miles across and filled with water ice, near the north pole. Courtesy of the ESA/DLR/FU Berlin")
                    planetText(text: marsSummary3)
                    planetImage(name: "mars4").padding(.top)
                    planetImageSubtext(text: "The Ingenuity helicopter captured this color image of Mars from 16 feet above the planet's surface in April 2021. It's the first color image ever taken during flight by a rotorcraft on Mars. Courtesy of JPL-Caltech/NASA")
                }
            }
        }
    }
}

struct MarsView_Previews: PreviewProvider {
    static var previews: some View {
        MarsView()
    }
}

private let marsSummary1 = "​Mars is the fourth planet from the Sun – a dusty, cold, desert world with a very thin atmosphere. Mars is also a dynamic planet with seasons, polar ice caps, canyons, extinct volcanoes, and evidence that it was even more active in the past.\n\nNASA currently has two rovers (Curiosity and Perseverance), one lander (InSight), and one helicopter (Ingenuity) exploring the surface of Mars. Perseverance rover – the largest, most advanced rover NASA has sent to another world – touched down on Mars on Feb. 18, 2021, after a 203-day journey traversing 293 million miles. The Ingenuity helicopter rode to Mars attached to the belly of Perseverance."

private let marsSummary2 = "One day on Mars takes a little over 24 hours. Mars makes a complete orbit around the Sun (a year in Martian time) in 687 Earth days. There is a thin atmosphere made up mostly of carbon dioxide (CO2), argon (Ar), nitrogen (N2), and a small amount of oxygen and water vapor.\n\nMars is known as the Red Planet because iron minerals in the Martian soil oxidize, or rust, causing the soil and atmosphere to look red. At this time, Mars' surface cannot support life as we know it. Current missions are determining Mars' past and future potential for life."

private let marsSummary3 = "Mars has no global magnetic field today, but areas of the Martian crust in the southern hemisphere are highly magnetized, indicating traces of a magnetic field from 4 billion years ago.​ Occasionally, winds on Mars are strong enough to create dust storms that cover much of the planet. After such storms, it can be months before all of the dust settles.\n\nMars appears to have had a watery past, with ancient river valley networks, deltas, and lakebeds, as well as rocks and minerals on the surface that could only have formed in liquid water. Some features suggest that Mars experienced huge floods about 3.5 billion years ago.\n\nThere is water on Mars today, but the Martian atmosphere is too thin for liquid water to exist for long on the surface. Today, water on Mars is found in the form of water-ice just under the surface in the polar regions as well as in briny (salty) water, which seasonally flows down some hillsides and crater walls."
