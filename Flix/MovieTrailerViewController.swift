//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Craig Smith on 10/4/20.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var videos = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.videos = dataDictionary["results"] as! [[String:Any]]
                print(self.videos)
        
            // Code from Will Huynh
            let site = self.videos[0]["site"] as! String
            let key = self.videos[0]["key"] as! String
            
            if site == "YouTube" {
                let myURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
            }
           }
        }
        task.resume()
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
