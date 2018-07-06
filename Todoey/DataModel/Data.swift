//
//  Data.swift
//  Todoey
//
//  Created by mohamed elatabany on 6/24/18.
//  Copyright © 2018 mohamed elatabany. All rights reserved.


import UIKit
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
