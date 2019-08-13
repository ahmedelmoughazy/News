//
//  NewsPresenter.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/10/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation


class NewsPresenter : INewsPresenter{

    var newsView:INewsView

    private static var sharedInstance: NewsPresenter!
    
    
    private init(newsView:INewsView){
        self.newsView = newsView;
        NewsPresenter.sharedInstance = self
    }

    static func shared(newsView:INewsView) -> NewsPresenter{
    
        switch sharedInstance {
        case let i?:
            i.newsView = newsView
            return i
        default:
            sharedInstance = NewsPresenter(newsView: newsView)
            return sharedInstance
        }
    }
    
    func getNews(page:Int,countryCode:String){
        newsView.showLoading()
    
        let newsService = NewsService.shared
        newsService.getNews(newsPresenter: self,page: page,countryCode: countryCode)
    
    }

    func onSuccess(news:Array<News>){
    
        newsView.renderNewsWithObject(news: news)
        newsView.hideLoading()
    
    }
    
    
    func onFail(errorMessage:String){
        
        newsView.showErrorMessage(errorMessage: errorMessage)
        newsView.hideLoading()
    }
}
