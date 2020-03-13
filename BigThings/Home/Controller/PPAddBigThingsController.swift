//
//  PPAddBigThingsController.swift
//  BigThings
//
//  Created by PP on 2019/11/9.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class PPAddBigThingsController: UIViewController {

    @IBOutlet weak var chooseImageV: UIImageView!
    
    @IBOutlet weak var submitB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseImageV.contentMode = UIView.ContentMode.scaleAspectFill
        chooseImageV.isUserInteractionEnabled = true; submitB.setBackgroundImage(UIImage.imageFromColor(color: UIColor(hex: 0x1296db), inSize: CGSize(width: UIScreen.main.bounds.width, height: 44)), for: UIControl.State.normal)
    }

    // UITapGestureRecognizer Action
    @IBAction func chooseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        //public.image    image
        //public.movie    movie
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func doCommit(_ sender: Any) {
        PromptView.show(message: "Commit Big Things")
    }
    
}

extension PPAddBigThingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //选择图片之后
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.chooseImageV.image = image
        }
    }
    
    /// 取消之后
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
