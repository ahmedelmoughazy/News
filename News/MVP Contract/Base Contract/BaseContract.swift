//
//  BaseContract.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/10/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import Foundation

protocol IBaseView {

    func showLoading()
    func hideLoading()
    func showErrorMessage(errorMessage:String)
}
