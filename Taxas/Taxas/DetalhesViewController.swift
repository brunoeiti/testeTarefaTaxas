//
//  DetalhesViewController.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var lblTipo: UILabel!
    
    @IBOutlet weak var lblValor: UILabel!
    
    @IBOutlet weak var lblTaxa: UILabel!
    
    @IBOutlet weak var lblData: UILabel!
    
    @IBOutlet weak var lblContas: UILabel!
    
    var agendamento:AgendamentoTO?
    let agMan = AgendamentoManager()
    var postado = false

    @IBAction func compartilharTwitter(sender: AnyObject) {
        if postado{
            UIAlertView(title: "Erro", message: "Esse agendamento já foi postado.", delegate: nil, cancelButtonTitle: "OK").show()
            return;
        }
        
        if let agendamento = agendamento{

            let th = TwitterHelper()
            th.postTweet("Agendei R$\(agendamento.valor!.getMonetarioString()!) para transferir em \(agendamento.data!.getString("dd/MM/yyyy")) da conta \(agendamento.contaOrigem!) para \(agendamento.contaDestino!) pelo tipo \(agendamento.tipo!.getString())")
            postado = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let agendamento = agendamento{
            
            lblTipo.text = agendamento.tipo?.getString()
            lblValor.text = agendamento.valor?.getMonetarioString()
            lblTaxa.text = agMan.calcularTaxa(agendamento).getMonetarioString()
            lblData.text = agendamento.data?.getString("dd/MM/yyyy")
            lblContas.text = "\(agendamento.contaOrigem!) -> \(agendamento.contaDestino!)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
