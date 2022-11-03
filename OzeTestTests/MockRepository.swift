//
//  MockRepository.swift
//  OzeAssesmentTests
//
//  Created by Mac on 02/11/2022.
//

import Foundation
import Combine
@testable import OzeTest


class MockRepository: RequestProtocol {
    
    private var itemsFromDb2 = CurrentValueSubject<[TableViewValue], Never>([])
    private let cacheManager: CacheProtocol!
    var fetchRepoData: AnyPublisher<[RepoData], Error>!
    
    init(with cacheManager: CacheProtocol = LocalDataCacheManager.shared()
    ) {
        self.cacheManager = cacheManager
    }
    
    var itemsFromDb: CurrentValueSubject<[TableViewValue], Never> {
        get {
            return itemsFromDb2
        }
    }
    
    func fetchAllData(city: String, page: Int) {
        cacheManager.deleteData()
        cacheManager.writeToRealm(data: mockResponseFromApi, page: page)
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
        return fetchRepoData
    }
    
    func update(id: Int, updateValue: [RepoData], save: Bool) {
        cacheManager.updateDB(id: id, updateValue: updateValue, save: save)
    }
    
    let mockResponseFromApi = ApiResponse(totalCount: 1, items: [
        ItemResponse(login: "Anthony",
                     id: 1,
                     nodeID: "anth",
                     avatarURL: "url",
                     gravatarID: "an"),
        ItemResponse(login: "Tony",
                     id: 2,
                     nodeID: "ton",
                     avatarURL: "url",
                     gravatarID: "to"),
        ItemResponse(login: "Ekene",
                     id: 3,
                     nodeID: "eke",
                     avatarURL: "url",
                     gravatarID: "ek"),
        ItemResponse(login: "ken",
                     id: 4,
                     nodeID: "kendo",
                     avatarURL: "url",
                     gravatarID: "ke")
    ])
    
    let mockRepoData = [
        RepoData(id: 1, nodeID: "anth", name: "Anthony", fullName: "Anthony Ekene"),
        RepoData(id: 2, nodeID: "eme", name: "Emmanuel", fullName: "Emmanuel Eme"),
        RepoData(id: 3, nodeID: "ada", name: "Ada", fullName: "Adaora Fem"),
    ]

}
