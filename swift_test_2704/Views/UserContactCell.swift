//
//  UserContactCell.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import UIKit

class UserContactCell: UITableViewCell {
    
    static var identifier: String = "UserContactCell"
    
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageLabel: UILabel!
    
    @IBOutlet private weak var userLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupViews()
    }
    
    private func setupViews() {
        
        selectionStyle = .none
        
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        imageContainerView.backgroundColor = UIColor(named: "PrimaryBlue")
        imageLabel.font = UIFont.systemFont(ofSize: 16)
        imageLabel.textColor = UIColor.white
        
        userLabel.textColor = UIColor(named: "DarkGray")
        userLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageLabel.text = nil
        self.userLabel.text = nil
    }
    
    public func updateUI(with user: User) {
        
        let initialName: String = (user.firstName.first?.description ?? "") + (user.lastName.first?.description ?? "")
        var fullname: String = "\(user.firstName) \(user.lastName)"
        
        if let loggedUser = StorageManager.shared.fetchLoggedUser() {
            if "\(loggedUser.firstName) \(loggedUser.lastName)" == fullname {
                fullname += " (you)"
            }
        }
        
        imageLabel.text = initialName
        userLabel.text = fullname
    }
}
