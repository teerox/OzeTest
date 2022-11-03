//
//  Repository.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import Combine
import RealmSwift

protocol RequestProtocol {
    var itemsFromDb: CurrentValueSubject<[TableViewValue], Never> { get }
    
    func fetchAllData(city: String, page: Int)
    func fetchDataFromDB()
    func fetchRepoData(name: String) -> AnyPublisher<[RepoData], Error>
    func update(id: Int, updateValue: [RepoData], save: Bool)
}

class Repository: RequestProtocol {
    
    var itemsFromDb: CurrentValueSubject<[TableViewValue], Never> {
        get {
            return itemsFromDb2
        }
    }
    
    private let networkManger: ServiceProtocol!
    private let cacheManager: CacheProtocol!
    private var cancellableSet: Set<AnyCancellable> = []

    private var itemsFromDb2 = CurrentValueSubject<[TableViewValue], Never>([])
    
    /// Initialze Network Manager and cache manager here
    /// - Parameters: For Testing Purpose mocked `networkManger` and `cacheManager`
    /// can be injected into this viewModel
    ///   - networkManger: Fetch result from Api
    ///   - cacheManager: fetch and cache result in a local database
    init(with networkManger: ServiceProtocol = NetworkManager.shared(),
         with cacheManager: CacheProtocol = LocalDataCacheManager.shared()
    ) {
        self.networkManger = networkManger
        self.cacheManager = cacheManager
    }
    
    func fetchAllData(city: String, page: Int) {
        let result: AnyPublisher<ApiResponse, Error> = networkManger
            .makeReques(url: "search/users",
                        method: .get,
                        parameters: ["q" : city,"page" : page])
        result
            .sink { completion in
                switch completion {
                case .finished:
                    self.fetchDataFromDB()
                case .failure(let error):
                    self.fetchDataFromDB()
                    self.logError(with: error)
                }
            } receiveValue: { result in
                self.cacheManager.writeToRealm(data: result,page: page)
            }.store(in: &cancellableSet)
    }
    
    func fetchDataFromDB() {
        var resultArray = [TableViewValue]()
        let result = cacheManager.fetchFromRealm()
        
        if !result.isEmpty {
            resultArray.removeAll()
            for value in result {
                resultArray.append(TableViewValue(value: value))
            }
        }
        itemsFromDb.send(resultArray.sorted(by: { $0.login  < $1.login }))
    }

    func fetchRepoData(name: String) -> AnyPublisher<[RepoData], Error> {
        let result: AnyPublisher<[RepoData], Error> = networkManger
            .makeReques(url: "users/\(name)/repos", method: .get, parameters: nil)
        return result
    }
    
    func update(id: Int, updateValue: [RepoData], save: Bool) {
        cacheManager.updateDB(id: id, updateValue: updateValue, save: save)
    }
    
    private func logError( with error: Error) {
        print("Error fetching Data")
    }
}
