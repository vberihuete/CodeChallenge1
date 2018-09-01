//
//  EventConfigurator.swift
//  CodeChallengeTableView
//
//  Created by Vincent Berihuete on 8/31/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import Foundation


//handler([], data.response?.statusCode)

struct EventConfigurator{
    
    static var shared = EventConfigurator()
    
    private let eventWorker = EventWorker()
    
    private var dateFormatter = DateFormatter(){
        didSet{
            self.dateFormatter.dateFormat = "dd-MM-yyyy"
        }
    }
    
    /// Loads events from remote and provides in the completion handler the results as an array of [Event]
    ///
    /// - Parameters:
    ///   - startDate: The date where results should begin. By default this is today
    ///   - endDate: The date where results should end. By defaults this is 30 days after today
    ///   - handler: The completion handler that provides the results
    ///   - includeSuggested: Says whether suggested results should be included or not. By default this is true
    func loadEvents(from startDate: Date = Date(), until endDate: Date = Calendar.current.date(byAdding: .day, value: 30, to: Date()) ?? Date(), suggested includeSuggested : Bool = true, completionHandler handler: @escaping (_ events: [Event], _ statusCode: Int?) -> ()){
        
        eventWorker.loadEvents(from: dateFormatter.string(from: startDate), until: dateFormatter.string(from: endDate), suggested: includeSuggested){ events, statusCode in
            handler(events, statusCode)
        }
    }
    
    /// Filters if provided a given list of events based on a criteria. if it's not provided the server will be issued
    ///
    /// - Parameters:
    ///   - searchCriteria: The string to look for
    ///   - events: The list of events to search into (optional)
    ///   - handler: The completion handler that provides the results
    /// - Returns: The event that match with the search criteria
    func filterEvents(with searchCriteria: String, on events: [Event] = [], completionHandler handler: ([Event]) -> ()){
        //TODO: implement server search on empty events
        handler(eventWorker.filterEvents(with: searchCriteria, on: events))
    }
}
