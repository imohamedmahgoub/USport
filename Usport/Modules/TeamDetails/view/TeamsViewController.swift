//
//  TeamsViewController.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 14/08/2024.
//

import UIKit
import Kingfisher

class TeamsViewController: UIViewController {
    lazy var teamsDetailsViewModel : TeamDetailsViewModelProtocol = TeamDetailsViewModel(path: index ?? 0)
    var index:Int?
    
    
    @IBOutlet weak var teamsTableView: UITableView!
    @IBOutlet weak var studiumImage: UIImageView!
    @IBOutlet weak var teamIconImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var couchName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamsTableView.dataSource = self
        teamsTableView.delegate = self
        let nib = UINib(nibName: "TeamsTableViewCell", bundle: nil)
        teamsTableView.register(nib, forCellReuseIdentifier: "TeamsTableViewCell")
        teamsDetailsViewModel.getData()
        teamsDetailsViewModel.bindDataToTVC = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let teamImage = URL(string: (self.teamsDetailsViewModel.team[0].teamLogo) ?? "")
                self.teamIconImage.kf.setImage(with:teamImage , placeholder: UIImage(systemName: "camera"))
                self.teamIconImage.layer.cornerRadius = self.teamIconImage.frame.width / 2
                self.studiumImage.image = UIImage(named: "Stadium")
                self.teamNameLabel.text = self.teamsDetailsViewModel.team.first?.teamName
                self.couchName.text = "Coach: \(self.teamsDetailsViewModel.team[0].coaches?[0].coachName ?? "")"
                self.teamsTableView.reloadData()
            }
        }
    }
}
extension TeamsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsDetailsViewModel.playerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsTableViewCell", for: indexPath) as! TeamTableViewCell
        let player = teamsDetailsViewModel.playerList[indexPath.row]
        let playerImageUrl = URL(string: player.playerImage ?? "")
        cell.playerImage.kf.setImage(with: playerImageUrl , placeholder: UIImage(systemName: "person"))
        cell.playerName.text = player.playerName
        cell.playerNumber.text = player.playerNumber
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}







