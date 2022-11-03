//
//  ViewController.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerTableCell(LagosDevTableViewCell.self)
        tableView.rowHeight = 50
        return tableView
    }()
    
    private var page: Int = 1
    private var lastPage: Int = 1
    private var total: Int = 1
    private var viewModel: ViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: GenericTableViewDataSourceDelegate<TableViewValue, LagosDevTableViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        view.backgroundColor = .white
        viewModel = ViewModel()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpData()
    }
    private func setUpView() {
        view.addSubview(tableView)
        tableView.constrainVerticalEdges(to: view)
        tableView.constrainHorizontalEdges(to: view)
    }
    
    private func setUpData() {
        viewModel?.fetchFromDB()
        viewModel?.$itemsFromDb
            .sink(receiveValue: { result in
                if result.isEmpty {
                    self.viewModel?.fetchDataFromApi(page: 1)
                } else {
                    self.didFetchData(data: self.viewModel?.sortValueByPage(data: result) ?? [])
                }
            })
            .store(in: &cancellables)
    }
    
    private func handleTableViewDataSource(model: ItemDataSource) -> GenericTableViewDataSourceDelegate<TableViewValue, LagosDevTableViewCell> {
        return GenericTableViewDataSourceDelegate<TableViewValue, LagosDevTableViewCell>(
            models: model.sections) { (result, cell) in
                cell.setUpData(data: result)
            }
    }
    
    private func handleTableView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    
    private func didFetchData(data: [TableViewValue]) {
        let values: ItemDataSource = .init(data: data)
        dataSource = handleTableViewDataSource(model: values)
        dataSource?.didSelectItemAt = handleDidSelect(data: values)
        handleTableView()
        tableView.reloadData()
        self.total = data.first?.total ?? 1
        self.page = data.last?.page ?? 1
        self.lastPage = 10
        loadMore()
    }
    
    private func handleDidSelect(data: ItemDataSource) -> (([Int:Int]) -> Void) {
        return { [weak self] row in
            guard let self = self else { return }
            self.didSelectTransaction(value: data.sections[row.first?.key ?? 0].names[row.first?.value ?? 0])
        }
    }

    private func didSelectTransaction(value: TableViewValue) {
        /// handle did select row
        let detailViewController = DetailViewController()
        detailViewController.value = value
        detailViewController.viewModel = viewModel
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func loadMore() {
        
        dataSource?.loadMore = { [weak self] value in
            guard let self = self else { return }
            if value {
                self.page += 1
                if self.page <= self.lastPage {
                    // make Request update Table
                    self.viewModel?.fetchDataFromApi(page: self.page)
                }
            }
        }
    }
}

