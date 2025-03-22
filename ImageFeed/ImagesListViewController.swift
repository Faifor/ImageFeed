//
//  ViewController.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 27.02.2025.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let words = [
        ["Apple", "Pear", "Watermelon"],
        ["Carrot", "Pickle", "Potato", "Tomato"],
        ["Strawberry", "Raspberry", "Blackberry", "Blueberry"]
    ]
    let headers = ["Fruits", "Vegetables", "Berries"]
}

