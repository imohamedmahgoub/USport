//
//  TableViewCell.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUi()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setupCellUi() {
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 0.3
    }
    
}
