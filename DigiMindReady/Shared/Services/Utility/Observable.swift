//
//  Observable.swift
//
//  Created by Md. Mehedi Hasan on 20/2/22.
//

import Foundation

//Observable Protocol

protocol ObservableProtocol {
    associatedtype T
    typealias Observer = (T) -> Void
    var value: T { get set }

    func bind(observer: @escaping Observer)
    func bindAndFire(observer: @escaping Observer)
}

final class Observable<T>: ObservableProtocol {
    typealias Observer = (T) -> Void

    var observer: Observer?
    var value: T {
        didSet {
            observer?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(observer: @escaping Observer) {
        self.observer = observer
    }

    func bindAndFire(observer: @escaping Observer) {
        self.observer = observer
        observer(value)
    }
}

final class Observables {
    static func combineLatest<U, V>(_ a: Observable<U>, _ b: Observable<V>, _ callBack: @escaping (U, V) -> Void) {
        a.bind(observer: { _ in
            callBack(a.value, b.value)
        })

        b.bind(observer: { _ in
            callBack(a.value, b.value)
        })
    }

    static func combineLatest<U, V, W>(_ a: Observable<U>, _ b: Observable<V>, _ c: Observable<W>, _ callBack: @escaping (U, V, W) -> Void) {
        a.bind(observer: { _ in
            callBack(a.value, b.value, c.value)
        })

        b.bind(observer: { _ in
            callBack(a.value, b.value, c.value)
        })

        c.bind(observer: { _ in
            callBack(a.value, b.value, c.value)
        })
    }
}
