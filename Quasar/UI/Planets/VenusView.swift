//
//  VenusView.swift
//  Quasar
//
//  Created by William Kitay on 10/31/21.
//

import SwiftUI

struct VenusView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "venus")
                planetTitle(title: "Venus")
                planetText(text: venusSummary1)
                planetImage(name: "venus3").padding([.top])
                planetImageSubtext(text: "Taken by the Parker Solar Probe from 7,700 miles away. The bright rim around the planet is called nightglow, which happens when the oxygen atoms in the atmosphere recombine into molecules, giving off a slight glow. Courtesy of NASA, 2021")
                planetText(text: venusSummary2)
                planetImage(name: "venus2").padding([.top, .bottom])
                planetText(text: venusSummary3).padding(.bottom)
                planetImage(name: "venus4")
            }
        }
    }
}

struct VenusView_Previews: PreviewProvider {
    static var previews: some View {
        VenusView()
    }
}

private let venusSummary1 = "Venus is the second planet from the Sun and is Earth's closest planetary neighbor. It's one of the four inner terestrial planets, and is very similar in size and density to Earth. Venus has a thick, toxic atmosphere filled with carbon dioxide and is perpetually shrouded in thick yellowish clouds of sulphuric acid. \n\nThe clouds trap heat, causing a runaway greenhouse effect. It's the hottest planet in our solar system even though mercury is closer to the Sun. In fact, surface temperatures can reach 900 degrees Fahrenheit, which is hot enough to melt lead.\n\n The surface of Venus is a rusty color that is peppered with intensely crunched mountains and thousands of large volcanoes, some of which might still be active. On the surface, the air pressure is over 90x that of Earth, which is comparable to being a mile below the ocean."

private let venusSummary2 = "Another big difference from Earth – Venus rotates on its axis backward, compared to most of the other planets in the solar system. This means that, on Venus, the Sun rises in the west and sets in the east, opposite to what we experience on Earth. (It’s not the only planet in our solar system with such an oddball rotation – Uranus spins on its side). \n\nVenus was the first planet to be explored by a spacecraft – NASA’s Mariner 2 successfully flew by and scanned the cloud-covered world on Dec. 14, 1962. Since then, numerous spacecraft from the U.S. and other space agencies have explored Venus, including NASA’s Magellan, which mapped the planet's surface with radar. \n\nSoviet spacecraft made the most successful landings on the surface of Venus to date, but they didn’t survive long due to the extreme heat and crushing pressure. An American probe, one of NASA's Pioneer Venus Multiprobes, survived for about an hour after impacting the surface in 1978."

private let venusSummary3 = "The average surface of Venus is less than a billion years old, and possibly as young as 150 million years old – which is relatively young from a geological perspective. This is a major conundrum for scientists – they don’t know exactly what happened that made Venus completely resurface itself.\n\nVenus is an unlikely place for life as we know it, but some scientists theorize microbes might exist high in the clouds where it’s cooler and the pressure is similar to Earth’s surface. Phosphine, a possible indicator of microbial life, has been observed in the clouds."
