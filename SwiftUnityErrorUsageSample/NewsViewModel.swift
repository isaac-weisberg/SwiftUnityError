//
//  NewsViewModel.swift
//  SwiftUnityErrorUsageSample
//
//  Created by Isaac Weisberg on 11/12/18.
//  Copyright © 2018 Isaac Weisberg. All rights reserved.
//

import SwiftUnityError

class NewsViewModel {
    let newsService = NewsService()
    
    func getSomeNews() {
        do {
            gotSomeNews(
                try newsService.getMeSomeNews()
            )
        } catch let error as NewsService.ServiceError {
            if case .networking = error {
                networkingErrorOccured(error) // handle special cases without seeking the error tree
                return // or not since in ideal UI, having a network problem can be easily treated twice
            }
            unityErrorOccured(error) // generic cases
        } catch {
            // Aaaand it happend. Some idiot thrown something that is not UnityError compliant.
            // Here is the most meme-ful part: we ain't gonna be propagating THAT piece of shit
            // to GUI because it will only mean that we haven't learned shit ever since we have
            // started using UnityError.
            
            // Here is what must be done instead:
            fatalError("Fuck you, idiot, why did I get \(error)")
        }
    }
    
    // The hypothetical means of GUI positive results propagation
    // These mean that everything is fine
    var gotSomeNews: ((NewsService.News) -> Void)!
    
    // The hypothetical means of GUI error propagation
    var unityErrorOccured: ((UnityError) -> Void)!
    // This is an utmostly common usage case
    // in which the UnityError represents
    // an error that has occured while working
    // with whichever service under whichever conditions.
    // This is the most generic interface which is called
    // on a whole bunch of common shit.
    // What will be going on in the view layer, is that
    // an emission will be produced and mapped to GUI.
    // Note: here, a view is supposed to fiddle with all
    // UnityError objects in the same generic way.
    
    var networkingErrorOccured: ((UnityError) -> Void)!
    // This, however, is unique and used for cases requiring
    // special treatment
    // Despite being totally explicit about
    // the actual error's contents semantics,
    // this unit of GUI error propagation
    // just propagates the error object,
    // preferably already casted to UnityError,
    // to the view layer.
    // Note: GUI emitter IS NOT INVOKED HERE.
    // Why tho? Because WE ARE NOT THE VIEW,
    // WE ISN'T INTERESTED IN THIS GARBAGE
}
