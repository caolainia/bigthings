//
//  FMDBManager.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit
import FMDB

private let  PRAGMA_USER_VERSION: Int32 = 1;

class FMDBManager: NSObject {

    private override init() {
        
    }
    
    /// Single
    public static let sharedManager: FMDBManager = FMDBManager()
    
    
    /// DB Path
    let currentDBFile: String = {
        var dataPath = NSHomeDirectory()
        dataPath.append("/Documents")
        dataPath.append("/BigThings.sqlite")
        
        if (!FileManager.default.fileExists(atPath: dataPath)) {
            FileManager.default.createFile(atPath: dataPath, contents: nil, attributes: nil)
        }
        PPLog.logger(items: dataPath)
        return dataPath
    }()
    
    public private(set)  lazy var sharedDatabaseQueue: FMDatabaseQueue! = {
        return FMDatabaseQueue(path: self.currentDBFile)
    }()
    
    public func createTableIfNeed() {
        guard let queue = sharedDatabaseQueue else {
            return
        }
        
        queue.inTransaction { (db, value) in
            if (db.isOpen) {
                guard let result = try? db.executeQuery("PRAGMA USER_VERSION", values: nil) else {
                    return
                }
                while (result.next()) {
                    let current = result.int(forColumnIndex: 0)
                    if (current < PRAGMA_USER_VERSION) {
                        _createTables(db: db, currentVersion: current, distanceVersion: PRAGMA_USER_VERSION)
                    }
                }
            }
        }
    }
    
    fileprivate func _createTables(db: FMDatabase, currentVersion: Int32, distanceVersion: Int32) {
        var index = currentVersion
        while index < distanceVersion {
            if let filePath = Bundle.main.path(forResource: "BigThings_\(currentVersion + 1)", ofType: "sql") {
                if (FileManager.default.fileExists(atPath: filePath)) {
                    if let sqlData =  FileManager.default.contents(atPath: filePath) {
                        if let sqlArray = String(data: sqlData, encoding: String.Encoding.utf8)?.components(separatedBy: ";") {
                            for item in sqlArray {
                                let sql = item.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                if (sql.count > 0) {
                                    try? db.executeUpdate(sql, values: nil)
                                }
                            }
                        }
                    }
                }
            }
            index += 1
        }
    }
}
