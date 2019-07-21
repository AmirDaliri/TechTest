//
//  MainViewModel.swift
//  TechTest
//
//  Created by Amir Daliri on 19.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import SnapKit
import PieCrust

class MainViewModel: PCView {
    
    // MARK: - Property Methode
    
    lazy var tableView: PCTableView = {
        let table = PCTableView(style: .grouped, cells: [], separatorStyle: .none, backgroundColor: backgroundColor)
        table.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        table.estimatedRowHeight = 80
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        return table
    }()
    
    lazy var searchController :UISearchController = {
      return UISearchController(searchResultsController: nil)
    }()
    
    // MARK: - Setup VIew Methode
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(tableView)
    }
    
    // MARK: - Constraints Methode
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainViewModel {
    
    
    private func animate(){
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}
