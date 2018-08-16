//
//  FirstCell.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/16/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit

class FirstCell: UITableViewCell {
    
    
    @IBOutlet weak var UI_avatar: UIImageView!
    
    @IBOutlet weak var UI_type: UILabel!
    @IBOutlet weak var UI_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
