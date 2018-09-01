//
//  EventWorker.swift
//  CodeChallengeTableView
//
//  Created by Vincent Berihuete on 8/31/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import Foundation
import Alamofire

struct EventWorker{
    
    
    /// Loads events from remote and provides in the completion handler the results as an array of [Event]
    ///
    /// - Parameters:
    ///   - startDate: The date where results should begin. By default this is today
    ///   - endDate: The date where results should end. By defaults this is 30 days after today
    ///   - handler: The completion handler that provides the results
    ///   - includeSuggested: Says whether suggested results should be included or not. By default this is true
    func loadEvents(from startDate: String, until endDate: String, suggested includeSuggested : Bool = true, completionHandler handler: @escaping (_ events: [Event], _ statusCode: Int?) -> ()){
        
        var paremeters: [String : String] = [:]
        let headers : [String: String] = ["Accept" : "application/json", "Content-Type": "application/json", "X-Mobile-Platform": "iOS|Android"]
        
        paremeters["startDate"] = startDate
        paremeters["endDate"] = endDate
        paremeters["includeSuggested"] = includeSuggested ? "true" : "false"
        
        Alamofire.request(API.EVENT.URL, method: .post, parameters: paremeters, encoding: JSONEncoding.default, headers: headers).responseJSON{ (data) in
                guard let statusCode = data.response?.statusCode, statusCode == 200, let result = data.result.value as? [[String: Any]] else{
                    Dispatch.main{
                        handler([], data.response?.statusCode)
                    }
                    
                    return
                }
                var events : [Event] = []
                result.forEach({ (rawEvent) in
                    events.append(Event(from: rawEvent))
                })
                
                Dispatch.main{
                    handler(events, statusCode)
                }
        }
//            .responseString{ data in
//
//            print(data)
//
//        }
        
//
    }
}
