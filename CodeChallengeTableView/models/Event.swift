//
//  Event.swift
//  CodeChallengeTableView
//
//  Created by Vincent Berihuete on 8/31/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import Foundation


struct Event {
    var topLabel: String
    var middleLabel: String
    var bottomLabel: String
    var eventCount: Int
    var imageUrl: String
    var targetId: Int
    var startDate: Int64
    var rank: Int
    
    init(topLabel: String, middleLabel: String, bottomLabel: String, eventCount: Int, imageUrl: String, targetId: Int, startDate: Int64, rank: Int) {
        self.topLabel = topLabel
        self.middleLabel = middleLabel
        self.bottomLabel = bottomLabel
        self.eventCount = eventCount
        self.imageUrl = imageUrl
        self.targetId = targetId
        self.startDate = startDate
        self.rank = rank
    }
    
    
    /// Creates an instance of the object based on a dictionary containing the values
    ///
    /// - Parameter dictionary: The dictionary that might have come from an external source to be parsed as an object
    init(from dictionary: [String: Any]) {
        self.topLabel = dictionary["topLabel"] as? String ?? ""
        self.middleLabel =  dictionary["middleLabel"] as? String ?? ""
        self.bottomLabel =  dictionary["bottomLabel"] as? String ?? ""
        self.eventCount =  dictionary["eventCount"] as? Int ?? 0
        self.imageUrl =  dictionary["image"] as? String ?? ""
        self.targetId = dictionary["targetId"] as? Int ?? 0
        self.startDate = dictionary["startDate"] as? Int64 ?? 0
        self.rank = dictionary["startDate"] as? Int ?? 0
    }
    
    
    /// Retrieves the object as a dictionary
    var dictionary : [String: Any]{
        get{
            var parsed : [String: Any] = [:]
            parsed["topLabel"] = self.topLabel
            parsed["middleLabel"] = self.middleLabel
            parsed["bottomLabel"] = self.bottomLabel
            parsed["eventCount"] = self.eventCount
            parsed["image"] = self.imageUrl
            parsed["targetId"] = self.targetId
            parsed["startDate"] = self.startDate
            parsed["rank"] = self.rank
            
            return parsed
        }
    }
}
