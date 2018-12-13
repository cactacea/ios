//
//  CardsViewController.swift
//  Cactacea_Example
//
//  Created by TAKESHI SHIMADA on 2018/12/12.
//  Copyright © 2018 Cactacea. All rights reserved.
//

import UIKit
import iCarousel

class CardsViewController: ViewController {

    @IBOutlet weak var carouselView: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carouselView.type = .rotary

        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
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

extension CardsViewController: iCarouselDelegate, iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 8
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let imageView: UIImageView
        
        if view != nil {
            imageView = view as! UIImageView
        } else {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 230))
        }
        
        imageView.image = UIImage(named: String(index + 1) + ".jpg")
        
        return imageView
    }
    
}
