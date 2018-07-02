//
//  DeleteHospitalViewController.swift
//  Transito
//
//  Created by Andres Ramírez on 1/07/18.
//  Copyright © 2018 JuanEspinosa. All rights reserved.
//

import UIKit

class DeleteHospitalViewController: UIViewController {
    
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var lblResultado: UILabel!
    
    
    @IBAction func EliminarHospital(_ sender: AnyObject) {
        
        let Id : String = txtID.text!
        let encId = Id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let path = "http://accidentes.herokuapp.com"
        let query = "/hospitales/\(encId)/"
        
        txtID.resignFirstResponder()
        
        guard let url = URL(string: "\(path)\(query)") else {
            print("Error creating URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler : {
            (data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async { // Correct
                self.lblResultado.text = "Hospital Eliminado"
            }
            
            if error == nil {
                return
            }
            
            print("Error:")
            print(error!)
            print("response:")
            print(response!)
            print("Data:")
            print(String(data: data!, encoding: String.Encoding.utf8)!)
        })
        
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
