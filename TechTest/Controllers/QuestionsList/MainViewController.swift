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
    
    var questions = [QuestionsList]()
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        NotificationCenter.default.addObserver(self,selector: #selector(statusManager), name: .flagsChanged, object: nil)
        setupView()
        getQuestios(query: nil)
    }

    override func setNavigationItem() {
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(didTapSearchBarBttnItem(_:)))
        self.title = "Main"
    }
    
    // MARK: - Setup View Methode
    func setupView() {
        pcView.tableView.dataSource = self
        pcView.tableView.delegate = self
        pcView.tableView.tableHeaderView = pcView.searchController.searchBar
        pcView.searchController.searchResultsUpdater = self
        pcView.searchController.dimsBackgroundDuringPresentation = false
        pcView.searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    // MARK: - API Methode
    
    func getQuestios(query: String?) {
        self.questions.removeAll()
        pcView.tableView.reloadData()
        ApiRequest.shared.getQuestions(limite: 10, offset: 10, filter: query) { (list, error) in
            guard let data = list else { return }
            self.questions = data
            self.pcView.tableView.reloadData()
        }
    }
    
    
    // MARK: - Action Methode
    
    @objc func didTapSearchBarBttnItem(_ sender: PCButton) {
        let indecPath = IndexPath(row: sender.tag, section: 0)
        guard let cell = pcView.tableView.cellForRow(at: indecPath) as? QuestionTableViewCell else { return }
        Helpers.shareQuestion(id: questions[sender.tag].id!, question: cell.questionLabel.text!, image: cell.questionImageView.image!, vc: self)
    }
}

//MARK: UITableViewDataSource UITableViewDelegate Methode

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
        guard !questions.isEmpty else { return cell }
        cell.config(data: questions[indexPath.row] )
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(didTapSearchBarBttnItem(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
    }
    
}


extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: pcView.searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String) {
        print(searchText.lowercased())
        let query = searchText.lowercased()
        if query.count > 3 {
            self.getQuestios(query: query)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pcView.endEditing(true)
    }
}
