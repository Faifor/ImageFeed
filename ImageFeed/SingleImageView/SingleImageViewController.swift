//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Данила Спиридонов on 15.06.2025.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
                
            }
        }
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
}
