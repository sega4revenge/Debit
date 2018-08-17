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
    @IBOutlet weak var view_forrent: UIView!
    @IBOutlet weak var view_rent: UIView!
    @IBOutlet weak var total_amount_forrent: UILabel!
    @IBOutlet weak var total_amount_rent: UILabel!
    @IBOutlet weak var total_imcome_forrent: UILabel!
    @IBOutlet weak var total_income_rent: UILabel!
    
    @IBOutlet weak var segmented_control: UISegmentedControl!
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
