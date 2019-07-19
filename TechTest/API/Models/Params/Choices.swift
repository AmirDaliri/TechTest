//
//  Choices.swift
//  TechTest
//
//  Created by Amir Daliri on 20.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import ObjectMapper

class Choices: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let choice = "choice"
        static let votes = "votes"
    }
    
    // MARK: Properties
    public var choice: String?
    public var votes: Int?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        choice <- map[SerializationKeys.choice]
        votes <- map[SerializationKeys.votes]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = choice { dictionary[SerializationKeys.choice] = value }
        if let value = votes { dictionary[SerializationKeys.votes] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.choice = aDecoder.decodeObject(forKey: SerializationKeys.choice) as? String
        self.votes = aDecoder.decodeObject(forKey: SerializationKeys.votes) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(choice, forKey: SerializationKeys.choice)
        aCoder.encode(votes, forKey: SerializationKeys.votes)
    }
    
}

