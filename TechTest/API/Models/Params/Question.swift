//
//  Question.swift
//  TechTest
//
//  Created by Amir Daliri on 20.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import ObjectMapper

class Question: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let question = "question"
        static let thumbUrl = "thumb_url"
        static let choices = "choices"
        static let imageUrl = "image_url"
    }
    
    // MARK: Properties
    public var question: String?
    public var thumbUrl: String?
    public var choices: [Choices]?
    public var imageUrl: String?
    
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
        question <- map[SerializationKeys.question]
        thumbUrl <- map[SerializationKeys.thumbUrl]
        choices <- map[SerializationKeys.choices]
        imageUrl <- map[SerializationKeys.imageUrl]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = question { dictionary[SerializationKeys.question] = value }
        if let value = thumbUrl { dictionary[SerializationKeys.thumbUrl] = value }
        if let value = choices { dictionary[SerializationKeys.choices] = value }
        if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.question = aDecoder.decodeObject(forKey: SerializationKeys.question) as? String
        self.thumbUrl = aDecoder.decodeObject(forKey: SerializationKeys.thumbUrl) as? String
        self.choices = aDecoder.decodeObject(forKey: SerializationKeys.choices) as? [Choices]
        self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(question, forKey: SerializationKeys.question)
        aCoder.encode(thumbUrl, forKey: SerializationKeys.thumbUrl)
        aCoder.encode(choices, forKey: SerializationKeys.choices)
        aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
    }
    
}
