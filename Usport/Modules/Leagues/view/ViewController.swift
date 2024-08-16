//
//  ViewController.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import UIKit

class ViewController: UIViewController {

    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.RegisterNib(cell: TableViewCell.self)
        view.addSubview(tableView)

    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10  //default value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.leagueImage.image = UIImage(systemName: "person.fill")
        cell.leagueName.text = "Barcelona"
        
        return cell
        
    }
    
    
}

extension  UITableView {
    func RegisterNib<cell : UITableViewCell>(cell : cell.Type) {
        
        
        let nibName = String(describing : cell.self)
        
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeue<cell : UITableViewCell>() -> cell {
        
        _ = String(describing: cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: "cell") as? cell else {
            fatalError("error in cell")
        }
        
        return cell
    }
    
    
}

