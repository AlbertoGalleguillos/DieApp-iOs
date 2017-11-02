//
//  MessageTableViewController.swift
//  Die App
//
//  Created by Alberto Galleguillos on 3/22/17.
//  Copyright © 2017 Marcer Spa. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabaseUI
import AlamofireImage

class MessageTableViewController: UITableViewController {
    
    //MARK: Properties
    var messageRef: FIRDatabaseReference!
    var dataSource: FUITableViewDataSource!
    let cellIdentifier = "MessageTableViewCell"
    
    // String to pass to Detail Scene
    var authorToPass: String!
    var titleToPass: String!
    var bodyToPass: String!
    var urlToPass: String!
    let segueIdentifier = "listToDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let uid = FIRAuth.auth()?.currentUser?.uid
        messageRef = FIRDatabase.database().reference().child("user_message/" + uid!)
        let query = messageRef.queryOrdered(byChild: "date")
        
        self.dataSource = self.tableView.bind(to: query) { tableView, indexPath, snapshot in
            
            // Dequeue cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as?
                MessageTableViewCell else {
                    fatalError("The dequeued cell is not an instance of MessageTableViewCell.")
            }
            
            /* Populate Cell */
            let value = snapshot.value as! NSDictionary
            let urlString: String! = value["photoUrl"] as? String ?? ""
            cell.authorLabel.text = value["author"] as? String ?? ""
            cell.titleLabel.text = value["title"] as? String ?? ""
            cell.bodyLabel.text = value["body"] as? String ?? ""
            cell.urlLabel.text = urlString
            
            // Populate Image
            let downloadURL = URL(string: urlString)!
            cell.photoImageView.af_setImage(withURL: downloadURL)
            
            return cell
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 //messageRef.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! MessageTableViewCell
        
        authorToPass = currentCell.authorLabel.text
        titleToPass = currentCell.titleLabel.text
        bodyToPass = currentCell.bodyLabel.text
        urlToPass = currentCell.urlLabel.text
        
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == segueIdentifier) {
            
            let viewController = segue.destination as! DetailViewController
            
            viewController.authorPassed = authorToPass
            viewController.titlePassed = titleToPass
            viewController.bodyPassed = bodyToPass
            viewController.urlPassed = urlToPass
        }
    }
    
    // MARK: Custon Item Bar Action
    
    @IBAction func signOutButton(_ sender: UIBarButtonItem) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
