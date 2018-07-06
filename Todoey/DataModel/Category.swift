//
//  Category.swift
//  Todoey
//
//  Created by mohamed elatabany on 7/3/18.
//  Copyright © 2018 mohamed elatabany. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}
