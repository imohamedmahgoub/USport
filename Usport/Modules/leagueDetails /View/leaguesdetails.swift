//
//  ViewController.swift
//  la liga
//
//  Created by Ahmed El Gndy on 16/08/2024.
//

import UIKit

class leaguesDetails: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    

    var viewModel = LeaguesDetailsViewModel()

    @IBOutlet var collectiontview: UICollectionView!
       override func viewDidLoad() {
           super.viewDidLoad()
           
           collectiontview.dataSource = self
           collectiontview.delegate = self
           
           viewModel.reloadCollectionView = { [weak self] in
               self?.collectiontview.reloadData()
           }
           
           setupCollectionViewLayout()
           viewModel.loadData()
       }
       
       private func setupCollectionViewLayout() {
           let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
               switch sectionIndex {
               case 0, 2, 4:
                   return self.upcomingTitle()
               case 1:
                   return self.upcomingMatches()
               case 3:
                   return self.scoresMatches()
               case 5:
                   return self.TeamsInTheleague()
               default:
                   return self.upcomingMatches()
               }
           }
           collectiontview.setCollectionViewLayout(layout, animated: true)
       }
       
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 6
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           switch section {
           case 0, 2, 4:
               return 1
           case 1:
               return 10
           case 5:
               return viewModel.homeTeams.count
           case 3:
               return viewModel.events.count
           default:
               return 1
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           var cell: UICollectionViewCell?
           
           switch indexPath.section {
           case 0:
               cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
           case 1:
               cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
               cell?.backgroundColor = .systemGray
           case 2:
               cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)
           case 3:
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! scoreCell
               
               let event = viewModel.events[indexPath.row]
               
               if let homeTeamLogoURL = event.homeTeamLogo, !homeTeamLogoURL.isEmpty {
                   cell.homeTeamLogo.kf.setImage(with: URL(string: homeTeamLogoURL))
               } else {
                   cell.homeTeamLogo.image = UIImage(named: "football") //
               }
               
               if let awayTeamLogoURL = event.awayTeamLogo, !awayTeamLogoURL.isEmpty {
                   cell.awayTeamLogo.kf.setImage(with: URL(string: awayTeamLogoURL))
               } else {
                   cell.awayTeamLogo.image = UIImage(named: "football") // 
               }
               
               // Set event final result, home team name, and away team name
               cell.resultLbl.text = event.eventFinalResult
               cell.homeTeamName.text = event.eventHomeTeam
               cell.awayTeamName.text = event.eventAwayTeam
               
               return cell
           case 4:
               cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath)
           case 5:
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! teamCollectionViewCell
               if indexPath.row < viewModel.homeTeams.count {
                   let team = viewModel.homeTeams[indexPath.row]
                   cell.teamImg.kf.setImage(with: URL(string: team.homeTeamLogo))
                   cell.backgroundColor = .systemGray
                   return cell
               }
           default:
               cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
           }
           
           return cell!
       }
       
       // Layout configuration methods go here
       func scoresMatches() -> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(0.3))
           let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
           return NSCollectionLayoutSection(group: group)
       }
       
       func upcomingTitle() -> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           return NSCollectionLayoutSection(group: group)
       }
       
       func upcomingMatches() -> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(225))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           let section = NSCollectionLayoutSection(group: group)
           section.orthogonalScrollingBehavior = .continuous
           return section
       }
       
       func TeamsInTheleague() -> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           group.interItemSpacing = .fixed(20)
           let section = NSCollectionLayoutSection(group: group)
           section.orthogonalScrollingBehavior = .continuous
           return section
       }
   }
