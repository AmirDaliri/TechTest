//
//  MainViewController.swift
//  TechTest
//
//  Created by Amir Daliri on 19.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import PieCrust

class MainViewController: PCViewController, Layouting {
    typealias View = MainViewModel
    

    // MARK: - Lifecycle Methods
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
    }

    override func setNavigationItem() {
        self.title = "Main"
    }
}

