//
//  NewsTableViewController.swift
//  News
//
//  Created by Ahmed Elmoughazy on 8/11/19.
//  Copyright © 2019 Ahmed Elmoughazy. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewController: UITableViewController,INewsView {

    
    var newsArray = Array<News>()
    var countryCode:String?
    let cellReuseIdentifier = "Cell"
    var newsPresenter:NewsPresenter?
    var refreshFlag:Bool = false
    var currentPageNum = 1
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.newsArray.removeAll()
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            //Background Thread
            
            self.newsPresenter = NewsPresenter.shared(newsView: self)
            self.newsPresenter!.getNews(page: self.currentPageNum ,countryCode: self.countryCode!)
            
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  self.tableView.register(TableCell.self, forCellReuseIdentifier: "Cell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func refresh() {
        self.newsPresenter!.getNews(page: self.currentPageNum,countryCode: self.countryCode!)
        self.refreshFlag = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // if reached last row, load next batch
        if indexPath.row == self.newsArray.count-1 {
            self.currentPageNum += 1
            loadNextPage()
        }
        
        let cell:TableCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! TableCell
        
        cell.newsImage.sd_setImage(with: URL(string: newsArray[indexPath.row].urlToImage), placeholderImage: UIImage(named: "placeholder.png"))
        cell.titleLabel.text = newsArray[indexPath.row].title
        cell.authorLabel.text = newsArray[indexPath.row].author
        cell.descriptionText.text = newsArray[indexPath.row].newsDescription

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Prepare the popup assets
        let title = "News Description"
        let message = newsArray[indexPath.row].newsDescription
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
 
    func loadNextPage(){
        self.newsPresenter!.getNews(page: self.currentPageNum ,countryCode: self.countryCode!)
    }
    
    func renderNewsWithObject (news : Array<News>){
        if(refreshFlag){
            self.refreshControl?.endRefreshing()
            newsArray.removeAll()
            currentPageNum = 1
            refreshFlag = false
        }
        for item in news{
            newsArray.append(item)
        }
        self.tableView.reloadData()
    }
    
    func showLoading(){
        print("Show Loading\n")
    }
    
    func hideLoading(){
        print("hide Loading\n")
    }
    
    func showErrorMessage(errorMessage:String){
        //        var alert = UIAlertView("Error" ,errorMessage ,nil,nil,"Ok", nil)
        //        alert.show()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
