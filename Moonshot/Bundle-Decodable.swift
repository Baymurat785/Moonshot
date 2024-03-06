//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Baymurat Abdumuratov on 04/03/24.
//

import Foundation

// Extends the `Bundle` class to include a generic decoding method
extension Bundle{
    
    //Generic function `decode` that takes a file name and returns a decoded instance of type 'T', where 'T' conforms to 'Codable'
    func decode<T: Codable>(_ file: String) -> T{
       
        // Attempts to find the URL for the specified file within the bundle. If unsuccessful, it triggers a fatal error with a descriptive message.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to loacate \(file) in budnle")
        }
        
        // Attempts to load the data from the URL. If unsuccessful, it triggers a fatal error with a descriptive message
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to load \(file) from bundle")
        }
        
        // Creates an instance of `JSONDecoder` to decode the data.
        let decoder = JSONDecoder()
        
        // Configures the decoder with a custom date format to correctly parse dates from the JSON data
        // This approach allows flexibility in handling various date formats within the JSON
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        // Attempts to decode the data into an instance of type `T`.
        // If unsuccessful, it triggers a fatal error with a descriptive message.
        // The comment here indicates confusion about the `decode` method's first parameter,
        // which specifies the type to decode into, not a dictionary.
        
        guard let loaded = try? decoder.decode(T.self, from: data) else{
            fatalError("Failed to decode \(file) from bundle")
        }
        
        //returns the decoded instance
        return loaded
    }
}
