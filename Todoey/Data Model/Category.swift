//
//  Category.swift
//  Todoey
//
//  Created by Nikita Petrenko on 1/29/18.
//  Copyright © 2018 Nikita Petrenko. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>() // defines the to-many relationship
}
