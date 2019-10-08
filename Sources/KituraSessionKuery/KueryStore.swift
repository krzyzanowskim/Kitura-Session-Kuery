// MIT License
//
// Copyright (c) 2018 Marcin Krzyzanowski
//

import Foundation
import KituraSession
import SwiftKuery

/// An implementation of the `Store` protocol for the storage of `Session` data Swift-Kuery.
public class KueryStore: Store {

    public class Sessions: Table {
        let tableName = "Sessions"
        let id = Column("id", Char.self, primaryKey: true)
        let data = Column("data", String.self)
    }

    private let db: SwiftKuery.Connection
    private var sessions: Sessions

    public init(connection: SwiftKuery.Connection) {
        db = connection
        sessions = Sessions()
        setupDB()
    }

    private func setupDB() {
        sessions.create(connection: db) { result in
            guard result.success else {
                print("Failed to create table: \(result)")
                return
            }
        }
    }

    public func load(sessionId: String, callback: @escaping (Data?, NSError?) -> Void) {
        let query = Select(sessions.data, from: sessions).where(sessions.id == sessionId)
        db.execute(query: query) { result in
            guard result.success else {
                callback(nil, result.asError as NSError?)
                return
            }

            result.asRows { rows, error in
                if let row = rows?.first {
                    if let base64String = row[self.sessions.data.name] as? String, let decodedData = Data(base64Encoded: base64String) {
                        callback(decodedData, nil)
                        return
                    }
                }
                callback(nil, nil)
            }

            // TODO: does this need to wait until completion?
        }
    }

    public func save(sessionId: String, data: Data, callback: @escaping (NSError?) -> Void) {
        let query = Insert(into: sessions, rows: [[sessionId, data.base64EncodedString()]])
        db.execute(query: query) { result in
            guard result.success else {
                callback(result.asError as NSError?)
                return
            }

            callback(nil)
        }
    }

    public func touch(sessionId _: String, callback: @escaping (NSError?) -> Void) {
        callback(nil)
    }

    public func delete(sessionId: String, callback: @escaping (NSError?) -> Void) {
        let query = Delete(from: sessions, where: sessions.id == sessionId)
        db.execute(query: query) { result in
            guard result.success else {
                callback(result.asError as NSError?)
                return
            }
            callback(nil)
        }
    }
}
