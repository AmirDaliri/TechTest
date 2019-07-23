//
//  QuestionDetailView.swift
//  TechTest
//
//  Created by Amir Daliri on 24.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import SnapKit
import PieCrust

class QuestionDetailView: PCView {
    
    // MARK: - Property Methode
    
    lazy var questionImageView: PCImageView = {
        return PCImageView(backgroundColor: .clear)
    }()
    
    lazy var titleLabel: PCLabel = {
        return PCLabel(text: .empty, textAlignment: .left, numberOfLines: 0, textColor: .black, font: UIFont.boldSystemFont(ofSize: 24), backgroundColor: .clear, tintColor: .clear)
    }()
    
    lazy var dateLabel: PCLabel = {
        return PCLabel(text: .empty, textAlignment: .left, numberOfLines: 0, textColor: UIColor.darkText, font: UIFont.systemFont(ofSize: 14), backgroundColor: .clear, tintColor: .clear)
    }()
    
    lazy var collectionView: PCCollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 210, height: 70)
        layout.scrollDirection = .horizontal
        let collection = PCCollectionView(layout: layout, cells: [ChoicesCollectionViewCell.self], showsHorizontalScrollIndicator: true, backgroundColor: .clear)
        collection.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return collection
    }()
    
    // MARK: - Setup VIew Methode
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(questionImageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(collectionView)
    }
    
    // MARK: - Constraints Methode
    
    override func setupLayout() {
        super.setupLayout()
        
        questionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(preferredPadding*3)
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
            make.height.equalToSuperview().multipliedBy(1*0.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(questionImageView.snp.bottom).offset(preferredPadding)
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(preferredPadding)
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(preferredPadding)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(70)
        }
    }
}

