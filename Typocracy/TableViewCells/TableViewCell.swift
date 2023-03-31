//
//  TableViewCell.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-31.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var dateCellLabel: UILabel!
    @IBOutlet weak var scoreCellLabel: UILabel!
    @IBOutlet weak var nameCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
