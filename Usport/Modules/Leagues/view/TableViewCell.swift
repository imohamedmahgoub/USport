//
//  TableViewCell.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var btn1: UIButton!
    {
        didSet {
            btn1.setImage(UIImage(named: "img1"), for: .normal)
        }
    }
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var view: UIView!
    {
        didSet {
            view.backgroundColor = view.backgroundColor?.withAlphaComponent(0.3)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didSelectYoutube(_ sender: Any) {
        
        
    }
    
    
}
