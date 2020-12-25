//
//  ViewController.swift
//  S23-ML-SeeFood
//
//  Created by user183479 on 12/25/20.
//

import UIKit
import CoreML
import Vision   // will help us process images more easily and allows us to use images to work with CoreML without writing a whole lot of code

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()  // A view controller that manages the system interfaces for taking pictures, recording movies, and choosing items from the user's media library.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure imagePicker
        imagePicker.delegate = self
        imagePicker.sourceType = .camera    // .photoLibrary
        imagePicker.allowsEditing = false   // if true(should be true in real apps) we can edit, crop (better for ml cz machine learning has to work on less area and a more specific area to figure out what that item is)
    }
    
    // delegate method fromUIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //                      picker is our imagePicker object
        if let userPickedImage = info[.originalImage] as? UIImage {   // The original, uncropped image selected by the user. see goodnotes photo
            imageView.image = userPickedImage   // userPickedImage can be nil if the user canceled without taking any photo
        }
        imagePicker.dismiss(animated: true, completion: nil)    // Dismisses the view controller that was presented modally by the view controller.
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

