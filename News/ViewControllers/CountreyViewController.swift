//
//  CountreyViewController.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/12/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import UIKit
import iOSDropDown

class CountreyViewController: UIViewController {

    @IBOutlet weak var dropDown: DropDown!
    var newsVC:NewsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsVC = (self.storyboard?.instantiateViewController(withIdentifier: "NVC") as! NewsTableViewController)
        
        dropDown.optionArray = ["ae","us","de","eg","br","fr","ru","ca"]
        dropDown.didSelect{(selectedText , _,_) in
            self.newsVC!.countryCode = selectedText;
            self.navigationController?.pushViewController(self.newsVC!, animated: true)
        }
        
    }
    
    @IBAction func goWithDefault(_ sender: Any) {

        newsVC!.countryCode = "us"
        self.navigationController?.pushViewController(newsVC!, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
