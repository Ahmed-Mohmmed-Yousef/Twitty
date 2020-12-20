//
//  FeedController.swift
//  Twitty
//
//  Created by Ahmed on 18/12/2020.
//

import UIKit

class FeedController: UIViewController {
    
    //MARK: - Properties
    
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
    

}
