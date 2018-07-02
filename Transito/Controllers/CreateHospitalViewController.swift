//
//  CreateHospitalViewController.swift
//  Transito
//
//  Created by Andres Ramírez on 1/07/18.
//  Copyright © 2018 JuanEspinosa. All rights reserved.
//

import UIKit

class CreateHospitalViewController: UIViewController {
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtWebpage: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var lblEstado: UILabel!
    
    @IBAction func createHospital(_ sender: Any) {
        let loc = Locate(coordinates: [-75.5149018764496,
                                         5.06865172541408], type: "Point")
        let hospital = Hospital(
            nombre: txtNombre.text!,
            direccion: txtDireccion.text!,
            webpage:  txtWebpage.text!,
            telefono: txtTelefono.text!,
            location: loc)
        
        let path = "http://accidentes.herokuapp.com/"
        let query = "hospitales/"
        let req_url = "\(path)\(query)"
        print(req_url)
        
        guard let uploadData = try? JSONEncoder().encode(hospital) else {
            return
        }
        
        let url = URL(string: req_url)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        self.lblEstado.text = "Error"
                    }
                    return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
            
            DispatchQueue.main.async {
                self.lblEstado.text = "Creado correctamente"
            }
        }
        task.resume()
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
