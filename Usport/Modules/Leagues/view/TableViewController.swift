//
//  TableViewController.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 15/08/2024.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    
    var viewModel : LeaguesViewModelProtocol?
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.RegisterNib(cell: TableViewCell.self)
        viewModel = LeaguesViewModel(path: index ?? 0)
        viewModel?.getData()
        viewModel?.bindDataToViewController = { [weak self] in
            guard let self else { return  }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.leagues.count) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let league = viewModel?.leagues[indexPath.row]
        let image = URL(string: (league?.leagueLogo) ?? "")
        cell.leagueImage.kf.setImage(with: image, placeholder: UIImage(named: "football"))
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.width / 2
        cell.leagueName.text = league?.leagueName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LVC") as! leaguesDetails
        let selectedLeague = viewModel?.leagues[indexPath.row]
        
        let leaguesDetailsViewModel = LeaguesDetailsViewModel()
        leaguesDetailsViewModel.key = selectedLeague?.leagueKey
        
        vc.viewModel = leaguesDetailsViewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension  UITableView {
    func RegisterNib<cell : UITableViewCell>(cell : cell.Type) {
        let nibName = String(describing : cell)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeue<cell : UITableViewCell>() -> cell {
        _ = String(describing: cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: "TableViewCell") as? cell else {
            fatalError("error in cell")
        }
        return cell
    }
}

