//
//  EditViewController.swift
//  Transito
//
//  Created by Prog on 23/06/18.
//  Copyright © 2018 JuanEspinosa. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtTipo: UITextField!
    @IBOutlet weak var txtPrioridad: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var lblRespuesta: UILabel!
    
    //---------------------------------Primer Boton
    
    @IBAction func btnTraer(_ sender: Any) {
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
                        self.txtTipo.text = "\(root.tipo)"
                        self.txtPrioridad.text = "\(root.prioridad)"
                        self.txtEstado.text = "\(root.estado)"
                        self.txtFecha.text = "\(root.fecha)"
                    }
                }catch{
                    
                }
                
                
                }.resume()
        }
        txtTipo.text = ""
        txtPrioridad.text = ""
        txtEstado.text = ""
        txtFecha.text = ""
        
    }
    
    //---------------------------------Segundo Boton
    
    @IBAction func btnEdit(_ sender: Any) {
        let Id : String = txtID.text!
        let tip : String = txtTipo.text!
        let priori : String = txtPrioridad.text!
        let estad : String = txtEstado.text!
        let fech : String = txtFecha.text!
        
        let encId = Id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let path = "http://accidentes.herokuapp.com"
        let query = "/accidentes/\(encId)/"
        
        txtID.resignFirstResponder()
        txtTipo.resignFirstResponder()
        txtPrioridad.resignFirstResponder()
        txtEstado.resignFirstResponder()
        txtFecha.resignFirstResponder()
        
        
        let ubicacion = Locate(
            coordinates: [-75.48482894897461,5.0608930028632475],
            type: "Point"
        )
    
        let root = Root(
            tipo: tip,
            prioridad : priori,
            estado : estad,
            fecha : fech,
            location: ubicacion
        )
        
        guard let editData = try? JSONEncoder().encode(root) else {
            return
        }
        
        
        if let url : URL = URL(string: "\(path)\(query)") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.uploadTask(with: request, from: editData) { (data,response,error) in
                do {
                    if let error = error {
                        print("error:\(error)")
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                            print("Server Error")
                            return
                    }
                    
                    if let mimeType = response.mimeType,
                        mimeType == "application/json",
                        let data = data,
                        let dataString = String(data:data, encoding: .utf8){
                        print ("got data: \(dataString)")
                    }
                    
                    DispatchQueue.main.async {
                        self.lblRespuesta.text = "Editado"
                    }
                }
                
                
                }.resume()
        }
        txtTipo.text = ""
        txtPrioridad.text = ""
        txtEstado.text = ""
        txtFecha.text = ""
        
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
