//
//  Cache.swift
//  Challenge
//
//  Created by Mehedi Hasan on 5/2/20.
//

import Foundation

protocol CacheProvider {
    associatedtype Value
    associatedtype Key: Hashable

    func insert(_ value: Value, for key: Key)
    func value(for key: Key) -> Value?
    func removeValue(for key: Key)
}

final class Cache<Key: Hashable, Value>: CacheProvider {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()

    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 12 * 60 * 60,
         maximumEntryCount: Int = 100) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        wrapped.countLimit = maximumEntryCount
        wrapped.delegate = keyTracker
    }

    func insert(_ value: Value, for key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(key: key, value: value, expirationDate: date)
        insert(entry)
    }

    func value(for key: Key) -> Value? {
        let entry = self.entry(for: key)
        return entry?.value
    }

    func removeValue(for key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }

    private func entry(for key: Key) -> Entry? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }

        guard dateProvider() < entry.expirationDate else {
            // Discard values that have expired
            removeValue(for: key)
            return nil
        }

        return entry
    }

    private func insert(_ entry: Entry) {
        wrapped.setObject(entry, forKey: WrappedKey(entry.key))
        keyTracker.keys.insert(entry.key)
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            guard let value = newValue else {
                // If nil is assigned using subscript then
                // we should remove any value for that key
                removeValue(for: key)
                return
            }
            insert(value, for: key)
        }
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let object = object as? WrappedKey else {
                return false
            }
            return object.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date

        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

private extension Cache {
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()

        func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
            guard let entry = obj as? Entry else {
                return
            }
            keys.remove(entry.key)
        }
    }
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable {}

extension Cache: Codable where Key: Codable, Value: Codable {
    ///initialization with CacheName to load from Disk
    convenience init(withName name: String,
                     dateProvider: @escaping () -> Date = Date.init,
                     entryLifetime: TimeInterval = 12 * 60 * 60,
                     maximumEntryCount: Int = 100) {
        self.init(dateProvider: dateProvider, entryLifetime: entryLifetime, maximumEntryCount: maximumEntryCount)
        try? self.loadFromDisk(withName: name)
    }

    convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }

    func loadFromDisk(withName name: String) throws {
        let fileManager = FileManager.default
        let folderURLs = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try Data(contentsOf: fileURL)
        let entries = try JSONDecoder().decode([Entry].self, from: data)
        entries.forEach(insert)
    }

    func saveToDisk(withName name: String) throws {
        let fileManager = FileManager.default
        let folderURLs = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}
