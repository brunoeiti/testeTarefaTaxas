//
//  AgendamentoTO.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import Foundation

enum AgendamentoTipo:Int{
    case A = 0
    case B = 1
    case C = 2
    case D = 3
    func getString()->String{
        switch self{
        case .A:
            return "A"
        case .B:
            return "B"
        case .C:
            return "C"
        default:
            return "D"
        }
    }
}
class AgendamentoTO: NSObject {
    
    var data:NSDate?
    var contaDestino:String?
    var contaOrigem:String?
    var valor:NSDecimalNumber?
    var tipo:AgendamentoTipo?

}
