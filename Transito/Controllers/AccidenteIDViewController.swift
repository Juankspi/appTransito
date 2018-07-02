//
//  AccidenteIDViewController.swift
//  Transito
//
//  Created by Prog on 23/06/18.
//  Copyright © 2018 JuanEspinosa. All rights reserved.
//

import UIKit

class AccidenteIDViewController: UIViewController {
    
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var lblTipo: UILabel!
    @IBOutlet weak var lblPrioridad: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBAction func btnConsultAcc(_ sender: Any) {
        
        let Id : String = txtID.text!
        let encId = Id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let path = "http://accidentes.herokuapp.com"
        let query = "/accidentes/\(encId)/"
        
        txtID.resignFirstResponder()
        
        if let url : URL = URL(string: "\(path)\(query)") {
            URLSession.shared.dataTask(with: url) { (data,url,error) in
                print("\(path)\(query)")
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let root : Root = try decoder.decode(Root.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.lblTipo.text = "\(root.tipo)"
                        self.lblPrioridad.text = "\(root.prioridad)"
                        self.lblEstado.text = "\(root.estado)"
                        self.lblFecha.text = "\(root.fecha)"
                    }
                }catch{
                    
                }
                
                
                }.resume()
        }
        lblTipo.text = ""
        lblPrioridad.text = ""
        lblEstado.text = ""
        lblFecha.text = ""
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
