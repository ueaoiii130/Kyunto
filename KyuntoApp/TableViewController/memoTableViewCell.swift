//
//  memoTableViewCell.swift
//  KyuntoApp
//
//  Created by 坂本のぞみ on 2016/12/05.
//  Copyright © 2016年 saki takada. All rights reserved.
//

import UIKit

class memoTableViewCell: UITableViewCell {
    
    @IBOutlet var memoLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var placeLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
