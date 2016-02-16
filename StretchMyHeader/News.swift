//
//  News.swift
//  StretchMyHeader
//
//  Created by Kerry Toonen on 2016-02-16.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

class News: NSObject {
    
    //Mark: Properties
    
    var category: String
    
    var headline: String
    
    
    
    //MARK: Initialization
    
    init? (category: String, headline:String) {
    
        self.category = category
        self.headline = headline
    }
    
}
