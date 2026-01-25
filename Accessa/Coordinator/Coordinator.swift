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
