//
//  NewsContract.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/10/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation

protocol INewsView : IBaseView {
    func renderNewsWithObject (news : Array<News>)
}


protocol INewsPresenter{

    func getNews(page:Int,countryCode:String)
    func onSuccess(news : Array<News>)
    func onFail (errorMessage : String)
}



protocol INewsManager {
    func getNews (newsPresenter : INewsPresenter,page:Int,countryCode:String)
    
}
