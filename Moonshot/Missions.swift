//
//  CrewRole.swift
//  Moonshot
//
//  Created by Baymurat Abdumuratov on 04/03/24.
//

import Foundation



//Defines a `Mission` struture conforming to `Codable` and `Identifiable` for easy JSON parsing and identification in SwiftUI lists.
struct Mission: Codable, Identifiable{
    
    
    //Nested `CrewRole` struct represents each crew member's role in the mission
    //It includes the crew member's name and their specific role, both as `String` values.
    struct CrewRole: Codable{
        let name: String //Crew member's name
        let role: String //The role of the crew member in the mission
    }
    
    
    // ID for uniquely identifying the mission, required by the `Identifiable` protocol
    let id: Int
    // Optional `launchDate` properly that might not be set for all missions
    let launchDate: Date?
    //An array of `CrewRole` instances representing the crew members involved in the mission
    var crew:  [CrewRole]
    //A description of the mission
    let description: String
    
    //Computed property to generate a display name for the mission, prefix with "Apollo"
    var dislpayName: String{
        "Apollo \(id)"
    }
    
    //Computed property to generate the image name associated with the mission, based on its `id`
    var image: String{
        "apollo\(id)"
    }
    
    
    //Computed property to format the launch date as a string
    //if `lauchDate` is not nil, it formats the date; otherwise, it returns N/A
    var formattedLaunchDate: String{
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
