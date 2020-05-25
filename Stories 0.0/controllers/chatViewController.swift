//
//  chatViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 23/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import MobileCoreServices
import AVFoundation

class chatViewController: UIViewController {
    
    
    @IBOutlet weak var mediabtn: UIButton!
    
    @IBOutlet weak var audiobtn: UIButton!
    
    @IBOutlet weak var inputtextview: UITextView!
    
    @IBOutlet weak var sendbtn: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    var chatpartner: UIImage!
    var avtarimageview: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    var toplabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var partnerusername: String!
    var partneruserid: String!
    var placeholderlabel = UILabel()
    
    

    var picker = UIImagePickerController()
    var messagess = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupnavigationbar()
        setuptableview()
        setupplaceholder()
        setuppicker()
        observeMessages()
        // Do any additional setup after loading the view.
    }
    
    
    func observeMessages(){
        Api.Message.recievedMessages(from: Api.User.currentuserid, to: partneruserid) { (message) in
            print(message.id)
            self.messagess.append(message)
            self.sortMessages()
        }
        
        Api.Message.recievedMessages(from: partneruserid, to: Api.User.currentuserid) { (message) in
                  print(message.id)
            self.messagess.append(message)
            self.sortMessages()

            
              }
    }
    
    func sortMessages(){
        messagess = messagess.sorted(by: { $0.date < $1.date})
        
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        
    }
    
    func setuppicker(){
        picker.delegate = self
    }
    
    func setupplaceholder(){
        
        inputtextview.delegate = self
        placeholderlabel.isHidden = false
        
        let placeholderX: CGFloat = self.view.frame.size.width / 75
        let placeholderY: CGFloat =  0
        let placeholderwidth: CGFloat = inputtextview.bounds.width - placeholderX
        
        let placeholderheight: CGFloat = inputtextview.bounds.height
        let placeholderfontsize = self.view.frame.size.width / 25
        
        placeholderlabel.frame = CGRect(x: placeholderX, y: placeholderY, width: placeholderwidth, height: placeholderheight)

        placeholderlabel.text = "Write a message"
        placeholderlabel.font = UIFont(name: "HelveticaNeue", size: placeholderfontsize)
        placeholderlabel.textColor = .lightGray
        placeholderlabel.textAlignment = .left
        inputtextview.addSubview(placeholderlabel)
        
        
    }
    
    
    func setupnavigationbar(){
        
        navigationItem.largeTitleDisplayMode = .never
        let containview = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        avtarimageview.image = chatpartner
        avtarimageview.contentMode = .scaleAspectFill
        avtarimageview.layer.cornerRadius = 18
        avtarimageview.clipsToBounds = true
        containview.addSubview(avtarimageview)
        
        let rightbarbutton = UIBarButtonItem(customView: containview)
        self.navigationItem.rightBarButtonItem = rightbarbutton
        
        toplabel.textAlignment = .center
        toplabel.numberOfLines = 0
        
        let attributed = NSMutableAttributedString(string: partnerusername  +  "\n"  , attributes: [.foregroundColor:UIColor.black,  .font : UIFont.systemFont(ofSize: 17) ])
        
        attributed.append(NSAttributedString(string: "Active", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)  , NSAttributedString.Key.foregroundColor: UIColor.green]))
        
        toplabel.attributedText = attributed
        
        self.navigationItem.titleView = toplabel
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false

    }
    
    func  setuptableview(){
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.tableFooterView = UIView()
    }
    
    
    
    @IBAction func snd_btn(_ sender: Any) {
        if let text = inputtextview.text, text != ""{
            inputtextview.text = ""
            self.textViewDidChange(inputtextview)
            sendtoFirebase(dict: ["text": text as Any])
        }
        
        
    }
    
    
    @IBAction func mediabtn_clicked(_ sender: Any) {
        inputtextview.text = ""
        let alert  = UIAlertController(title: "Stories", message: "select source", preferredStyle: UIAlertController.Style.actionSheet)
        let camera = UIAlertAction(title: "take a picture", style: UIAlertAction.Style.default) { (_) in
            
            if
                UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
                
            }else{
                print("UNavailable")
            }
            
        }
        
        let library = UIAlertAction(title: "choose a picture or video", style: UIAlertAction.Style.default) { (_) in
                 
                 if
                    UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                    self.picker.sourceType = .photoLibrary
                    self.picker.mediaTypes = [String(kUTTypeMovie), String(kUTTypeImage)]

                     self.present(self.picker, animated: true, completion: nil)
                     
                 }else{
                     print("UNavailable")
                 }
                 
             }
        
        let videocamera = UIAlertAction(title: "Take a video", style: UIAlertAction.Style.default) { (_) in
                             if
               UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = [String(kUTTypeMovie)]
                                self.picker.videoExportPreset = AVAssetExportPresetPassthrough
                                self.picker.videoMaximumDuration = 30
                self.present(self.picker, animated: true, completion: nil)
                
            }else{
                print("UNavailable")
            }

        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        alert.addAction(videocamera)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func audiobtnclicked(_ sender: Any) {
        
        
    }
    
    func sendtoFirebase(dict: Dictionary<String, Any>){
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["fom"] = Api.User.currentuserid
        value["to"] = partneruserid
        value["date"] = date
        value["read"] = true
        
        Api.Message.sendMessage(from: Api.User.currentuserid, to: partneruserid, value: value)

        
    }
    
    
    
}
extension chatViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty{
            let text = textView.text.trimmingCharacters(in: spacing)
            print(text)
            sendbtn.isEnabled = true
            sendbtn.setTitleColor(.black, for: .normal)
            placeholderlabel.isHidden = true
        }else{
            sendbtn.isEnabled = false
            sendbtn.setTitleColor(.lightGray, for: .normal)
            placeholderlabel.isHidden = false

            
        }
    }
}
extension chatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL{

