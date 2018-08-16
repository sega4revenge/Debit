//
//  DebitViewCell.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/15/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit

class DebitViewCell: UITableViewCell {

   
    @IBOutlet weak var UI_ImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
  
    @IBOutlet weak var ammount: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var expired: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
