//
//  scoreCell.swift
//  Usport
//
//  Created by Ahmed El Gndy on 18/08/2024.
//

import UIKit

class ScoreCell: UICollectionViewCell {
  
    @IBOutlet var homeTeamLogo: UIImageView!
    
    @IBOutlet var awayTeamLogo: UIImageView!
    @IBOutlet var resultLbl: UILabel!
    
    @IBOutlet var homeTeamName: UILabel!
    @IBOutlet var awayTeamName: UILabel!
    private let backgroundImageView = UIImageView()
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCellAppearance()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setupCellAppearance()
        }
        
        private func setupCellAppearance() {
            // Add and configure the background image view
            if backgroundImageView.superview == nil {
                contentView.addSubview(backgroundImageView)
                backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])
                backgroundImageView.contentMode = .scaleAspectFill
            }
            
            // Set the background image and opacity
            let backgroundImage = UIImage(named: "background.jpg") // Replace with your image name
            backgroundImageView.image = backgroundImage
            backgroundImageView.alpha = 0.050 // Set opacity to 23%
            
            // Set corner radius and border for the entire cell
            self.layer.cornerRadius = 10 // Adjust as needed
            self.layer.masksToBounds = true
            self.layer.borderWidth = 2 // Adjust as needed
            self.layer.borderColor = UIColor.lightGray.cgColor // Adjust as needed
        }
    }
