//
//  TableViewController.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//
import UIKit
class TableViewController: UITableViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelLoading: UILabel!
    @IBOutlet weak var views: UIView!
    
    var networkManager = NetworkManager()
    var worldNews = WorldNewsParseManager()
    var url = ""
    
    var article = [InterfaceNews]()
    var modelSong = [Interface]()
    
    @IBAction func changeaction(_ sender: Any) {
        DispatchQueue.main.async { 
            self.changeContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        getTop(url: Constants.top100App)
        let nib = UINib(nibName: NewTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewTableViewCell.reusableId)
    }
    
    func getNews () {
        worldNews.dataRecive(model: ModelNews.self, url: Constants.urlNews) { (article) in
            DispatchQueue.main.async {
                self.article = article.articles
                self.tableView.reloadData()
            }
        }
    }
    
    func getTop(url: String) {
        labelLoading.isHidden = false
        activityIndicator.isHidden = false
        networkManager.dataRecive(model: ModelInfo.self, url: url) { [weak self] (responce) in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                self.modelSong = responce.feed.results
                self.labelLoading.isHidden = true
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func changeContent() {
        modelSong = []
        tableView.reloadData()
        switch segmentedControl.selectedSegmentIndex {
        case 0 : article = [];  getTop(url: Constants.top100App)
        case 1:  article = [];  getTop(url: Constants.top100AppleMusic)
        case 2:  article = [];  getTop(url: Constants.top100Book)
        case 3:  article = [];  getTop(url: Constants.top100Hottracks)
        case 4:  getNews()
        default : break
        }
    }
}
