//
//  Todo.swift
//  Todo
//
//  Created by 五十嵐諒 on 2022/03/01.
//

import Foundation
import RealmSwift

class Todo: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
