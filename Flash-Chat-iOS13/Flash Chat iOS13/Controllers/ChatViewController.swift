//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    /*
     
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "Whats up?")
    ]
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self`
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        print("Test")
        loadMessages()
        print("End Test ")
        /*
        db.collection(K.FStore.collectionName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        */
    }
    
    func loadMessages()  {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener {  querySnapshot, error in
            self.messages = []
            print("Do I get zero messages?")
            print(self.messages.count)
            if let e = error {
                print("There was an error retrieving data from Firestore: \(e)")
            } else {
                if let snapshotDocuemnts = querySnapshot?.documents {

                    for doc in snapshotDocuemnts {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            //self.messages += [Message(sender: sender, body: messageBody)]
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
//                                let indexPath = IndexPath(row
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                print("Reloading")
                            }
                        }
                    }
                    
                  //  DispatchQueue.main.async {
                   //     self.tableView.reloadData()
                   //     print("Reloading last")
                   // }
                    
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email {
            //let newMessage = Message(sender: messageSender, body: messageBody)
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField  : Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("There was an issue inserting \(e)")
                } else {
                    print("Sucessfully Saved Data")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
            // Add a new document with a generated ID
/*
            var ref: DocumentReference? = nil
            ref = db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            */

        }

        
    }
    

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Signed out")
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


extension ChatViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*
        var count = 0
        db.collection(K.FStore.collectionName).getDocuments() {  (querySnapshot, err) in
            if let err = err  {
                print("Error getting documents: \(err)")
            }  else  {
                
                for document in querySnapshot!.documents {
                    count += 1
                    print("\(document.documentID) => \(document.data())");
                }
                print("Count = \(count)");
            }
        }
        print("Right before return:\(count)")
        //return 10
        */
         
         
        print("I'm in the number of rowsInSection function")
        return messages.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        // This is a message from the current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        // This is a message from someone else
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
            

        print("I'm in the cell at for row function")
        return cell
    }
}


/*
extension ChatViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
 */
