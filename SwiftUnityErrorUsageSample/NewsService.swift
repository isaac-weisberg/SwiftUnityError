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
    
    var networkingService: NetworkingService!
    
    enum ServiceError: Error {
        case networking(UnityError) // OR, even better, NetworkingService.NetworkingError, if you are sure
        case authorization
        case subscription
    }
    
    func getMeSomeNews() throws -> News {
        let result: News
        do {
            result = try networkingService.download()
        } catch let error as UnityError {
            throw ServiceError.networking(error)
        }
        
        // One of the requirements of a FAEI's error interface
        // is to directly wrap error objects of other FAEIs
        // UNLESS:
        // - FAEI didn't produce a UnityError-conforming object
        //
        //
        // WARNING: In this case, you, of course, could just throw the `error`
        // since NetworkingService conforms to UnityError standard and hence
        // guarantees conformance of the error object to UnityError protocol.
        //
        // You are still REQUIRED to wrap instead of propagating directly, thus maintaining a tree!
        //
        // This allows us to know, which chain of FAIE's might cummulatively produce which error in a static manner.
        // Note: not which chain of OBJECTS IN MEMORY-- you use a debugger for this one.
        
        /**
         Oh hey shit what? but like, there is no generic `catch` clause, what the heck? So like what,
         the object that didn't conform to UnityError
         just gets propagated down without any handling and wrapping?
         Spoiler: yas.
         */
        
        return result
    }
}


/**
 There is literally no need do declare right away
 FAEI's error interface compliance to UnityError.
 
 This can be moved to a separate file and may or may not contain localization logic.
 */
extension NewsService.ServiceError: UnityError {
    var unity: UnityError.Emission {
        /**
         One of the primary advantages of the standard it allows for
         creation of an explicit error tree which allows you to
         establish a tremedous flexibility in GUI emitter's implementation.
         
         Here, the control flow of the implementation allows for a more
         detailed and informative emission result. If you need one, but chances are, you don't.
         */
        if case .networking(let error) = self {
            return "\(self) error: \(error.unity)"
        }
        
        /*
         Oh, and calling String.init(describing: self) produces a string value
         equivalent to the name of the enumeration case. This allows you to not
         to write verbose mappings of cases to string literals even when an enum
         doesn't have String as a rawType. gud shit
        */
        return "\(self) error"
    }
}
