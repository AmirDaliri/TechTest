//
//  ChoicesCollectionViewCell.swift
//  TechTest
//
//  Created by Amir Daliri on 22.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import PieCrust

class ChoicesCollectionViewCell: PCCollectionViewCell {
    
    lazy var containerView: PCView = {
        let view = PCView(backgroundColor: UIColor.lightGray)
        view.cornerRadius = 8.0
        return view
    }()
    
    lazy var nameLabel: PCLabel = {
        let label = PCLabel(text: .empty, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), backgroundColor: .clear, tintColor: .clear)
        label.textAlignment = .center
        return label
    }()
    
    lazy var votesLabel: PCLabel = {
        let label = PCLabel(text: .empty, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 12), backgroundColor: .clear, tintColor: .clear)
        label.textAlignment = .center
        return label
    }()

    
    override func setupViews() {
        backgroundColor = .clear
        containerView.addSubview(nameLabel)
        containerView.addSubview(votesLabel)
        addSubview(containerView)
    }
    
    override func setupLayout() {
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
        }
        
        votesLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
            make.bottom.equalToSuperview().inset(4)
        }
        
    }
    
}
