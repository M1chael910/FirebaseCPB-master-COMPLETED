//
//  College.swift
//  FirebaseCPB
//
//  Created by Michael  Murphy on 10/29/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import Foundation


import UIKit

class College {
    var name: String
    var amountOfStudents: Int
    var url: String
    
    
    init(name: String, amountOfStudents: Int, url: String) {
        self.name = name
        self.amountOfStudents = amountOfStudents
        self.url = url
    }
}
