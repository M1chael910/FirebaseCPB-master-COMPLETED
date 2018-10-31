//
//  AddCollegeVC.swift
//  FirebaseCPB
//
//  Created by Michael  Murphy on 10/29/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit
import SafariServices
import Firebase


class AddCollegeVC: UIViewController {
    
    @IBOutlet weak var collegeNameTextField: UITextField!
    @IBOutlet weak var numberOfStudentsTextField: UITextField!
    @IBOutlet weak var webPageTextField: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    
    var college: College!
    var docRef: DocumentReference!
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        if let college = college {
            setInitialProperties(from: college)
        }
    }
    func saveProperties(for college: College) {
        if let name = collegeNameTextField.text, let url = webPageTextField.text, let amountOfStudents = numberOfStudentsTextField.text {
            college.name = name
            college.url = url
            if let numberOfStudents = Int(amountOfStudents) {
                college.amountOfStudents = numberOfStudents
            } else {
                college.amountOfStudents = 0
            }
        } else {
            college.name = "No Name Given"
            college.url = ""
        }
        
    }
    
    @IBAction func collegeNameChanged(_ sender: UITextField) {
        updateNavItem(with: sender.text!)
    }
    
    func setInitialProperties(from college: College) {
        collegeNameTextField.text = college.name
        numberOfStudentsTextField.text = String(college.amountOfStudents)
        webPageTextField.text = college.url
    }
    
    
    func updateNavItem(with text: String) {
        self.navigationItem.title = text
    }
    
    
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        print("pressed")
        let newCollege = College(name: "", amountOfStudents: 0, url: "")
        saveProperties(for: newCollege)
        docRef = db.document("colleges/\(newCollege.name)")
        let collegeToSave: [String : Any] = ["name": newCollege.name, "amountOfStudents" : newCollege.amountOfStudents, "website" : newCollege.url]
        docRef.setData(collegeToSave) { (error) in
            
        }
        
        
    }
    
    @IBAction func collegeNameEdit(_ sender: UITextField) {
        updateSaveBtnState()
    }
    
    func updateSaveBtnState() {
        if collegeNameTextField.text?.isEmpty == true {
            saveBtn.isEnabled = false
        } else {
            saveBtn.isEnabled = true
        }
    }
    
    
    
    @IBAction func viewWebpageBtnPressed(_ sender: UIButton) {
        let svc = SFSafariViewController(url: URL(string: "http://\(webPageTextField.text!)")!)
        present(svc, animated: true, completion: nil)
    }
    
    
}

