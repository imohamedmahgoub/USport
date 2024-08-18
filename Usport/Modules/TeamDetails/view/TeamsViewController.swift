//
//  TeamsViewController.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 14/08/2024.
//

import UIKit

class TeamsViewController: UIViewController {
    var teamsDetailsViewModel : TeamDetailsViewModelProtocol?
    var index:Int?
    
    @IBOutlet weak var TeamDetailsCollectionView: UICollectionView!
    @IBOutlet weak var studiumImage: UIImageView!
    @IBOutlet weak var teamIconImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TeamDetailsCollectionView.dataSource = self
        TeamDetailsCollectionView.delegate = self
        teamsDetailsViewModel = TeamDetailsViewModel(path: index ?? 0)
        
        teamsDetailsViewModel?.getData({ team in
            
            DispatchQueue.main.async {
                let teamImage = URL(string: (self.teamsDetailsViewModel?.team!.first!.teamLogo) ?? "")
                self.teamIconImage.kf.setImage(with:teamImage , placeholder: UIImage(systemName: "camera"))
                self.teamIconImage.layer.cornerRadius = self.teamIconImage.frame.width / 2

                self.studiumImage.image = UIImage(named: "AppIcon")
                
                self.teamNameLabel.text = self.teamsDetailsViewModel?.team?.first?.teamName
                self.TeamDetailsCollectionView.reloadData()
            }
        })
    }
   
}
extension TeamsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //let team = teamsDetailsViewModel?.team?.first.
        switch indexPath.row {
        case 0:
            cell.firstLabel.text = "Coach :"
            cell.secondLabel.text = teamsDetailsViewModel?.team?.first?.coaches?.first?.coachName
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
        return CGSize(width: view.frame.width, height: 135)
    }
    
}
