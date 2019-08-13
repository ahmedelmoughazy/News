//
//  RLMDBManger.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/12/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation
import RealmSwift

class RLMDBManger {

    private init() {
    }
    
    static let sharedInstance = RLMDBManger()

    func addNews(news:Array<News>){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            for i in 0...4{
                realm.add(news[i])
            }
        }
        print("Added");
    }

    func getAllNews() ->Array<News> {
        let realm = try! Realm()
        let news = realm.objects(News.self)
        var newsArray = Array<News>()
        for item in news{
            newsArray.append(item)
                    print("\(item.author)")
        }
        return newsArray
    }
}
