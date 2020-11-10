//
//  KeyValueStore.swift
//  Composable
//
//  Created by Евгений Суханов on 09.11.2020.
//

import Foundation

protocol KeyValueStore {
    func set<T: Encodable>(_ value: T, forKey key: String)
    func value<T: Decodable>(forKey key: String) -> T?
}

extension KeyValueStore {
    func value<T: Decodable>(forKey key: String) -> T {
        guard let value: T = value(forKey: key) else {
            fatalError("Value for key \(key) is nil")
        }
        return value
    }
}

struct KeyValueStoreImpl: KeyValueStore {
    private let _userDefaults: UserDefaults
    private let _encoder = JSONEncoder()
    private let _decoder = JSONDecoder()

    private enum PlistKey: String, Hashable, Codable {
        case key
    }

    public init(userDefaults: UserDefaults = .standard) {
        _userDefaults = userDefaults
    }

    func set<Value: Encodable>(_ value: Value, forKey key: String) {
        do {
            _userDefaults.set(try _encoder.encode(value), forKey: key)
        } catch {
            let plistValue = [PlistKey.key: value]
            _userDefaults.set(try! _encoder.encode(plistValue), forKey: key)
        }
    }

    func value<T: Decodable>(forKey key: String) -> T? {
        guard let encodedValue = _userDefaults.value(forKey: key) as? Data else {
            return nil
        }
        guard let value = try? _decoder.decode(T.self, from: encodedValue) else {
            guard let value = try? _decoder.decode(Dictionary<PlistKey, T>.self, from: encodedValue) else {
                return nil
            }
            return value[PlistKey.key]
        }
        return value
    }
}

