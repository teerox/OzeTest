//
//  GenericTableViewDataSourceDelegate.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import UIKit

// MARK: - GenericTableViewDataSourceDelegate
public final class GenericTableViewDataSourceDelegate<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Public
    public typealias CellConfigurator = ((Model?, Cell) -> Void)
    public typealias DidSelectItem = (([Int:Int]) -> Void)
    public typealias LoadMore = ((Bool) -> Void)
    public var didSelectItemAt: DidSelectItem?
    public var loadMore: LoadMore?
    public var itemDisplayLimit: Int?
    public var deselectSelectedRow: Bool = true
    
    // MARK: Internal
    var models: [(header: Character, names: [Model])] = []
    let one = 1
    
    // MARK: Private
    private let cellConfigurator: CellConfigurator
    
    // MARK: Initialiser
    public init(models: [(header: Character, names: [Model])],
                cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.cellConfigurator = cellConfigurator
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(models[section].header)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemDisplayLimit ?? models[section].names.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var dict: [Int:Int] = [:]
        dict[section] = row
        didSelectItemAt?(dict)
        if deselectSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let model = models[items[indexPath.section]]?[indexPath.row]
        let model = models[indexPath.section].names[indexPath.row]
        let cell = tableView.dequeue(Cell.self, for: indexPath)
        
        cellConfigurator(model, cell)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.section == tableView.numberOfSections - 1 {
            if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                loadMore?(true)
            } else {
                loadMore?(false)
            }
        }
    }
}

