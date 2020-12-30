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
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wikiLabel: UILabel!
    
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
            // imageView.image = userPickerImage
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
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"    // pageimage size: 500 * 500
        ]
        // .responseJSON accpets a closure
        AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            // print(response)
            print(JSON(try! response.result.get()))
            do {
                let flowerJson = JSON(try response.result.get())
                let pageID = flowerJson["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJson["query"]["pages"][pageID]["extract"].stringValue
                let flowerImageURL = flowerJson["query"]["pages"][pageID]["thumbnail"]["source"].stringValue
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
                self.wikiLabel.text = flowerDescription
            } catch {
                print("Failed to get data from wikipedia, \(error)")
            }
            
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

