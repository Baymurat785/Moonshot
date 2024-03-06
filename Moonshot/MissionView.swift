//
//  MissionView.swift
//  Moonshot
//
//  Created by Baymurat Abdumuratov on 05/03/24.
//

import SwiftUI

struct CrewMember{
    let role: String // The crew member's role in the mission.
    let astronaunt: Astronaut  // The astronaut details.
}

struct MissionView: View {
    
    // Nested struct to represent a crew member, including their role and astronaut details.
    
    let mission: Mission  // Holds the mission details.
    let crew: [CrewMember] // An array of `CrewMember` representing the crew of the mission.
    
    var body: some View {
        ScrollView{
            VStack{
                // Displays the mission's image, resizable and scaled to fit the available space.
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                
                // Adjusts the image size relative to its container.
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                //Adding a launch date
                Text(mission.formattedLaunchDate)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                // A visual separator.
               Divider()
                
                // Displays the mission's highlights and description.
                VStack(alignment: .leading){
                    Text("Mission of highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                }
                .padding(.horizontal)
                
                // Another visual separator.
               Divider()
                
                Text("Crew")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .font(.title.bold())
                    .padding(.bottom, 5)

                
                // A horizontal scroll view for the crew members
                HorizontalScrollView(crewMembers: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.dislpayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    // Initializes `MissionView` with mission details and a dictionary of astronauts
    init(mission: Mission, astronaunts: [String: Astronaut]) {
        self.mission = mission
        
        // Maps each crew member in the mission to a `CrewMember` instance.
        // It looks up each crew member's details in the provided astronauts dictionary.
        self.crew = mission.crew.map{ member in
            //keep in mind that this is a dictionary
            if let astronaunt = astronaunts[member.name]{
                
                return CrewMember(role: member.role, astronaunt: astronaunt)
            }else{
                
                fatalError("Missing \(member.name)")
            }
            
        }
    }
}


//MARK: - Horizontal ScrollView for the Crew Members at the bottom

struct HorizontalScrollView: View{
    var crewMembers :[CrewMember]
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: true){
            HStack(spacing: 10){
                ForEach(crewMembers, id: \.role){crewMember in
                    NavigationLink{
                        // Links to the `AstronautView` of the selected crew member.
                        AstronautView(astronaunt: crewMember.astronaunt)
                        
                    }label: {
                        HStack{
                            Image(crewMember.astronaunt.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay{
                                    Capsule()
                                        .stroke(Color.white, lineWidth: 1.0)
                                }
                            
                            VStack(alignment: .leading){
                                Text(crewMember.astronaunt.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
        
                        }
                        .padding(.horizontal)
                    }
                }

            }
        }
    }
    
    
}


//MARK: - Separator line
struct Divider: View{
    var body: some View{
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}
// A preview section for the `MissionView`.
// It decodes an instance of `Mission` and a dictionary of `Astronaut` from bundled JSON files.

#Preview {
    let mission: [Mission] = Bundle.main.decode("mission.json")
    let astronaunts: [String: Astronaut] = Bundle.main.decode("astronaunts.json")
    
    return MissionView(mission: mission[0], astronaunts: astronaunts)
        .preferredColorScheme(.dark)
}
