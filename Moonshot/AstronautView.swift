//
//  AstronauntView.swift
//  Moonshot
//
//  Created by Baymurat Abdumuratov on 05/03/24.
//

import SwiftUI

struct AstronautView: View {
    let astronaunt: Astronaut
    
    var body: some View {
        
        // A `ScrollView` allows the content to be scrollable if it exceeds the screen size.
        ScrollView{
            VStack{
                // Displays the astronaut's image, resizable and scaled to fit the available space.
                Image(astronaunt.id)
                    .resizable()
                    .scaledToFit()
                
                // Displays the astronaut's description with padding around the text.
                Text(astronaunt.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        // Sets the navigation bar title to the astronaut's name, displayed inline.
        .navigationTitle(astronaunt.name)
        .navigationTitle(astronaunt.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // Decodes the astronauts dictionary from the bundled "astronauts.json" file
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return AstronautView(astronaunt: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
