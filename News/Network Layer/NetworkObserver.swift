//
//  NetworkObserver.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/10/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation


protocol NetworkObserver{

    func handleSuccessWithJSONData(jsonData:Any,serviceName:String)
    func handleFailWithErrorMessage (errorMessage:String)
}
