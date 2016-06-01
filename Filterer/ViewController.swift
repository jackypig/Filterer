//
//  ViewController.swift
//  Filterer
//
//  Created by jpk on 5/31/16.
//  Copyright © 2016 Ling Hung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filteredImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var imageToggle: UIButton!
    
    @IBAction func onImageToggle(sender: UIButton) {
        imageView.image = filteredImage
        if imageToggle.selected {
            let image = UIImage(named: "Max")!
            imageView.image = image
            imageToggle.selected = false
        } else {
            imageView.image = filteredImage
            imageToggle.selected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "Max")!
        
        var rgbaImage = RGBAImage(image: image)!
        
        let avgRed = 107
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
                
                var modifier = 1 + 4 * (Double(y) / Double (rgbaImage.height))
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                
                pixel.red = UInt8(max(min(255, Int(round(Double (avgRed) + modifier * Double(redDelta)))), 0))
                rgbaImage.pixels[index] = pixel
            }
        }
        
        let result = rgbaImage.toUIImage()
        filteredImage = result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

