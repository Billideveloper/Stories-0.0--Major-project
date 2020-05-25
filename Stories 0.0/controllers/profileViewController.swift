//
//  profileViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class profileViewController: UIViewController ,UITableViewDataSource{
   
    let db = Firestore.firestore()

    @IBOutlet weak var tableviewprofile: UITableView!
    
    var pdatamodels: [pdatamodel] = [
    ]
    
    override func viewDidLoad() {
      
      
        super.viewDidLoad()
          tableviewprofile.dataSource = self
        tableviewprofile.register(UINib(nibName: "profileTableViewCell", bundle: nil), forCellReuseIdentifier: "pcell")

        // Do any additional setup after loading the view.
        
        loadp()
    }
    
    
    func loadp(){
        db.collection(S.FStore.collectionName).getDocuments { (query, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                
                if let snapsdocs = query?.documents{
                    
                    for  doc in snapsdocs{
                        print(doc.data())
                        
                        
                        let data = doc.data()
                        
                        if let titles = data[S.FStore.Title] as? String, let subtitle = data[S.FStore.subTitle] as? String, let imagurl = data[S.FStore.sImagedownloadurl] as? String{
                            
                            let newim = pdatamodel(pstorytitle: titles, pstorysubtitle: subtitle, pstoryimage: imagurl)
                            
                            self.pdatamodels.append(newim)
                            DispatchQueue.main.async {
                                self.tableviewprofile.reloadData()
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                
            }
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pdatamodels.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tableviewprofile.dequeueReusableCell(withIdentifier: "pcell", for: indexPath) as!  profileTableViewCell
        
        let models = pdatamodels[indexPath.row]
        
        cells.title.text = models.pstorytitle
        cells.subtitle.text = models.pstorysubtitle
        let url = models.pstoryimage
        let myrul = URL(string: url)!
        let sessn = URLSession(configuration: .default)
            
            
       let downloadmyndpic = sessn.dataTask(with: myrul) { (datas, response, error) in
                  if let e = error{
                      print(e.localizedDescription)
                  }else{
                      if let myres = response as? HTTPURLResponse{
                          print(myres)
                          
                          if let simagdata = datas{
                              
                              let simag = UIImage(data: simagdata)
                              DispatchQueue.main.async {
                                cells.pimage.image = simag
                              }
                              
                          }
                      }
                  }
              }
        
        downloadmyndpic.resume()

            
            
            
            
            
            
            
            
            
            
        
        
        
        
        
        return cells
       }

    

}
