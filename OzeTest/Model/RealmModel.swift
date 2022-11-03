//
//  RealmModel.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import RealmSwift

// MARK: - LagosDevLocal
class LagosDevLocal: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var login: String?
    @Persisted var nodeID: String?
    @Persisted var avatarURL: String?
    @Persisted var gravatarID: String?
    @Persisted var total: Int?
    @Persisted var page: Int?
    @Persisted var repoData: List<DevRepoData>
}

class DevRepoData: Object {
    @Persisted var id = 0
    @Persisted var nodeID: String?
    @Persisted var name: String?
    @Persisted var fullName: String?
    
}

struct TableViewValue {
    var id: Int
    var login: String
    var nodeID: String
    var avatarURL: String
    var total: Int
    var page: Int
    var repoData: List<DevRepoData>
    
    init(value: LagosDevLocal) {
        self.id = value.id
        self.login = value.login ?? ""
        self.nodeID = value.nodeID ?? ""
        self.avatarURL = value.avatarURL ?? ""
        self.total = value.total ?? 0
        self.page = value.page ?? 0
        self.repoData = value.repoData
    }
}
