//
//  TeamsViewController.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 14/08/2024.
//

import UIKit

class TeamsViewController: UIViewController {
    var teamsDetailsViewModel : TeamDetailsViewModelProtocol?

    
    @IBOutlet weak var TeamDetailsCollectionView: UICollectionView!
    @IBOutlet weak var studiumImage: UIImageView!
    @IBOutlet weak var teamIconImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TeamDetailsCollectionView.dataSource = self
        TeamDetailsCollectionView.delegate = self
        teamsDetailsViewModel = TeamDetailsViewModel()
       let teamImage = URL(string: (teamsDetailsViewModel?.teams.first?.teamLogo) ?? "")
        teamIconImage.kf.setImage(with: teamImage , placeholder: UIImage(systemName: "camera"))
        studiumImage.image = UIImage(named: "cricket")
        teamNameLabel.text = "Mohamed Mahgoub Team"
    }
   
}
extension TeamsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let team = teamsDetailsViewModel?.teams[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.firstLabel.text = "Leagues1:"
            cell.secondLabel.text = "Mohamed1"
        case 1:
            cell.firstLabel.text = "Leagues2:"
            cell.secondLabel.text = "Mohamed2"
        case 2:
            cell.firstLabel.text = "Leagues3:"
            cell.secondLabel.text = "Mohamed3"
        case 3:
            cell.firstLabel.text = "Leagues4:"
            cell.secondLabel.text = "Mohamed4"
        case 4:
            cell.firstLabel.text = "Leagues5:"
            cell.secondLabel.text = "Mohamed5"
        case 5:
            cell.firstLabel.text = "Leagues6:"
            cell.secondLabel.text = "Mohamed6"
        default:
            cell.firstLabel.text = "Leagues7:"
            cell.secondLabel.text = "Mohamed7"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 135)
    }
    
}
