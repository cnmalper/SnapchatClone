//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit
import FirebaseAuth

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentUserMail = Auth.auth().currentUser?.email
        self.userEmailLabel.text = "Signed in as \(currentUserMail ?? "Unknown user")"
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
