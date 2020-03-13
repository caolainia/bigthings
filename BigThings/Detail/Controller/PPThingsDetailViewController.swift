//
//  PPThingsDetailViewController.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//  Big Things Detail Page

import UIKit
import Alamofire

class PPThingsDetailViewController: UIViewController {

    public var thingsVo: PPThingsVo?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var locationL: UILabel!
    
    @IBOutlet weak var yearL: UILabel!
    
    @IBOutlet weak var votesL: UILabel!
    
    @IBOutlet weak var ratingL: UILabel!
    
    @IBOutlet weak var descriptionL: UILabel!
    
    @IBOutlet weak var myRatingL: UILabel!
    
    @IBOutlet weak var rateB: UIButton!
    
    @IBOutlet weak var favoriteB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = thingsVo?.name
        nameL.text = thingsVo?.name
        locationL.text = thingsVo?.location
        yearL.text = thingsVo?.year
        votesL.text = (thingsVo?.votes ?? "0") + "    votes"
        ratingL.text = (thingsVo?.rating ?? "0") + "    rating"
        descriptionL.text = thingsVo?.descriptionForThing
        rateB.isEnabled = !(thingsVo?.isRated ?? false)
        favoriteB.isEnabled = !(thingsVo?.isFavorited ?? false)
        if let urlString = thingsVo?.image, urlString.count != 0 {
            self.imageView.kf.setImage(with: URL(string: imageUrlString + urlString), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        } else {
            self.imageView.backgroundColor = UIColor.lightGray
        }
        
        rateB.setBackgroundImage(UIImage.imageFromColor(color: UIColor(hex: 0x1296db), inSize: CGSize(width: 100, height: 44)), for: UIControl.State.normal)
        favoriteB.setBackgroundImage(UIImage.imageFromColor(color: UIColor(hex: 0x1296db), inSize: CGSize(width: UIScreen.main.bounds.width, height: 44)), for: UIControl.State.normal)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        myRatingL.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func gotoRate(_ sender: UIButton) {
        sender.isEnabled = false;
        guard let id = thingsVo?.id else {
            return
        }
        let urlString = "\(allBigThings)?action=rate&id=\(id)&rating=\(myRatingL.text ?? "3")"
        
        let dataResult = SessionManager.default.request(urlString, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        
        dataResult.responseData {[weak self] (response: DataResponse<Data>) in
            guard let weakSelf = self else {
                return
            }
            switch response.result {
            case .success(let value):
                if let object: PPRateResultVo = try? JSONDecoder().decode(PPRateResultVo.self, from: value) {
                    if (object.result == Optional("success")) {
                        PromptView.show(message: "Rate This Big Things Success!")
                        if let rating = object.rating {
                            weakSelf.thingsVo?.rating = rating
                            weakSelf.ratingL.text = rating + "    rating"
                        }
                        
                        if let votes = object.votes {
                            weakSelf.thingsVo?.votes = votes
                            weakSelf.votesL.text = votes + "    votes"
                        }
                        weakSelf.thingsVo?.isRated = true
                        
                        if let newValue = weakSelf.thingsVo {
                            newValue.updateToDatabase()
                        }
                        
                        weakSelf.rateB.isEnabled = false
                        
                    } else {
                        sender.isEnabled = true;
                        PromptView.show(message: object.message ?? "Failed to load data")
                    }
                } else {
                    PromptView.show(message: "Failed to load data")
                }
            case .failure(let error):
                sender.isEnabled = true;
                PPLog.logger(items: error.localizedDescription);
                PromptView.show(message: "There is no Internet")
            }
        }
    }
    
    
    @IBAction func doFavorite(_ sender: UIButton) {
        PromptView.show(message: "Favourited success")
        thingsVo?.isFavorited = true
        sender.isEnabled = false
        if let newValue = thingsVo {
            newValue.updateToDatabase()
        }
    }
    
}
