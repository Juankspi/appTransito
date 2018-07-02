//
//  NearHospitalsViewController.swift
//  Transito
//
//  Created by Andres Ramírez on 29/06/18.
//  Copyright © 2018 JuanEspinosa. All rights reserved.
//

import UIKit

class NearHospitalsViewController: UIViewController {

    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var lblHos1: UILabel!
    @IBOutlet weak var lblHos2: UILabel!
    @IBOutlet weak var lblHos3: UILabel!
    @IBAction func btnHosp(_ sender: Any) {
        
        let Id : String = txtID.text!
        let encId = Id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let path = "http://accidentes.herokuapp.com"
        let query = "/accidentes/\(encId)/hospitales"
        
        txtID.resignFirstResponder()
        
        if let url : URL = URL(string: "\(path)\(query)") {
            URLSession.shared.dataTask(with: url) { (data,url,error) in
                print("\(path)\(query)")
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                    
                    
                    //let hospi : Hospital = try decoder.decode(Hospital.self, from: data!)
                    
                    DispatchQueue.main.async {
                        print("\(json[0])")

                        
                        if let nombres = json[0] as? NSDictionary {
                            if let h1 = nombres["nombre"] {
                                self.lblHos1.text = "\(h1)"
                            }
                        }
                        
                        if let nombres2 = json[1] as? NSDictionary {
                            if let h2 = nombres2["nombre"] {
                                self.lblHos2.text = "\(h2)"
                            }
                        }
                        
                        if let nombres3 = json[2] as? NSDictionary {
                            if let h3 = nombres3["nombre"] {
                                self.lblHos3.text = "\(h3)"
                            }
                        }
                        
                    }
                }catch{
                    
                }
                
                
                }.resume()
        }
        lblHos1.text = ""
        lblHos2.text = ""
        lblHos3.text = ""
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
