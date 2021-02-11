//
//  FeedController.swift
//  Twitty
//
//  Created by Ahmed on 18/12/2020.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet { configureLeftBarButton() }
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helperd
    func configureUI() {
        view.backgroundColor = .systemBackground
        let imageVIew = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        imageVIew.contentMode = .scaleAspectFit
        navigationItem.titleView = imageVIew
    }
    
    func configureLeftBarButton(){
        guard let user = user else { return }
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    

}
