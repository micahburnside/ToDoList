//
//  DataModel.swift
//  To Do List
//
//  Created by Micah Burnside on 12/27/20.
//

import Foundation

class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
