//
//  future.swift
//  Future
//
//  Created by roni on 2019/12/30.
//  Copyright © 2019 roni. All rights reserved.
//

import Foundation

class Future<ValueType> {
    var result: Result<ValueType>? {
        didSet {
            result.map(notify)
        }
    }

    typealias Observer = (Result<ValueType>) -> Void
    lazy var callbacks = [Observer]()

    func register(with callback: @escaping Observer) {
        callbacks.append(callback)
        result.map(callback)
    }

    func notify(result: Result<ValueType>) {
        callbacks.forEach { $0(result) }
    }


    func map<NewValueType>(_ closure: @escaping (ValueType) throws -> NewValueType) rethrows -> Future<NewValueType> {
        let promise = Promise<NewValueType>()

        register { (result) in
            switch result {
            case .value(let value):
                do {
                    let newValue = try closure(value)
                    promise.resolve(with: newValue)
                }
                catch {
                    promise.reject(with: error)
                }
            case .error(let error):
                 promise.reject(with: error)
            }
        }

        return promise
    }

    func transform<NewValueType>(to: NewValueType) -> Future<NewValueType> {
        return map { _ in to }
    }
}

class Promise<ValueType>: Future<ValueType> {
    func resolve(with value: ValueType) {
        result = .value(value)
    }

    func reject(with error: Error) {
        result = .error(error)
    }
}

extension URLSession {
    func request(url: URL) -> Future<Data> {
        let promise = Promise<Data>()

        let task = dataTask(with: url) { (data, _, error) in
            if let error = error {
                promise.reject(with: error)
            }
            else {
                promise.resolve(with: data!)
            }
        }

        task.resume()
        return promise
    }
}
