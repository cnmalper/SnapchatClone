//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 18.04.2023.
//

import UIKit
import ImageSlideshow
import SDWebImage

class SnapVC: UIViewController {
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    var selectedSnap : Snap?
    var selectedTime : Int?
    var inputArray = [SDWebImageSource]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let time = selectedTime {
            self.timeLeftLabel.text = "Time left: \(time)"
        }
        
        if let snap = selectedSnap {
            for imageUrl in snap.imageUrlArray {
                inputArray.append(SDWebImageSource(urlString: imageUrl)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.90))
            imageSlideShow.backgroundColor = UIColor.white
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.tintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLeftLabel)
        }
    }

}
