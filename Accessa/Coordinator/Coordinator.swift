//
//  Coordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}


//TODO: sheidzleba wavshalo mere
extension Coordinator {
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
