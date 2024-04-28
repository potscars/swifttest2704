//
//  HomePageViewController.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import Foundation
import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addNewContainerView: UIView!
    
    private var searchController: UISearchController?
    
    private var vm = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupTableView()
        self.loadData()
        self.setupSearchController()
        self.setupObserver()
    }
    
    private func setupSearchController() {
        let contactResultVC = ContactListResultViewController()
        contactResultVC.delegate = self
        contactResultVC.allUsers = vm.users.value ?? []
        
        searchController = UISearchController(searchResultsController: contactResultVC)
        let searchBar = searchController?.searchBar
        searchBar?.placeholder = "Search here.."
        searchBar?.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController?.searchResultsUpdater = contactResultVC
    }
    
    private func loadData() {
        
        title = "My Contacts"
        
        vm.fetchUsers()
        
        // Just in case want to replicate api call, just add delay and call this block.
        //        vm.users.bind { [weak self] users in
        //            guard let self = self else { return }
        //            DispatchQueue.main.async {
        //                self.tableView.reloadData()
        //            }
        //        }
    }
    
    private func setupViews() {
        addNewContainerView.layer.cornerRadius = addNewContainerView.frame.width / 2
    }
    
    private func setupTableView() {
        
        tableView.register(UINib(nibName: UserContactCell.identifier, bundle: nil), forCellReuseIdentifier: UserContactCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updatedData), name: .didUpdateUserList, object: nil)
    }
    
    @objc
    private func updatedData() {
        self.vm.fetchUsers()
        self.tableView.reloadData()
    }
    
    private func navigateToUpdatePage(with user: User) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdatingDetailViewController") as? UpdatingDetailViewController else { return }
        vc.vm = UpdateDetailViewModel(type: .update, user: user)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction
    private func addNewAction(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdatingDetailViewController") as? UpdatingDetailViewController else { return }
        vc.vm = UpdateDetailViewModel(type: .add, user: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didUpdateUserList, object: nil)
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        vm.groupLetters.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        vm.groupLetters[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = vm.groupLetters[section]
        return vm.usersGroup[letter]?.count ?? 0
//        vm.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserContactCell.identifier, for: indexPath) as? UserContactCell else {
            return UITableViewCell()
        }
        
        let letter = vm.groupLetters[indexPath.section]
        let usersGroup = vm.usersGroup[letter]
        
        if let user = usersGroup {
            cell.updateUI(with: user[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let letter = vm.groupLetters[indexPath.section]
        let usersGroup = vm.usersGroup[letter]
        if let user = usersGroup {
            self.navigateToUpdatePage(with: user[indexPath.row])
        }
    }
}

extension HomePageViewController: ContactListResultVCDelegate {
    func didSelect(value: String) {
        
    }
}
