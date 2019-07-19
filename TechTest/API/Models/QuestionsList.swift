//
//  QuestionsList.swift
//  TechTest
//
//  Created by Amir Daliri on 20.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionsList: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let question = "question"
        static let id = "id"
        static let thumbUrl = "thumb_url"
        static let publishedAt = "published_at"
        static let imageUrl = "image_url"
        static let choices = "choices"
    }
    
    // MARK: Properties
    public var question: String?
    public var id: Int?
    public var thumbUrl: String?
    public var publishedAt: String?
    public var imageUrl: String?
    public var choices: [Choices]?
    
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
        id <- map[SerializationKeys.id]
        thumbUrl <- map[SerializationKeys.thumbUrl]
        publishedAt <- map[SerializationKeys.publishedAt]
        imageUrl <- map[SerializationKeys.imageUrl]
        choices <- map[SerializationKeys.choices]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = question { dictionary[SerializationKeys.question] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = thumbUrl { dictionary[SerializationKeys.thumbUrl] = value }
        if let value = publishedAt { dictionary[SerializationKeys.publishedAt] = value }
        if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
        if let value = choices { dictionary[SerializationKeys.choices] = value.map { $0.dictionaryRepresentation() } }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.question = aDecoder.decodeObject(forKey: SerializationKeys.question) as? String
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.thumbUrl = aDecoder.decodeObject(forKey: SerializationKeys.thumbUrl) as? String
        self.publishedAt = aDecoder.decodeObject(forKey: SerializationKeys.publishedAt) as? String
        self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
        self.choices = aDecoder.decodeObject(forKey: SerializationKeys.choices) as? [Choices]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(question, forKey: SerializationKeys.question)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(thumbUrl, forKey: SerializationKeys.thumbUrl)
        aCoder.encode(publishedAt, forKey: SerializationKeys.publishedAt)
        aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
        aCoder.encode(choices, forKey: SerializationKeys.choices)
    }
    
}

