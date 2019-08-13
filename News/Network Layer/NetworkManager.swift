//
//  File.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/10/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var myData:NSMutableData?
    
    static var networkObserverDelegate : NetworkObserver?
    static var classServiceName: String?
    
    
    static func connectGetToURL(myURL:String,serviceName:String,serviceProtocol:ServiceProtocol){
    
        classServiceName = serviceName
        networkObserverDelegate = (serviceProtocol as! NetworkObserver)
  
  
        Alamofire.request(myURL).responseJSON{
            response in switch response.result {
            case .success(let JSON):
              //  print("Success with JSON: \(JSON)")
                networkObserverDelegate?.handleSuccessWithJSONData(jsonData: JSON,serviceName: classServiceName!)

                
            case .failure(let error):
                print("Request failed with error: \(error)")
                networkObserverDelegate?.handleFailWithErrorMessage(errorMessage: error as! String)

                }
        }
    
    }
}

