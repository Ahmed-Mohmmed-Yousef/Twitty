//
//  MainTabController.swift
//  Twitty
//
//  Created by Ahmed on 18/12/2020.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    //MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(#imageLiteral(resourceName: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        authenticationUserAndConfiguration()
        
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserServices.shared.fetchUser {[weak self] user in
            self?.user = user
        }
    }
    
    func authenticationUserAndConfiguration() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configurationViewContoller()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Selectors
    @objc func actionButtonTapped() {
        guard let user = self.user else { return }
        let navVC = UINavigationController(rootViewController: UploadTweetController(user: user))
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    //MARK: - Helperd
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    func configurationViewContoller() {
        let feed = FeedController()
        let navFeed = templateNavigationContraler(image: #imageLiteral(resourceName: "home_unselected"), rootViewController: feed)
        let explor = ExploreController()
        let navExplor = templateNavigationContraler(image: #imageLiteral(resourceName: "search_unselected"), rootViewController: explor)
        let notification = NotificationsController()
        let navNotification = templateNavigationContraler(image: #imageLiteral(resourceName: "like_unselected"), rootViewController: notification)
        let conversation = ConversationController()
        let navConversation = templateNavigationContraler(image: UIImage(named: "ic_mail_outline_white_2x-1")!, rootViewController: conversation)
        
        viewControllers = [navFeed, navExplor, navNotification, navConversation]
    }
    
    func templateNavigationContraler(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        return nav
    }

}
