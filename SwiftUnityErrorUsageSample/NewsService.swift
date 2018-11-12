//
//  NewsService.swift
//  SwiftUnityErrorUsageSample
//
//  Created by Isaac Weisberg on 11/12/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import SwiftUnityError

class NewsService {
    typealias News = [String]
    
    enum Error: UnityError {
        var unity: UnityError.Emission {
            return "\(self) error"
        }
        
        case networking
        case authorization
        case subscription
    }
    
    func getMeSomeNews() throws -> News {
        throw Error.authorization
    }
}
