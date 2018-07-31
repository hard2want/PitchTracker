//
//  Company.swift
//  Pitch Tracker
//
//  Created by The Duke on 7/30/18.
//  Copyright © 2018 The Duke. All rights reserved.
//

import Foundation

struct Company: Codable {
    var companyName: String
    var description: String
    var city: String
    var state: String
    var website: String

    init(companyName: String, description: String, city: String, state: String, website: String) {
        self.companyName = companyName
        self.description = description
        self.city = city
        self.state = state
        self.website = website
    } // end init()
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("companies").appendingPathExtension("plist")
    
    // -------- SaveToFile
    
    static func saveToFile(companies: [Company]){
        let propertyListEncoder = PropertyListEncoder()
        let encodedCompanies = try? propertyListEncoder.encode(companies)
        try? encodedCompanies?.write(to: archiveURL, options: .noFileProtection)
    } // end saveToFile()
    
    
    // -------- loadFromFile
    
    static func loadFromFile() -> [Company]? {
        let propertyListDecoder = PropertyListDecoder()
        // attempts to a URL if data already exists
        if let retrievedCompaniesData = try? Data(contentsOf: archiveURL) {
            let decodedCompanies = try? propertyListDecoder.decode([Company].self, from: retrievedCompaniesData)
            // if the data exists, return the existing data
            return decodedCompanies!}
        // else call the sampleCompanies() and return the starter data
        return sampleCompanies()
    } // end loadFromFile
    
    
    // --------- sample Company array
    
    static func sampleCompanies() -> [Company]{
        let sampleCompanies: [Company] = [
            // fake startups
            Company(companyName: "Cybrary", description: "Cybrary is an open-source cyber security and IT learning and certification preparation platform. Connect to an ecosystem of people, companies, content, and technologies to create and access and ever growing catalog of online courses and experiential tools providing cyber security, learning opportunities to anyone, anywhere, anytime.", city: "Greenbelt", state: "MD", website: "https://www.cybrary.it")]
        return sampleCompanies
    } // end sampleCompanies()

    
    
    
} // end struct Company



