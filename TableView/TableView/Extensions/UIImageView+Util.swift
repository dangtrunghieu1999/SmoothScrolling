//
//  UIImageView+Util.swift
//  TableView
//
//  Created by Bee_MacPro on 22/02/2022.
//

import UIKit

extension UIImageView {
    func setRoundedImage(_ image: UIImage?) {
        guard let image = image else {
            return
        }
        
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            self.image = image
            self.roundedImage(10.0)
        }
    }
}

public extension UIImageView {
    func roundedImage(_ cornerRadius: CGFloat, withBorder: Bool = true) {
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        
        if withBorder {
            layer.borderColor = UIColor.white.cgColor
        }
        clipsToBounds = true
    }
}
