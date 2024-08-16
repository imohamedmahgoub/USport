//
//  TableViewCell.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
