//
//  SunView.swift
//  Quasar
//
//  Created by William Kitay on 10/28/21.
//
import SDWebImageSwiftUI
import SwiftUI

struct SunView: View {   
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                planetImage(name: "sun-2")
                title
                planetText(text: sunSummary1)
                planetImage(name: "SunSize").padding([.top, .bottom])
                planetText(text: sunSummary2)
                planetImage(name: "RedGiant").padding([.top, .bottom])
                planetText(text: sunSummary3)
                planetImage(name: "solarsystem").padding([.top, .bottom])
            }
        }
    }
    
    var title: some View {
        HStack {
            Text("The Sun")
                .font(.system(size: 45, weight: .bold))
                .foregroundColor(.white)
                .padding([.leading, .trailing, .bottom])
            Spacer()
        }
    }
}

struct planetText: View {
    let text: String
    var body: some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .font(.callout)
            .foregroundColor(.white)
            .padding([.leading, .trailing])
    }
}

struct planetImage: View {
    let name: String
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
    }
}

struct SunViewPreview: PreviewProvider {
    static var previews: some View {
        SunView()
    }
}

let sunSummary1 = "The Sun is the star at the center of the solar system. It is a nearly perfect ball of hot plasma, heated to incandescence by nuclear fusion reactions in its core, radiating the energy mainly as visible light, ultraviolet light, and infrared radiation. It is by far the most important source of energy for life on Earth. \n\nIts diameter is about 109 times that of Earth, and accounts for about 99.86% of the total mass of the Solar System. Roughly three quarters of the Sun's mass consists of hydrogen (~73%). The rest is mostly helium, with much smaller quantities of heavier elements, like oxygen, carbon, neon and iron."

let sunSummary2 = "Although it's common to think of the sun as unique, it's just one of untold trillions of other stars in the universe. In fact, it's actually a fairly common kind of star, and is classified as a G V star or \"Yellow Dwarf Star.\" \n\n The Sun is currently about 4.5 billion years old, and so far has consumed roughly 50% of its hydrogen core. It will continue to radiate for the next 5 billion years. \n \nOnce it runs out of hydrogen however, it will undergo a radical change. As the hydrogen depletes it will form a shell of fusion hydrogen around the core. Gravity will then compress the core, allowing the rest of the sun to expand to such a large size that it envelopes and consumes Earth itself. This is what we call a Red Giant."

let sunSummary3 = "The Sun is orbited by 8 planets, 5 dwarf planets, tens of thousands of asteroids, and trillions of comets. These planets are Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, and Neptune."
