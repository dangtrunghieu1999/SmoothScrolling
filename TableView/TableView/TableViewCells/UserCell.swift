//
//  UserCell.swift
//  TableView
//
//  Created by Bee_MacPro on 22/02/2022.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var role: UILabel!
    
    static let defaultAvatar = UIImage(named: "Avatar")

    override func awakeFromNib() {
        super.awakeFromNib()
        setOpaqueBackground()
        avatar.setRoundedImage(UserCell.defaultAvatar)
    }
   
    func configure(_ viewModel: UserViewModel) {
        self.username.text = viewModel.username
        self.role.text     = viewModel.roleText
        isUserInteractionEnabled = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.setRoundedImage(UserCell.defaultAvatar)
    }
}

private extension UserCell {
    static let defaultBackgoundColor = UIColor.groupTableViewBackground
    
    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = UserCell.defaultBackgoundColor
        avatar.alpha = 1.0
        avatar.backgroundColor = UserCell.defaultBackgoundColor
    }
}
