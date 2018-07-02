//
//  HospitalViewController.swift
//  Transito
//
//  Created by Andres Ramírez on 1/07/18.
//  Copyright © 2018 JuanEspinosa. All rights reserved.
//

import UIKit

class HospitalViewController: UIViewController {
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblWebpage: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var txtIDHospital: UITextField!
    
    @IBAction func getHospital(_ sender: Any) {
        let id_hospital: String = txtIDHospital.text!
        let encId = id_hospital.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let path = "http://accidentes.herokuapp.com"
        let query = "/hospitales/\(encId)"
        
        txtIDHospital.resignFirstResponder()
        
        if let url : URL = URL(string: "\(path)\(query)") {
            URLSession.shared.dataTask(with: url) { (data,url,error) in
                print("\(path)\(query)")
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let hospi : Hospital = try decoder.decode(Hospital.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.lblNombre.text = "\(hospi.nombre)"
                        self.lblDireccion.text = "\(hospi.direccion)"
                        self.lblWebpage.text = "\(hospi.webpage)"
                        self.lblTelefono.text = "\(hospi.telefono)"
                        
                        
                    }
                }catch{
                    print(error)
                }
                
                
                }.resume()
            
        }
        lblNombre.text = ""
        lblDireccion.text = ""
        lblWebpage.text = ""
        lblTelefono.text = ""
        
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
