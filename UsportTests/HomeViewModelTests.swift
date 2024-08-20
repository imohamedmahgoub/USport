//
//  HomeViewModelTests.swift
//  UsportTests
//
//  Created by Ahmed El Gndy on 20/08/2024.
//

import Foundation
import XCTest
@testable import Usport

final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFirstSport() throws {
        XCTAssertEqual(viewModel.numberOfItems(), 4)
        XCTAssertEqual(viewModel.sportName(at: 0), "Football")
        XCTAssertEqual(viewModel.sportImageName(at: 0), "football.jpg")
        
    }

}
