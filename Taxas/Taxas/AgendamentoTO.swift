//
//  AgendamentoTO.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import Foundation

enum AgendamentoTipo{
    case A
    case B
    case C
    case D
}
class AgendamentoTO: NSObject {
    
    var data:NSDate?
    var contaDestino:String?
    var contaOrigem:String?
    var valor:NSDecimalNumber?
    var tipo:AgendamentoTipo?

}
