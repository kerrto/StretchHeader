//
//  MyCustomCellTableViewCell.swift
//  StretchMyHeader
//
//  Created by Kerry Toonen on 2016-02-16.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

class MyCustomCellTableViewCell: UITableViewCell {
    
    // MARK :Properties
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var headline: UILabel!
    
    var newsItem: NewsItem? {
        
        didSet {
            if let item = newsItem {
                category.text = item.category.toString()
                category.textColor = item.category.toColor()
                headline.text = item.summary
            }
            
            else {
                category.text = nil
                headline.text = nil
            }
    }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
