//
//  Extension+UITextField.swift
//  swift_test_2704
//
//  Created by owner on 27/04/2024.
//

import Foundation
import UIKit

enum TextFieldImageSide {
    case left
    case right
}

extension UITextField {
    func setUpImage(imageName: String, on side: TextFieldImageSide) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFit
        if let imageWithSystemName = UIImage(systemName: imageName) {
            imageView.image = imageWithSystemName
        } else {
            imageView.image = UIImage(named: imageName)
        }
        
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 33, height: 30))
        imageContainerView.addSubview(imageView)
        
        switch side {
        case .left:
            leftView = imageContainerView
            leftViewMode = .always
        case .right:
            rightView = imageContainerView
            rightViewMode = .always
        }
    }
}
