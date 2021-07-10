//
//  CoordinatorDelegate.swift
//  Moviez
//
//  Created by MacBook  on 10.07.21.
//

import  UIKit

protocol CoordinatorDelegate: UIViewController {
    var coordinator: CoordinatorProtocol? { get set }
}
