//
//  HomeViewController.swift
//  Sports
//
//  Created by Ahmed El Gndy on 14/08/2024.
//

import UIKit
import Network

class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    var noInternetImageView: UIImageView!
    var monitor: NWPathMonitor?
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var collectionVeiw: UICollectionView!
    
      override func viewDidLoad() {
          super.viewDidLoad()
          collectionVeiw.delegate = self
          collectionVeiw.dataSource = self
          
          setupNoInternetImageView()
          setupNetworkMonitor()
          setupRefreshControl()
      }

      func setupRefreshControl() {
          refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
          collectionVeiw.refreshControl = refreshControl
      }

      @objc func refreshData() {
          monitorNetworkConnection()
      }

      func monitorNetworkConnection() {
          monitor?.pathUpdateHandler = { [weak self] path in
              DispatchQueue.main.async {
                  if path.status == .satisfied {
                      // Network is available, hide the noInternetImageView and show the collectionView
                      self?.noInternetImageView.isHidden = true
                      self?.collectionVeiw.isHidden = false
                      self?.fetchData()
                  } else {
                      // Network is unavailable, show the noInternetImageView and hide the collectionView
                      self?.noInternetImageView.isHidden = false
                      self?.collectionVeiw.isHidden = true
                      self?.refreshControl.endRefreshing()  // End the refresh control even if there's no internet
                      self?.showNoNetworkAlert()
                  }
              }
          }
      }

      func fetchData() {
          // Simulate network request or perform actual data fetch
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
              // Reload your collection view data here
              self?.collectionVeiw.reloadData()
              self?.refreshControl.endRefreshing()  // End the refresh animation
          }
      }

      func setupNoInternetImageView() {
          noInternetImageView = UIImageView(image: UIImage(named: "football.jpg")) // Replace with your no internet image
          noInternetImageView.contentMode = .scaleAspectFit
          noInternetImageView.frame = view.bounds
          noInternetImageView.isHidden = true
          view.addSubview(noInternetImageView)
      }

      func setupNetworkMonitor() {
          monitor = NWPathMonitor()
          let queue = DispatchQueue(label: "NetworkMonitor")
          monitor?.start(queue: queue)
          monitorNetworkConnection()  // Initial check on view load
      }

      func showNoNetworkAlert() {
          let alert = UIAlertController(title: "No Internet", message: "Please check your internet connection.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
          present(alert, animated: true)
      }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        switch(indexPath.row){
        case 0:
            cell.sportImg.image = UIImage(named: "football.jpg")
            cell.sportLbl.text = "Football"
        case 1 :
            cell.sportImg.image = UIImage(named: "basketbell.jpg")
            cell.sportLbl.text = "basketball"
        case 2 :
            cell.sportImg.image = UIImage(named: "cricket.jpg")
            cell.sportLbl.text = "cricket"
        case 3 :
            cell.sportImg.image = UIImage(named: "tennis.jpg")
            cell.sportLbl.text = "tennis"
        default:
            cell.sportImg.image = UIImage(named: "basketbell.jpg")
            cell.sportLbl.text = "basketball"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.45, height: self.view.frame.width*0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "leagus", sender: indexPath.row)
    }

   //go to leages view contoller
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leagus" {
            if let vc = segue.destination as? ViewController {
                if let index = sender as? Int {
                    vc.index = index
                }
            }
        }
    }
     */
   /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectSport(at: indexPath.row)
    }*/

}
