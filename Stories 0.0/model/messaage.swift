//
//  messaage.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 10/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
class Message {
    var id : String
    var from : String

    var to : String

    var date : Double
    var imageurl : String
    var height: Double
    var width: Double
    var text : String

    init(id: String, from: String, to: String, date: Double, imageurl: String, height: Double,width: Double, text: String){
        self.id = id
        self.from = from
        self.to = to
        self.date = date
        self.imageurl = imageurl

        self.height = height
        self.width = width
        self.text = text
    }
    
    static func transformMessage(dict: [String: Any], keyid: String)  ->Message?{
           guard
            let from = dict["fom"] as? String,
            let to = dict["to"] as? String,
            let date = dict["date"] as? Double else{
                   return nil
           }
        
        let text = (dict["text"] as? String)  == nil  ? "" : (dict["text"]!  as! String)
        let imagurl = (dict["imagurl"] as? String)  == nil  ? "" : (dict["imagurl"]!  as! String)
        let height = (dict["height"] as? Double)  == nil  ?  0 : (dict["height"]!  as! Double)
        let width = (dict["width"] as? Double)  == nil  ?  0 : (dict["width"]!  as! Double)
       


        let message = Message(id: keyid, from: from, to: to, date: date, imageurl: imagurl, height:height , width: width, text: text)
        return message
       }
    
}
