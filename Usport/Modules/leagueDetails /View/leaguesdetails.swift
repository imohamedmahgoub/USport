//
//  ViewController.swift
//  la liga
//
//  Created by Ahmed El Gndy on 16/08/2024.
//

import UIKit

class leaguesDetails: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    var key:Int?
    //for events
    var events = [Event]()
    var homeTeamsSet = Set<HomeTeamDetails>()
    
      var homeTeamsArray: [HomeTeamDetails] {
          return Array(homeTeamsSet)
      }
    @IBOutlet var collectiontview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectiontview.dataSource = self
        collectiontview.delegate = self
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
                    switch sectionIndex {
                    case 0, 2, 4:
                        return self.upcomingTitle()
                    case 1:
                        return self.upcomingMatches()
                    case 3 :
                        return self.scoresMatches()
                     case 5 :
                     return self.TeamsInTheleague()
                    default:
                        return self.upcomingMatches()
                    }
                }
        collectiontview.setCollectionViewLayout(layout, animated: true)
        loaddata()
        print(events)
        test()
     }

    func loaddata() {
        let network = NetworkManager()
        network.getDataFromAPI(metValue: .fixtures, teamId: 0, fromDate: "2023-08-17", toDate: "2024-08-17", leagueId: "\(key ?? 0)", type: EventsResponse.self, sport: "football") { result in
            if result?.success == 1 {
                self.events = result!.result
                
                let homeTeamsArray = self.events.map { event in
                           return HomeTeamDetails(
                               homeTeamKey: event.homeTeamKey,
                               homeTeamName: event.eventHomeTeam ?? "",
                               homeTeamLogo: event.homeTeamLogo ?? " "
                           )
                       }
                self.homeTeamsSet = Set(homeTeamsArray)
                print(self.events.count)
                print(self.homeTeamsArray.count)
                DispatchQueue.main.async {
                              self.collectiontview.reloadData()
                
                    }

            }
        }
    }
    
    func scoresMatches()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
          
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
   
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
          
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
          
          let section = NSCollectionLayoutSection(group: group)
          
          return section
    }
    func upcomingTitle()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
    }
    
    func upcomingMatches()-> NSCollectionLayoutSection {
        
      
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
 
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(225))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    func TeamsInTheleague()->NSCollectionLayoutSection {

            // Set the item size to take 25% of the width and 100% of the height of the group
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
            
            // Create the item with the specified size
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Set the group size to take 100% of the section's width and have a fixed height of 50 points
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
            
            // Create the group and add the item to it
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Set spacing between items within the group
            group.interItemSpacing = .fixed(20) // 50 points spacing between items
            
            // Create the section with the group
            let section = NSCollectionLayoutSection(group: group)
            
            // Enable continuous horizontal scrolling
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        
    }
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 6
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{

        case 0, 2, 4:
            return 1
            
        case 1:
            return 10
        // number of teams in the leagues
        case 5:
            print("hi \(homeTeamsArray.count)")
            return homeTeamsArray.count
       //number of scores
        case 3 :
            print("hi evenrt \(events.count)")
            return events.count
        
        default:
            return 1
        }
    }
    
    func test()-> Void {
        print("start")
        for team in homeTeamsArray {
            print("Team Name: \(team.homeTeamName), Logo: \(String(describing: team.homeTeamLogo))")
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
        case 1 :
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
            cell?.backgroundColor = .systemGray
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)
        case 3 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! scoreCell
            cell.homeTeamLogo.kf.setImage(with: URL(string: events[indexPath.row].homeTeamLogo ?? "football"))
              cell.awayTeamLogo.image = UIImage(named: "football.jpg")

             return cell
        case 4:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath)
            
        case 5:
            print("case 4 ")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! teamCollectionViewCell
            if !(indexPath.row > homeTeamsArray.count){
                cell.teamImg.kf.setImage(with :URL(string: homeTeamsArray[indexPath.row].homeTeamLogo))
                
                cell.backgroundColor = .systemGray
                
                
                return cell
            }
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        }
      
        return cell!
    }
    
}

