//
//  TeamsViewController.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 14/08/2024.
//

import UIKit

class TeamsViewController: UIViewController {
    
    
    @IBOutlet weak var studiumImage: UIImageView!
    @IBOutlet weak var teamIconImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studiumImage.image = UIImage(named: "Image")
        teamIconImage.image = UIImage(named: "noImage")
        teamNameLabel.text = "Mohamed Mahgoub Team"

    }

}
