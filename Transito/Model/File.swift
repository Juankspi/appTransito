//
//  File.swift
//  Transito
//
//  Created by Prog on 23/06/18.
//  Copyright © 2018 JuanEspinosa. All rights reserved.
//

import Foundation

struct Locate : Codable {
    let coordinates: [Double]
    let type : String
}

struct Root : Codable {
    let tipo: String
    let prioridad : String
    let estado : String
    let fecha : String
    let location: Locate
}

struct Hospital : Codable {
    let nombre : String
    let direccion : String
    let webpage : String
    let telefono : String
    let location: Locate
}

