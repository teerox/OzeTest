//
//  UITableView + Extension.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import UIKit

public extension UITableView {

    func registerTableCell<T: UITableViewCell>(_: T.Type) {
        let reuseId = "\(T.self)"
        self.register(T.self, forCellReuseIdentifier: reuseId)
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath? = nil) -> T {
        
        
        if let indexPath = indexPath {
            guard
                let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                               for: indexPath) as? T
                else { fatalError("Could not dequeue cell with type \(T.self)") }
            return cell
            
        }
        
        /// In case we're dealing with section Headers. They don't need a special headerClass cell...
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
            else { fatalError("Could not dequeue header cell with type \(T.self)") }
        return cell
    }
    
}