            handleVideoSelectedUrl(videoUrl)
            
        }else{
            handleimageselectedforinfo(info)
            
        }
    }
    
    func handleVideoSelectedUrl(_ url: URL){
        // save video to database
        print(url)
        let videoname = NSUUID().uuidString

        StorgaeService.savevideoomessage(url: url, id: videoname, onSucess: { (anyValue) in
                        if let dict = anyValue  as?  [String : Any]{
           
                            self.sendtoFirebase(dict: dict)
            }

        }) { (errorMessage) in
            
        }
        self.picker.dismiss(animated: true, completion: nil)

        
    }
    
    func handleimageselectedforinfo(_ info: [UIImagePickerController.InfoKey : Any]){
        
        var selectedimagfrompicker: UIImage?
        
        if let imagselected = info[UIImagePickerController.InfoKey.editedImage] as?  UIImage{
            selectedimagfrompicker = imagselected
        }
        
        if let originalimag = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedimagfrompicker = originalimag
        }
        
        // save image to database
        let imagname = NSUUID().uuidString
        StorgaeService.savephotomessage(image: selectedimagfrompicker, id: imagname, onSucess: { (anyvalue) in
            if let dict = anyvalue as? [String: Any]{
                self.sendtoFirebase(dict: dict)
            }
        }) { (errorMessage) in
            
        }
        self.picker.dismiss(animated: true, completion: nil)
        
    }
    
    
}
extension chatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagess.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as!  MessageTableViewCell
        cell.playbutton.isHidden = true
        cell.configurecell(uid: Api.User.currentuserid, message: messagess[indexPath.row], image: chatpartner)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        let messeag = messagess[indexPath.row]
        let text =  messeag.text
        if !text.isEmpty{
            height = text.estimateframefortext(text).height  +  60
        }
        
        let heightmessage = messeag.height
        let widthmesage = messeag.width
        if heightmessage  != 0 , widthmesage != 0 {
            height = CGFloat(heightmessage /  widthmesage * 250)
        }
        return height
        
    }
    
}
