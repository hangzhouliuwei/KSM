//
//  PKCertificationPhotoItemHelper.swift
//  PHPesoKey
//
//  Created by hao on 2025/2/14.
//

import AVFoundation

class PKPhotoConfigData {
    var pkTypeItemDataArray = [JSON]()
    var pkResourceUrl = ""
    var pkTypeSelectedId = ""
    var pkResourceId = ""
    var pkResourceImage = UIImage()
}


typealias PKImageBlock = (_ result: Any) -> Void

class ImageSourceSelectorPage: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static func pkUserChooseSource(finish: @escaping PKImageBlock) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = shard
        imagePicker.allowsEditing = false
        
        shard.chooseResourceBlock = finish
        shard.sourceSelector = imagePicker
        
        shard.toDisplaySourcePage()
    }
    
    private static let shard = ImageSourceSelectorPage()
    
    private var chooseResourceBlock: PKImageBlock?
    private var sourceSelector: UIImagePickerController?
    
    func checkIDentityCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        case .denied:
            completion(false)
            
        case .restricted:
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    
    func displayPKUserSetPageController() {
        let alert = UIAlertController(title: nil, message: "Camera permis" + "sions not granted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go to " + "Settings", style: .default, handler: { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))

        modelStyleControllerAlert(alert)
    }
    
    func toDisplaySourcePage() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "camera", style: .default) { _ in
            self.checkIDentityCameraPermission(completion: { [weak self] res in
                if res {
                    DispatchQueue.main.async {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            self!.sourceSelector?.sourceType = .camera
                            self!.modelStyleControllerAlert(self!.sourceSelector!)
                        }
                    }
                    
                }else {
                    self?.displayPKUserSetPageController()
                }
            })
        }
        actionSheet.addAction(cameraAction)

        
        let photoAction = UIAlertAction(title: "photo", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self!.sourceSelector?.sourceType = .photoLibrary
                self!.modelStyleControllerAlert(self!.sourceSelector!)
            }
        }
        actionSheet.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        modelStyleControllerAlert(actionSheet)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            chooseResourceBlock?(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func modelStyleControllerAlert(_ vc:UIViewController) {
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(vc, animated: true, completion: nil)
        }
    }
}
