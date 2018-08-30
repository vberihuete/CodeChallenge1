//
//  FilterView.swift
//  testtable
//
//  Created by Vincent Berihuete on 8/30/18.
//  Copyright © 2018 Vincent Berihuete. All rights reserved.
//

import UIKit

class FilterView: UIStackView {
    
    private var items : [TopTabItem] = []
    
    private var color : UIColor = UIColor.black
    private var selectedColor = UIColor.red
    private var selectedIndex = 0
    private weak var selectedItem: TopTabItem?
    
    var delegate : FilterViewDelegate?
    
    // MARK: - init
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    init(items elements: [String] = [], color: UIColor = UIColor.black, selectedColor: UIColor = UIColor.red, selectedIndex selected: Int = 0){
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 40))
        self.color = color
        self.selectedColor = selectedColor
        self.selectedIndex = selected
        setup(items: elements)
    }
    
    
    
    // MARK: - setup
    
    /// The initial setup of views. Does the layout
    ///
    /// - Parameter elements: an array of strings representing the filter items to be created
    private func setup(items elements: [String] = []){
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, element) in elements.enumerated(){
            let topTabItem = TopTabItem(identifier: index, label: element, color: self.color)
            topTabItem.delegate = self
            self.addArrangedSubview(topTabItem)
            if(index == selectedIndex){
                topTabItem.markSelected(in: 0, with: self.selectedColor, from: .left)
                selectedItem = topTabItem
            }
            self.items.append(topTabItem)
        }
        
    }
    
    
}

extension FilterView: TabItemDelegate{
    
    func tapAction(of number: Int) {
        selectedIndex = number
        let tappedItem = items[number]
        selectedItem?.markUnselected(with: color, from: number < selectedItem!.number ? .right : .left)
        tappedItem.markSelected(with: selectedColor, from: number < selectedItem!.number ? .right : .left)
        selectedItem = tappedItem
        delegate?.filterView(selected: number)
    }
    
}

protocol FilterViewDelegate{
    func filterView(selected index: Int)
}
