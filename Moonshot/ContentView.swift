//
//  ContentView.swift
//  Moonshot
//
//  Created by Baymurat Abdumuratov on 02/03/24.
//

import SwiftUI

struct ContentView: View {
    // Decoding astronauts and missions data from JSON files located in the app bundle.
    
    //This dictionary is being a bit tricly for me understand
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // Decoding astronauts and missions data from JSON files located in the app bundle.

    
    @State var buttonLabel: String = "list.bullet.rectangle.fill"
    @State var changingView: Bool = false
    
    var body: some View {
        NavigationStack{
          
//            ListLayout(astronauts: astronauts, missions: missions)
            
            Group {
                if changingView {
                    GridLayout(astronauts: astronauts, missions: missions)
                   
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }  .navigationTitle("Moonshot")
                .background(.darkBackground)
                .toolbar(content: {
                    Button {
                        changingView.toggle()
                        if changingView {
                            buttonLabel = "list.bullet.rectangle.fill"
                           
                        }else{
                            buttonLabel = "square.grid.2x2"
                        }
                    } label: {
                        Image(systemName: buttonLabel)
                            .foregroundStyle(.red)
                    }

                })
            }
            //this is also a bit tricky to understand
            .preferredColorScheme(.dark)
        }
    
}

struct ListLayout:  View{
    var astronauts: [String :Astronaut]
    var missions: [Mission]
    
    var body: some View{
        List{
            ForEach(missions){ mission in
                
                NavigationLink{
                    MissionView(mission: mission, astronaunts: astronauts)
                }label: {
                    HStack{
                        Image(mission.image)
                            .resizable()
                            .frame(width: 60, height: 60)
                        VStack{
                            Text(mission.dislpayName)
                                .font(.headline)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.horizontal)
                        
                        
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
        .padding()
        .clipped()
        .background(Color.darkBackground)
        
    }
}

struct GridLayout: View {
    var astronauts: [String: Astronaut]
    var missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(missions){  mission in
                    
                    NavigationLink{
                        MissionView(mission: mission, astronaunts: astronauts)
                    }label: {
                        
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack{
                                Text(mission.dislpayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                        
                    }
                    
                }
                
            }
            .padding()
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    ContentView()
}
