//
//  HomeEventsTableViewCell.swift
//  CodeChallengeTableView
//
//  Created by Vincent Berihuete on 8/31/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import UIKit
import Kingfisher

class HomeEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var principalImageView: UIImageView!
    @IBOutlet weak var detailContainer: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    private var indexPath: IndexPath!
    private var event: Event!
    
    func setup(with event: Event, in indexPath: IndexPath){
        
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.lightGray.cgColor
        self.containerView.layer.cornerRadius = 5
        
        self.event = event
        self.indexPath = indexPath
        
        locationLabel.text = event.middleLabel
        dateLabel.text = event.bottomLabel
        countLabel.text = "" //TODO: ADD LOCALIZED STRING
        principalImageView.kf.indicatorType = .activity
        let imageUrl = URL(string: event.imageUrl)
        if let url = imageUrl{
            principalImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_img"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            principalImageView.image = #imageLiteral(resourceName: "placeholder_img")
        }
        
    }

}
