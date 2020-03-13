//
//  PPAboutViewController.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit

class PPAboutViewController: UIViewController {
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.text = "The big things of Australia are a loosely related set of large structures, some of which are novelty architecture and some are sculptures. There are estimated to be over 150 such objects around the country. There are big things in every state and territory in continental Australia. Most big things began as tourist traps found along major roads between destinations. The big things have become something of a cult phenomenon, and are sometimes used as an excuse for a road trip, where many or all big things are visited and used as a backdrop to a group photograph. Many of the big things are considered works of folk art and have been heritage-listed, though others have come under threat of demolition."
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
