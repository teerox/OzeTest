//
//  ViewModel.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import Combine
import Realm
import RealmSwift

enum DataFetched {
    case success([RepoData])
    case failed
    case compeleted
}

final class ViewModel {
    
    private var cancellableSet = Set<AnyCancellable>()
    private let repository: RequestProtocol!
    @Published var itemsFromDb: [TableViewValue] = []
    @Published var repoDataCount: [RepoData] = []
    @Published var dataFetch: DataFetched = .compeleted
    var saveData = false

    init(with repository: RequestProtocol = Repository()) {
        self.repository = repository
    }
    
    /// Fetch Data from Api
     func fetchDataFromApi(page: Int) {
        repository.fetchAllData(city: "lagos", page: page)
    }
    
    /// Fetch from Cache Data
    func fetchFromDB() {
        repository.fetchDataFromDB()
        
        let _ = repository.itemsFromDb
            .assign(to: &$itemsFromDb)
    }
    
    func sortValueByPage(data: [TableViewValue]) -> [TableViewValue] {
        var newArray: [TableViewValue] = []
        newArray.append(contentsOf: data)
        newArray.sort { $0.page < $1.page }
        return newArray
    }
    
    func fetchRepoData(name: String) {
        repository
            .fetchRepoData(name: name)
            .sink { value in
                switch value {
                case .finished:
                    self.dataFetch = .compeleted
                case .failure(_):
                    self.dataFetch = .compeleted
                }
            } receiveValue: { data in
                self.dataFetch = .success(data)
                self.repoDataCount = data
            }
            .store(in: &cancellableSet)
    }
    
    func update(id: Int, updateValue: [RepoData], save: Bool) {
        repository.update(id: id, updateValue: updateValue, save: save)
    }
    
    func transformArray(value : List<DevRepoData> ) -> [RepoData] {
        var result: [RepoData] = []
        value.forEach { res in
            let devData = RepoData(id: res.id,
                                   nodeID: res.name,
                                   name: res.name,
                                   fullName: res.fullName)
            result.append(devData)
        }
        return result
    }
}
