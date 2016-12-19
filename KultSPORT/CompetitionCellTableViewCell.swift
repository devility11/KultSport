//
//  CompetitionCellTableViewCell.swift
//  KultSPORT
//
//  Created by Norbert Czirjak on 2016. 11. 13..
//  Copyright © 2016. Norbert Czirjak. All rights reserved.
//

import UIKit

class CompetitionCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var competitionNameLbl: UILabel!
    
    @IBOutlet weak var competitionFlag: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
