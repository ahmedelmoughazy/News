//
//  TableCell.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/12/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var descriptionText: UITextView!
}
