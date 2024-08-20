//
//  HomeViewController.swift
//  Sports
//
//  Created by Ahmed El Gndy on 14/08/2024.
//

import UIKit
class HomeViewController: UIViewController {
 

    @IBOutlet weak var collectionVeiw: UICollectionView!
    
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        collectionVeiw.delegate = self
        collectionVeiw.dataSource = self
        viewModel = HomeViewModel()
        viewModel.startNetworkMonitor()
        homeSetup()
    }

    
    func homeSetup() {
        self.tabBarController?.navigationItem.title = "Sports"
        let backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "background.jpg")
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundImageView.alpha = 0.25
      
        self.view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.sendSubviewToBack(backgroundImageView)
    }
}


extension HomeViewController :  UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        cell.sportImg.image = UIImage(named: viewModel.sportImageName(at: indexPath.row))
        cell.sportLbl.text = viewModel.sportName(at: indexPath.row)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.45, height: self.view.frame.width * 0.6)
    }

 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        InternetConnection.checkURL(completion: { isConnect in
            print("i am here ")
            print(isConnect)
            if isConnect {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TVC") as? TableViewController
                guard let vc = vc else { return }
                print("in the second")
                vc.index = indexPath.row
                vc.isFav = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                let message =  "No internet Connectivity"
                
                let alert = UIAlertController(title: message, message: "please check your WIFI", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                
                
                self.present(alert, animated: true, completion: nil)
            }
        })
            
           
        }
}
