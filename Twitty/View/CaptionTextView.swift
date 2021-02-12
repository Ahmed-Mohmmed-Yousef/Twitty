//
//  CaptionTextView.swift
//  Twitty
//
//  Created by Ahmed on 12/02/2021.
//

import UIKit

class CaptionTextView: UITextView {

    let placeholderLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .darkGray
        lbl.text = "What`s happen?"
        return lbl
    }()
    
    //MARK:- lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        font = UIFont.systemFont(ofSize: 16)
//        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handelTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handelTextInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }

}
