//
//  NewsService.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/10/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation
import Network

class NewsService : NetworkObserver , ServiceProtocol , INewsManager{

    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    
    var pageNumber = 1
    var pageSize = 10
    
    private init() {
    }
    
    static let shared = NewsService()
    
    var newsPresenter:INewsPresenter?
    
    
    func getNews (newsPresenter : INewsPresenter,page:Int,countryCode:String){
    
        self.pageNumber = page
        self.newsPresenter = newsPresenter;
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                NetworkManager.connectGetToURL(myURL: "https://newsapi.org/v2/top-headlines?country=\(countryCode)&apiKey=bbb0fc310ea44afb88d8952e2c8bdbc5&pagesize=\(self.pageSize)&page=\(page)",serviceName: "NewsService",serviceProtocol: self)
            } else {
                print("There's no internet connection.")
                let rlmdbManager = RLMDBManger.sharedInstance
                let newsArray = rlmdbManager.getAllNews()
                self.newsPresenter!.onSuccess(news: newsArray)
                
            }
        }
        
        monitor.start(queue: queue)
    
    }
    
    
    func handleSuccessWithJSONData(jsonData:Any,serviceName:String){
    
        var newsArray = Array<News>()
        
        if (serviceName == "NewsService") {

            let dict = jsonData as! NSDictionary

            let articlesArray = dict.object(forKey: "articles") as! NSArray
            
            for article in articlesArray{
                
                let newsObject = article as! NSDictionary
                let author = newsObject.object(forKey: "author") as? String ?? "No Author"
                let title = newsObject.object(forKey: "title") as? String ?? "No Title"
                let description = newsObject.object(forKey: "description") as? String ?? "No Description"
                let urlToImage = newsObject.object(forKey: "urlToImage") as? String ?? "http://www.firecareservices.com.au/wp-content/uploads/2016/04/image-placeholder.jpg"
                
                let news = News()
                news.author = author
                news.title = title
                news.newsDescription = description
                news.urlToImage = urlToImage
                
                newsArray.append(news)
            }
            
            if pageNumber == 1 {
                let rlmdbManager = RLMDBManger.sharedInstance
                rlmdbManager.addNews(news: newsArray)
            }
    
            newsPresenter!.onSuccess(news: newsArray)
    
        }
    }

    func handleFailWithErrorMessage(errorMessage: String) {
        newsPresenter!.onFail(errorMessage: errorMessage)
    }
}
