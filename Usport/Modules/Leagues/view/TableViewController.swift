//
//  TableViewController.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 15/08/2024.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    
    var viewModel: LeaguesViewModelProtocol?
    var index: Int?
    
    var isFav: Bool = true
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "no.jpg") // Adjust the image name as needed
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.RegisterNib(cell: LeaguesTableViewCell.self)
        viewModel = LeaguesViewModel(path: index ?? 0)
        viewModel?.isFav = self.isFav
        viewModel?.getData()
        viewModel?.bindDataToViewController = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateUI() // Ensure UI is updated after data is loaded
            }
        }
        
        setupBackgroundImageView()
        if viewModel?.isFav == true{
            self.navigationController?.navigationItem.title = "Favourite Leagues"
        }else {
            self.navigationController?.navigationItem.title = "Leagues"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the table view every time the view appears
        viewModel?.getData() // Ensure data is up-to-date
        tableView.reloadData()
        
    }
    
    private func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateUI() {
        let shouldShowBackgroundImage = (viewModel?.leagues.count ?? 0) == 0
        backgroundImageView.isHidden = !shouldShowBackgroundImage
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (viewModel?.leagues.count) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        
        let league = viewModel?.leagues[indexPath.row]
        let image = URL(string: (league?.leagueLogo) ?? "")
        cell.leagueImage.kf.setImage(with: image, placeholder: UIImage(named: "football"))
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.width / 2
        cell.leagueName.text = league?.leagueName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LVC") as! LeaguesDetailsViewController
        let selectedLeague = viewModel?.leagues[indexPath.row]
        
        let leaguesDetailsViewModel = LeaguesDetailsViewModel()
        leaguesDetailsViewModel.selectedLeague = selectedLeague
        
        vc.viewModel = leaguesDetailsViewModel
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}



extension UITableView {
    func RegisterNib<cell: UITableViewCell>(cell: cell.Type) {
        let nibName = String(describing: cell)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeue<cell: UITableViewCell>() -> cell {
        _ = String(describing: cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell") as? cell else {
            fatalError("error in cell")
        }
        return cell
    }
}

