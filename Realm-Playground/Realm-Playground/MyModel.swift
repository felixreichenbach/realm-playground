//
//  MyModel.swift
//  StitchAPI
//
//  Created by Felix Reichenbach on 02.05.20.
//  Copyright © 2020 Felix Reichenbach. All rights reserved.
//

import Foundation
import MongoSwift


struct MyModel: Codable {
    
    var _id: ObjectId
    var greeting: String? = "Default"
    var random: Int?
    

}
