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
        // 2 remote retries with local fallback
//        let localService = RealmBooksService()
//        let remoteService = RemoteBooksService(networkProvider: NetworkProvider())
//        return CompositeLocalServiceWithRemoteFallback(
//            mainService: CompositeLocalServiceWithRemoteFallback(
//                mainService: remoteService,
//                fallbackService: remoteService),
//            fallbackService: localService
//        )
        
        // 3 remote retries before local fallback
//        let localService = RealmBooksService()
//        let remoteService = RemoteBooksService(networkProvider: NetworkProvider())
//        return BooksServiceCompositeWithFallback(
//            mainService: BooksServiceCompositeWithFallback(
//                mainService: BooksServiceCompositeWithFallback(
//                    mainService: BooksServiceCompositeWithFallback(
//                        mainService: remoteService,
//                        fallbackService: remoteService
//                    ),
//                    fallbackService: remoteService
//                ),
//                fallbackService: remoteService
//            ),
//            fallbackService: localService
//        )
        
        // 1 remote retries before local fallback
        let localService = RealmBooksService()
        let remoteService = RemoteBooksService(networkProvider: NetworkProvider())
        return BooksServiceCompositeWithFallback(
            mainService: remoteService.retry(1),
            fallbackService: localService
        )
    }
}
