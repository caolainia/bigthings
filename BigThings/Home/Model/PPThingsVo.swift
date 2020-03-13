//
//  PPThingsVo.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit

class PPThingsVo: NSObject, Codable {
    
    var id: String?
    
    var name: String?
    
    var location: String?
    
    var year: String?
    
    var status: String?
    
    var latitude: String?
    
    var longitude: String?
    
    var image: String?
    
    var rating: String?
    
    var votes: String?
    
    var updated: String?
    
    var descriptionForThing: String?
    
    var isRated: Bool = false
    
    var isFavorited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case descriptionForThing = "description"
        case id,name,location, year, status, latitude, longitude, image, rating, votes, updated
    }
    
    public func updateToDatabase() {
        if let queue = FMDBManager.sharedManager.sharedDatabaseQueue {
            queue.inTransaction { (db, value) in
                let sqlString = "REPLACE INTO BigThings(id,name,location,year,status,latitude,longitude,image,rating,votes,updated,description,isRated,isFavorited) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,'\(self.isRated ? 1 : 0)','\(self.isFavorited ? 1 : 0)')"
                let array: [String] = [
                    self.id ?? "",
                    self.name ?? "",
                    self.location ?? "",
                    self.year ?? "",
                    self.status ?? "",
                    self.latitude ?? "",
                    self.longitude ?? "",
                    self.image ?? "",
                    self.rating ?? "",
                    self.votes ?? "",
                    self.updated ?? "",
                    self.descriptionForThing ?? ""]
                try? db.executeUpdate(sqlString, values: array)
            }
        }
    }
    
    class func updateThings(things: [PPThingsVo], completeHandler: (() -> Void)? = nil) {
        if things.count == 0 {
            completeHandler?()
            return
        }
        if let queue = FMDBManager.sharedManager.sharedDatabaseQueue {
            queue.inTransaction { (db, value) in
                for item in things {
                    let sqlString = "REPLACE INTO BigThings(id,name,location,year,status,latitude,longitude,image,rating,votes,updated,description,isRated,isFavorited) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,'\(item.isRated ? 1 : 0)','\(item.isFavorited ? 1 : 0)')"
                    let array: [String] = [
                        item.id ?? "",
                        item.name ?? "",
                        item.location ?? "",
                        item.year ?? "",
                        item.status ?? "",
                        item.latitude ?? "",
                        item.longitude ?? "",
                        item.image ?? "",
                        item.rating ?? "",
                        item.votes ?? "",
                        item.updated ?? "",
                        item.descriptionForThing ?? ""]
                    try? db.executeUpdate(sqlString, values: array)
                }
            }
        }
    }
    
    class func queryAllBigThings(completeHandler: (([PPThingsVo]) -> Void)? = nil) {
        guard let queue = FMDBManager.sharedManager.sharedDatabaseQueue else {
            completeHandler?([PPThingsVo]())
            return
        }
        
        queue.inTransaction { (db, value) in
            let sqlString = "SELECT * FROM BigThings"
            if let result = try? db.executeQuery(sqlString, values: nil) {
                
                var array = [PPThingsVo]()
                
                while result.next() {
                    let things = PPThingsVo()
                    things.id = result.string(forColumn: "id")
                    things.name = result.string(forColumn: "name")
                    things.location = result.string(forColumn: "location")
                    things.year = result.string(forColumn: "year")
                    things.status = result.string(forColumn: "status")
                    things.latitude = result.string(forColumn: "latitude")
                    things.longitude = result.string(forColumn: "longitude")
                    things.rating = result.string(forColumn: "rating")
                    things.image = result.string(forColumn: "image")
                    things.votes = result.string(forColumn: "votes")
                    things.updated = result.string(forColumn: "updated")
                    things.isRated = result.bool(forColumn: "isRated")
                    things.isFavorited = result.bool(forColumn: "isFavorited")
                    things.descriptionForThing = result.string(forColumn: "description")
                    array.append(things)
                }
                completeHandler?(array)
            } else {
                completeHandler?([PPThingsVo]())
            }
        }
    }
}
