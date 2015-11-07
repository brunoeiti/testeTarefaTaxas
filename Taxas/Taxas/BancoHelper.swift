//
//  BancoHelper.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import Foundation

class BancoHelper: NSObject {
    
    //TODO: Salvar em banco???
    private static var lista =  Array<AgendamentoTO>()
    
    static func listarAgendamentos()->[AgendamentoTO]{
        return lista;
    }
    static func salvarAgendamento(item:AgendamentoTO){
        lista.append(item)
    }

}
