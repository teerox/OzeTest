//
//  ItemDataSource.swift
//  OzeAssesment
//
//  Created by Mac on 02/11/2022.
//

import Foundation

class ItemDataSource: NSObject {
    
    var sections = [(header: Character, names: [TableViewValue])]()
    
    init<T>(data: T) {
        if let listData = data as? [TableViewValue] {
            sections = Dictionary(grouping: listData) { (value) -> Character in
                return value.login.uppercased().first!
            }
            .map { (key: Character, value: [TableViewValue]) -> (header: Character, names: [TableViewValue]) in
                (header: key, names: value)
            }
            .sorted { (left, right) -> Bool in
                left.header < right.header
            }
        }
    }
}
