//
//  FeedController.swift
//  Twitty
//
//  Created by Ahmed on 18/12/2020.
//

import UIKit
import SDWebImage

let reuseIdentifier = "FeedCell"
class FeedController: UICollectionViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet { configureLeftBarButton() }
    }
    
    private var tweets = [Tweet]() {
        didSet { self.collectionView.reloadData() }
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    //MARK: - API
    
    func fetchTweets() {
        TweetServices.shared.fetchTweets {[weak self] tweets in
            self?.tweets = tweets
        }
    }
    
    //MARK: - Helperd
    func configureUI() {
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        let imageVIew = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        imageVIew.contentMode = .scaleAspectFit
        imageVIew.setDimensions(width: 44, height: 44)
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


extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
