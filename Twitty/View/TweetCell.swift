//
//  TweetCell.swift
//  Twitty
//
//  Created by Ahmed on 23/02/2021.
//

import UIKit
import SDWebImage

class TweetCell: UICollectionViewCell {
    
    //MARK:- Properties
    var tweet: Tweet? {
        didSet { configureUI() }
    }
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "some test caption"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let infoLabel = UILabel()
    
    private lazy var commentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "comment"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handelCommentTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var retweetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "retweet"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handelRetweetTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "like"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handelLikeTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "share"), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handelShareTapped), for: .touchUpInside)
        return btn
    }()
    //MARK:- LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "Eddi Brock @vone"
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        let underLineView = UIView()
        addSubview(underLineView)
        underLineView.backgroundColor = .systemGroupedBackground
        underLineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Selector
    
    @objc func handelCommentTapped() {
        
    }
    
    @objc func handelRetweetTapped() {
        
    }
    
    @objc func handelLikeTapped() {
        
    }
    
    @objc func handelShareTapped() {
        
    }
    
    //MARK:- Helper
    
    func configureUI() {
        guard let tweet = tweet else { return }
        let tweetViewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: tweetViewModel.profileImageUrl)
        infoLabel.attributedText = tweetViewModel.userInfoText
    }
}
