//
//  ViewController.swift
//  KolodoTest
//
//  Created by Shashank Gupta on 27/05/16.
//  Copyright © 2016 Shashank Gupta. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: UInt = 4

class ViewController: UIViewController {
    
    @IBOutlet var kolodaView: KolodaView!
    
    private var dataSource: Array<UIImage> = {
        var array: Array<UIImage> = []
        for index in 0..<numberOfCards {
            print("pic\(index + 1)");
            array.append(UIImage(named: "pic\(index + 1)")!)
        }
        
        return array
    }()
    
    //Mark: Lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.delegate=self
        kolodaView.dataSource=self
        
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
    }
    @IBAction func leftButtonTapped(){
        kolodaView?.swipe(SwipeResultDirection.Left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
}

extension ViewController:KolodaViewDelegate{
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        dataSource.insert(UIImage(named: "pic3")!, atIndex: kolodaView.currentCardIndex - 1)
        let position = kolodaView.currentCardIndex
        kolodaView.insertCardAtIndexRange(position...position, animated: true)
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://google.com/")!)
    }
}

extension ViewController:KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda:KolodaView) -> UInt {
        return UInt(dataSource.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
}

