//
//  DependencyContainer.swift
//  Accessa
//
//  Created by Tatarella on 24.01.26.
//

final class DependencyContainer {

    private var registry: [String: () -> Any] = [:]

    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        registry[key] = factory
    }

    func resolve<T>(_ type: T.Type = T.self) -> T {
        let key = String(describing: type)
        guard let factory = registry[key],
            let instance = factory() as? T
        else {
            fatalError("DI Error: No registered entry for \(T.self)")
        }
        return instance
    }
}
