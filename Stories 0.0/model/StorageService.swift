//
//  StorageService.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Firebase
import AVFoundation


class StorgaeService{
    
    static func savephotomessage(image:UIImage?, id: String,  onSucess: @escaping(_  value: Any)  -> Void,onError: @escaping(_  errorMessage: String)  -> Void){
        if let imagphoto = image{
            let Ref = ref().storagespecificImagemessage(id: id)
            if let data = imagphoto.jpegData(compressionQuality: 0.5){
                
                Ref.putData(data, metadata: nil) { (metadata, error) in
                    if  error  != nil {
                        onError(error!.localizedDescription)
                    }
                    Ref.downloadURL { (url, error) in
                        if let metaimagurl = url?.absoluteString{
                            let dict: Dictionary<String,Any> = [
                                "imagurl": metaimagurl as Any,
                                "height": imagphoto.size.height as Any,
                                "width": imagphoto.size.width as Any,
                                "text": "" as Any
                            ]
    
                            onSucess(dict)
    
    
                        }
                        
                    }
                
                }
            }
        }
        
    }
    
    
    static func savevideoomessage(url:URL, id: String,  onSucess: @escaping(_  value: Any)  -> Void, onError: @escaping(_  errorMessage: String)  -> Void) {
            
        let Ref = ref().storagespecificVideomessage(id: id)
        Ref.putFile(from: url, metadata: nil) { (metadata, error) in
              if  error  != nil {
                                  onError(error!.localizedDescription)
                              }
            
                            Ref.downloadURL { (videoUrl, error) in
                                
                                if let thumbnailimage = self.thumbnailimageforfileurl(url){
                                    StorgaeService.savephotomessage(image: thumbnailimage, id: id, onSucess: { (value) in
                                        if let dict = value  as?  Dictionary< String,  Any>{
                                            var dictvalue = dict
                                            
                                            if let videourlstring = videoUrl?.absoluteString{
                                                dictvalue["videoUrl"]  =  videourlstring
                                            }
                                            onSucess(dictvalue)
                                            
                                        }
                                    }) { (errorMessage) in
                                        onError(errorMessage)
                                    }
//                                if let metaimagurl = url?.absoluteString{
//                                    let dict: Dictionary<String,Any> = [
//                                        "imagurl": metaimagurl as Any,
//                                        "height": imagphoto.size.height as Any,
//                                        "width": imagphoto.size.width as Any,
//                                        "text": "" as Any
//                                    ]
            
                                    
            
            
                                }
                                
                            }

        }

        
        
    }
    
    static func thumbnailimageforfileurl(_ url: URL)  -> UIImage? {
        
        
         let assest  = AVAsset(url: url)
        let imagGenerator  = AVAssetImageGenerator(asset: assest)
        imagGenerator.appliesPreferredTrackTransform = true
        var time = assest.duration
        time.value = min(time.value, 2)
        do{
            let imagref = try imagGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imagref)
            
        }catch let error as NSError{
            print(error.localizedDescription)
            return nil
        }
        
    }
    
}
