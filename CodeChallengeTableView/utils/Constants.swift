//
//  Constants.swift
//  CodeChallengeTableView
//
//  Created by Vincent Berihuete on 8/31/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import Foundation
import UIKit

struct API{
    static let SERVER = "https://webservices.vividseats.com/rest/mobile/v1"
    struct EVENT{
        static let URL = "\(API.SERVER)/home/cards"
    }
}

struct COLORS{
    static let RED = UIColor(red: 233/255, green: 16/255, blue: 27/255, alpha: 1)
}
