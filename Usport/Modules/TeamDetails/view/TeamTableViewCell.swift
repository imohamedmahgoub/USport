//
//  TeamTableViewCell.swift
//  Usport
//
//  Created by Mohamed Mahgoub on 19/08/2024.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUi()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupCellUi() {
        playerImage.layer.cornerRadius = 16
        teamView.layer.cornerRadius = 20
        teamView.layer.borderColor = UIColor.systemBlue.cgColor
        teamView.layer.borderWidth = 0.3
    }

}


