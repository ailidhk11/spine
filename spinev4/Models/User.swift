//
//  User.swift
//  spinev4
//
//  Created by Ailidh Kinney on 27/07/2022.
//

import Foundation
import SwiftUI

struct User: Identifiable {
    
    var id: String
    var name: String
    var dob: Date
    var email: String
    var password: String
    var confirmPassword: String
    
    
}
