//
//  UnityError.swift
//  SwiftUnityError
//
//  Created by Isaac Weisberg on 11/12/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

public protocol UnityError: Error {
    var unity: Emission { get }
}
