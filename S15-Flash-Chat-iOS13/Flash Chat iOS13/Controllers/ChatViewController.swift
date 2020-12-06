//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!  // connected to our storyboard
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()  // reference to firestore db    // will return the same reference/instance of the db initialised inside AppDelegate.swift
    
    /* The way we populate data in TableView is different from what we used to data with label where we access a label property and assign it.
       We need To use Delegate (View extensions)
     */
    
    var messages: [Message] = [
        Message(sender: "a@2.com", body: "Hey!"),
        Message(sender: "b@2.com", body: "Hello!"),
        Message(sender: "c@2.com", body: "What's up?"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self // delegate also
        title = K.appName   // Navigation bar title
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

// when our TableView loads up. It is gonna make a request for data. The method that TableView will
// call are implemented in the delegate below
extension ChatViewController: UITableViewDataSource {   // Protocol responsible for populating the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count  // number of cells/rows in our table view
    }
    
    /* index path is the current cell that the tableView is requesting some data for. So this method is going to get called for as many rows as you have in your tableView. So currently, our message.count is three. So this is going to return three which means that this method is gonna be called three times and each time it's asking for a cell for a particular row.*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPatch (like index) is a position/index of an item
        // Return UITableViewCell ->  reference our Prototype cell
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
}

extension ChatViewController: UITableViewDelegate { // Protocol that handle user interaction with the TableView
    // exp: when a user click on a Cell, the below method is trigerred
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)    // print cell index the user tapped on
    }
}
