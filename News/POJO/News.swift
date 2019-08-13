//
//  News.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/10/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation
import RealmSwift

class News :Object{
    
    @objc dynamic var author:String = "No Author"
    @objc dynamic var title:String = "No Title"
    @objc dynamic var newsDescription: String = "No Description"
    @objc dynamic var urlToImage: String = ""
}

