//
//  CollegeListVC.swift
//  FirebaseCPB
//
//  Created by Michael  Murphy on 10/29/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class CollegeListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var collegeListTableView: UITableView!
    
    var colleges = [College]()
    var db: Firestore!
    var collegeListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        collegeListTableView.backgroundColor = #colorLiteral(red: 0.3743641376, green: 0.5817425251, blue: 1, alpha: 1)
        collegeListTableView.delegate = self
        collegeListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        collegeListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editCollege", sender: nil)
    }
    
    func getData() {
        
        db.collection("colleges").getDocuments { (querySnapshot, error) in
            
            if let snapshot = querySnapshot {
                for document in snapshot.documents {
                    let newData = document.data()
                    let newCollege = College(name: "", amountOfStudents: 0, url: "")
                    
                    for college in newData {
                        switch college.key {
                        case "name":
                            newCollege.name = college.value as! String
                        case "amountOfStudents":
                            newCollege.amountOfStudents = college.value as! Int
                        case "website":
                            newCollege.url = college.value as! String
                            
                        default:
                           print("didnt work")
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }
            }
            
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collegeCell = tableView.dequeueReusableCell(withIdentifier: "CollegeCell", for: indexPath) as! CollegeCell
        let college = colleges[indexPath.row]
        collegeCell.updateCell(college: college)
        return collegeCell
    }
    
    
    @IBAction func unwindToCollegelist(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        if sender.tag == 0 {
            collegeListTableView.isEditing = true
            sender.tag = 1
        } else {
            collegeListTableView.isEditing = false
            sender.tag = 0
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let college = colleges[sourceIndexPath.row]
        colleges.remove(at: sourceIndexPath.row)
        colleges.insert(college, at: destinationIndexPath.row)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedCollege = colleges[indexPath.row]
            colleges.remove(at: indexPath.row)
            
            collegeListTableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCollege" {
            let college = colleges[(collegeListTableView.indexPathForSelectedRow?.row)!]
            let editCollegeVC = segue.destination as! AddCollegeVC
            editCollegeVC.college = college
            
        }
    }
    
}
