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
            
            guard let ciimage = CIImage(image: userPickedImage) else { //  convert this UIImage into a CIImage which stands for Core Image image and that's a special type of image that allow us to use the Vision framework and the CoreML framework in order to get an interpretation from it.
                fatalError("Could not convert UIImage to CIImage.")
            }
            
            detecet(image: ciimage)
            
        }
        imagePicker.dismiss(animated: true, completion: nil)    // Dismisses the view controller that was presented modally by the view controller.
    }
    
    // method that will process CIImage and get interpretation or classification out of it.
    func detecet(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {// A container for a Core ML model used with Vision requests. VNCoreMLModel comes from the vision framework. It allows us to perform an image analysis requests that uses our CoreMLModel to process images.
            fatalError("Loading CoreML Model Failed.")
        }
        
        // let request = VNCoreMLRequest(model: model, completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>) // click to transform to trailing closure.
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
        }
        
        //specify the image we want to classify/process by this request
        let handler = VNImageRequestHandler(ciImage: image)
        
        // try! handler.perform([request])   // try! : forceexecute this request witout wrapping it with do catch - will crash the app if it fails
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }

    }
    

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

