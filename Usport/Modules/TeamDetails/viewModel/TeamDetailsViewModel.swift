//
//  viewModel.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 13/08/2024.
//

import Foundation
protocol TeamDetailsViewModelProtocol: AnyObject {
    var teams : [Teams] { get set }

}

class TeamDetailsViewModel: TeamDetailsViewModelProtocol {
    var teams : [Teams] = []
    
  
}
