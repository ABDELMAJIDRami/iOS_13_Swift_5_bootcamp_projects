//
//  ViewController.swift
//  S24-WhatFlower
//
//  Created by Rami ABDEL MAJID on 12/29/20.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // let userPickerImage = info[.originalImage]  // we can pic the original non-edited image
        let userPickerImage = info[.editedImage]    // the edited image when we flagged imagePicker.allowsEditing = true
        
        imageView.image = userPickerImage as? UIImage
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
        
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

