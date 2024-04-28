//
//  ContactListResultViewController.swift
//  swift_test_2704
//
//  Created by owner on 28/04/2024.
//

import UIKit

protocol ContactListResultVCDelegate: AnyObject {
    func didSelect(value: String)
}

class ContactListResultViewController: UIViewController {
    
    private var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    weak var delegate: ContactListResultVCDelegate?
    
    private var filteredData: [User] = []
    var allUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupConstraint()
    }
    
    private func setupViews() {
        
        view.backgroundColor = UIColor.white
        
        tableView.register(UINib(nibName: UserContactCell.identifier, bundle: nil), forCellReuseIdentifier: UserContactCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }
    
    private func setupConstraint() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ContactListResultViewController: UITableViewDelegate,
                                           UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserContactCell.identifier, for: indexPath) as? UserContactCell else {
            return UITableViewCell()
        }
        
        cell.updateUI(with: filteredData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
}


extension ContactListResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedText = searchController.searchBar.text else { return }
        
        filteredData = allUsers.filter({ (user) -> Bool in
            let tmp: NSString = "\(user.firstName) \(user.lastName)" as NSString
            let range = tmp.range(of: searchedText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        self.tableView.reloadData()
    }
}
