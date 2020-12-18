//
//  NotificationsController.swift
//  Twitty
//
//  Created by Ahmed on 18/12/2020.
//

import UIKit

class NotificationsController: UIViewController {

    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    //MARK: - Helperd
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Notifications"
    }
}
