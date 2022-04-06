//
//  AppDelegate.swift
//  InterestsCollection
//
//  Created by Alexander Nikolaychuk on 09.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let vc = BooksListTableController()
        vc.service = makeBooksService()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return true
    }
    
    func makeBooksService() -> BooksService {
//        let localService = RealmBooksService()
//        return CompositeLocalServiceWithRemoteFallback(
//            mainService: localService,
//            fallbackService: BooksCacheDecorator(loadService: RemoteBooksService(networkProvider: NetworkProvider()),
//                                                 cacheService: localService)
//        )
        
        
        let localService = InMemoryBooksService()
        return CompositeLocalServiceWithRemoteFallback(
            mainService: localService,
            fallbackService: BooksCacheDecorator(loadService: RemoteBooksService(networkProvider: NetworkProvider()),
                                                 cacheService: localService)
        )
    }
}
