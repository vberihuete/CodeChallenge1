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
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var detailContainer: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    private var indexPath: IndexPath!
    private var event: Event!
    
    private var favoriteSelected = false
    
    var delegate: HomeEventsCellDelegate?
    
    
    //MARK: - Setup
    func setup(with event: Event, in indexPath: IndexPath){
        
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.lightGray.cgColor
        self.containerView.layer.cornerRadius = 5
        
        self.event = event
        self.indexPath = indexPath
        
        eventNameLabel.text = event.topLabel
        favoriteImageView.image = favoriteSelected ? #imageLiteral(resourceName: "favorites_selected") : #imageLiteral(resourceName: "favorites_unselected")
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
        
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.favoriteAction(_:))))
        //gradient
       
    }
    
    //MARK: - Action
    @objc private func favoriteAction(_ sender: AnyObject){
        favoriteSelected = !favoriteSelected
        favoriteImageView.image = favoriteSelected ? #imageLiteral(resourceName: "favorites_selected") : #imageLiteral(resourceName: "favorites_unselected")
        delegate?.homeEventSelect(favorite: self.indexPath)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        print("called for \(self.eventNameLabel.text) - id: \(self.event.targetId)")
        if let gradient = self.principalImageView.layer.sublayers?[0] as? CAGradientLayer{
            gradient.frame = self.principalImageView.frame
            self.principalImageView.layer.layoutSublayers()
        }else{
            let gradient = CAGradientLayer()
            gradient.frame = self.principalImageView.frame
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.locations = [0.5, 1.0]
            self.principalImageView.layer.insertSublayer(gradient, at: 0)
        }

    }

}

protocol HomeEventsCellDelegate{
    
    func homeEventSelect(favorite at:IndexPath)
    
    func homeEventSelect(event at: IndexPath)
}
