//
//  ViewController.swift
//  assignment.concurrency
//
//  Created by Salome Lapiashvili on 08.11.23.
//

import UIKit

final class CompetitionMainViewController: UIViewController {
    let competitionManager = CompetitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        competitionManager.determineWinner()
    }
}
