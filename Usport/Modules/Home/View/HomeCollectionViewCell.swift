//
//  HomeCollectionViewCell.swift
//  Sports
//
//  Created by Ahmed El Gndy on 14/08/2024.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var sportLbl: UILabel!
    @IBOutlet var sportImg: UIImageView!
    
    override func awakeFromNib() {

       self.layoutIfNeeded()
        layer.cornerRadius = self.frame.height / 8
        layer.masksToBounds = true


      }
}
