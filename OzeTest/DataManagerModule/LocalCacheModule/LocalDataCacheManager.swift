//
//  LocalDataCacheManager.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import RealmSwift

protocol CacheProtocol {
    func writeToRealm(data: ApiResponse, page: Int)
    func fetchFromRealm() -> Results<LagosDevLocal>
    func updateDB (id: Int, updateValue: [RepoData], save: Bool)
    func deleteData()
}

class LocalDataCacheManager: CacheProtocol {
    
    // Create a shared Instance
    static let _shared = LocalDataCacheManager()
    
    // Shared Function
    class func shared() -> LocalDataCacheManager {
        return _shared
    }
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    func writeToRealm(data: ApiResponse, page: Int) {
        do {
            // Open a thread-safe.
            try realm.write {
                // Make any writes within this code block.
                // Realm automatically cancels this
                // if this code throws an exception. Otherwise,
                // Realm automatically commits the transaction
                // after the end of this code block.
                // Add the instance to the realm.
                convertApiResponseToRealmDataModel(data: data, page: page)
            }
        } catch let error as NSError {
            // Failed to write to realm.
            print(error,"Error")
        }
    }
    
    func updateDB (id: Int, updateValue: [RepoData], save: Bool) {
        let result = realm.objects(LagosDevLocal.self)
            
        do {
            // Open a thread-safe.
            try realm.write {
                // Make any writes within this code block.
                // Realm automatically cancels this
                // if this code throws an exception. Otherwise,
                // Realm automatically commits the transaction
                // after the end of this code block.
                // Add the instance to the realm.
                for value in result {
                    if value.id == id {
                        if save {
                            updateValue.forEach { res in
                                let devData = DevRepoData()
                                devData.id = res.id
                                devData.name = res.name
                                devData.fullName = res.fullName
                                devData.nodeID = res.nodeID
                                value.repoData.append(devData)
                            }
                        } else {
                            value.repoData.removeAll()
                        }
                        
                    }
                }
                realm.add(result, update: .modified)
            }
        } catch let error as NSError {
            // Failed to write to realm.
            print(error,"Error")
        }
    }
    
    func fetchFromRealm() -> Results<LagosDevLocal> {
        let result = realm.objects(LagosDevLocal.self).sorted(byKeyPath: "page",ascending: true)
        return result
    }
    
    func convertApiResponseToRealmDataModel(data: ApiResponse, page: Int) {
        var arrayOfLagosDevs : [LagosDevLocal] = []
        /// loop throug the data to upadte all local cache values
        for item in data.items ?? [] {
            let value = LagosDevLocal()
            value.id = item.id
            value.login = item.login
            value.nodeID = item.nodeID
            value.avatarURL = item.avatarURL
            value.gravatarID = item.gravatarID
            value.total = data.totalCount
            value.page = page
            arrayOfLagosDevs.append(value)
        }
        realm.add(arrayOfLagosDevs, update: .all)
    }
    
    func deleteData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
