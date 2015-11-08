//
//  AgendamentoManager.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import Foundation

class AgendamentoManager: NSObject {

    
    func calcularTaxa(transf:AgendamentoTO)->NSDecimalNumber{
        //evitar travamento em tentativas de calculos sem valor
        if transf.valor==nil || transf.valor == NSDecimalNumber.notANumber(){
            return 0
        }
        
        switch transf.tipo!{
        case .A:
            return calculaTaxaA(transf.valor!)
        case .B:
            return calculaTaxaB(transf.valor!, data: transf.data!)
        case .C:
            return calculaTaxaC(transf.valor!, data: transf.data!)
        case .D:
            return calculaTaxaD(transf.valor!, data: transf.data!)
        }
    }
    func salvarAgendamento(transf:AgendamentoTO)->String?{
        let difDias = NSDate().dateDiff(transf.data!, unidade: .Day).day
        if difDias<0{
            return "Data inválida"
        }
        if transf.valor==nil || transf.valor==NSDecimalNumber.notANumber(){
            return "Valor inválido"
        }
        
        BancoHelper.salvarAgendamento(transf)
        
        return nil
    }
    func listaAgendamentos()->[AgendamentoTO]{
        return BancoHelper.listarAgendamentos()
    }
    
    //MARK: Funcoes de calculo Taxa
    private func calculaTaxaA(valor:NSDecimalNumber)->NSDecimalNumber{
        return 3 + 0.03 * valor
    }
    private func calculaTaxaB(valor:NSDecimalNumber,data:NSDate)->NSDecimalNumber{
        let difDias = NSDate().dateDiff(data, unidade: .Day).day
        if difDias>30{
            return 10
        }else{
            return 8
        }
    }
    private func calculaTaxaC(valor:NSDecimalNumber,data:NSDate)->NSDecimalNumber{
        let difDias = NSDate().dateDiff(data, unidade: .Day).day
        if difDias<=5{
            return valor * 0.083
        }else if difDias <= 10 {
            return valor * 0.074
        }else if difDias <= 15 {
            return valor * 0.067
        }else if difDias <= 20 {
            return valor * 0.054
        }else if difDias <= 25 {
            return valor * 0.043
        }else if difDias <= 30 {
            return valor * 0.021
        }else{
            return valor * 0.012
        }
    
    }
    private func calculaTaxaD(valor:NSDecimalNumber,data:NSDate)->NSDecimalNumber{
        if valor<=25000{
            return calculaTaxaA(valor)
        }else if valor <= 120000{
            return calculaTaxaB(valor, data: data)
        }else{
            return calculaTaxaC(valor, data: data)
        }
    }
}
