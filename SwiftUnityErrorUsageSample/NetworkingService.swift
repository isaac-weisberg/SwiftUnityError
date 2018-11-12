//
//  NetworkingService.swift
//  SwiftUnityErrorUsageSample
//
//  Created by Isaac Weisberg on 11/12/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import SwiftUnityError
import Foundation

class NetworkingService {
    
    /*
     This one showcases capability for localization.
     Notice how NetworkingError is declared as a regular
     Error.
     
     What does this mean:
     The NetworkingService interface is NOT UnityError compliant.
     
     The NewtrokingService interface is a FAIE. Why so? Because it
     acknowledges (describes, defines, represents, presents, whatever you call it)
     an abstraction with finite precision (to a finite extent). That is:
     - The number of methods is finite.
     - The number of possible object types produced
     and consumed is finite (some would doubt it
     since `download` method features a generic parameter,
     but uhm no.).
     - The number of possible erroneous objects is also finite,
     which is obvious from the a brief overview of the source code
     (and unfortunately by no other means)
     - A set of all possible erroneous objects caters
     (exists on, works as a subset of, etc.) to a precisely
     one interface representing erroneous objects
     which is unique for this interface defining the abstraction.
     
     TL;DR: itz very gud! :DDDD
     
     However the NetworkingError object doesn't explicitly
     guarantee existence of a GUI emitter. Oh, and in this particular
     implemnetation in Swift, it means conforming to UnityError protocol.
     */
    class NetworkingError: Error {
        
    }
    
    func download<Object>() throws -> Object {
        throw NetworkingError()
    }
}

/*
 Okay, dis very gud, now imagine this class being implemented in a separate lib
 and you are not in right to fix the source code.
 
 LOL BITCH except that's how it's supposed to be!
 You, the user of a lib, is responsible for providing
 the implementation of the GUI emitter because it is only you
 who knows what, when and how should be emmited for mapping to view.
 
 Feeling what this bitch is about now?
 */

extension NetworkingService.NetworkingError: UnityError {
    /*
     Here, for example we localize the string through the default bundle table.
     */
    var unity: UnityError.Emission {
        return NSLocalizedString("Networking Error", comment: "Oh fuck it's networking error")
    }
}
