//
//  MoviesViewController.swift
//  fled
//
//  Created by Luu, Loc on 9/4/21.
//

import UIKit
import AlamofireImage
//step 1 add to class UITableViewDataSource, UITableViewDelegate

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    //array of movies
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //step3
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        print("hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    //store to movies
                    self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.tableView.reloadData()
                    //print(dataDictionary)
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    //step2
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellTableViewCell") as! MovieCellTableViewCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
       // cell.textLabel!.text = title
        cell.synopsisLabel.text = synopsis
        cell.titleLabel.text = title
        
        let baseUrl = "https://image.tmdb.org/t/p/w185/"
        let postePpath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + postePpath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
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
