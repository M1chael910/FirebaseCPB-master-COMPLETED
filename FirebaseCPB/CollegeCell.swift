//
//  CollegeCell.swift
//  FirebaseCPB
//
//  Created by Michael  Murphy on 10/29/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit

@IBDesignable

class CollegeCell: UITableViewCell {
    
    @IBOutlet weak var collegeTitleLbl: UILabel!
    
    @IBOutlet weak var collegeAmountOfStudentsLbl: UILabel!
    
    override func awakeFromNib() {
        setupCollegeCell()
    }
    
    
    
    
    override func prepareForInterfaceBuilder() {
        setupCollegeCell()
    }
    
    func setupCollegeCell() {
        backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.5019607843, blue: 0.8862745098, alpha: 1)
    }
    
    func updateCell(college: College) {
        collegeTitleLbl.text = college.name
        collegeAmountOfStudentsLbl.text = String(college.amountOfStudents)
    }
    
}
