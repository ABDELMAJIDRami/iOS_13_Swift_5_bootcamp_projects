//
//  ViewController.swift
//  S24-WhatFlower
//
//  Created by Rami ABDEL MAJID on 12/29/20.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // let userPickerImage = info[.originalImage] as? UIImage   // we can pic the original non-edited image
        
        if let userPickerImage = info[.editedImage] as? UIImage {  // the edited image when we flagged imagePicker.allowsEditing = true
            guard let ciImage = CIImage(image: userPickerImage) else {fatalError("cannot convert image")}
            detect(image: ciImage)
            imageView.image = userPickerImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            let classification = request.results?.first as? VNClassificationObservation
            // in case classification is nil -> didn't detect the flower -> we can show any message/alert/... to the user, So i won't do guard let as Angela did.
            
            self.navigationItem.title = classification?.identifier.capitalized
            
            self.requestInfo(flowerName: classification!.identifier)    // will throw if classification is nil
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    func requestInfo(flowerName: String) {
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
        ]
        // .responseJSON accpets a closure
        AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            print(response)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

