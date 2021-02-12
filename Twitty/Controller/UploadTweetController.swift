//
//  UploadTweetController.swift
//  Twitty
//
//  Created by Ahmed on 12/02/2021.
//

import UIKit
import SDWebImage
class UploadTweetController: UIViewController {
    
    //MARK:- Properties
    private var user: User
    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setTitle("Tweet", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        btn.layer.cornerRadius = 32 / 3
        btn.addTarget(self, action: #selector(handelUploadTweet), for: .touchUpInside)
        return btn
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    let captionTextView = CaptionTextView()
    
    
    //MARK:- Lifecycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuerUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profileImageView.isHighlighted = true
    }
    
    //MARK:- Selectors
    @objc func handelCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handelUploadTweet() {
        guard let caption = captionTextView.text, !caption.isEmpty else { return }
        actionButton.isEnabled = false
        captionTextView.endEditing(true)
        TweetServices.shared.uploadTweet(caption: caption) { [weak self](error, ref ) in
            if let error = error {
                print("DEBUG: filed to upload tweet: ", error.localizedDescription)
                return
            }
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK:- API
    
    //MARK:- Helpers
    func configuerUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .top
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handelCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
}
