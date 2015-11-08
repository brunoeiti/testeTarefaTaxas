//
//  ViewController.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    var lista:Array<AgendamentoTO>?
    var agendamentoManager = AgendamentoManager()
    @IBOutlet weak var tabela: UITableView!
    
    
    //MARK : Funcoes Tabela
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let lista = lista{
            return lista.count
        }else{
            return 0
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AgendamentoCell")!
        
        let dados = lista![indexPath.row]
        
        let lblTipo = cell.viewWithTag(1) as! UILabel
        let lblValor = cell.viewWithTag(2) as! UILabel
        let lblTaxa = cell.viewWithTag(3) as! UILabel
        let lblData = cell.viewWithTag(4) as! UILabel
        
        lblTipo.text = dados.tipo?.getString()
        lblValor.text = dados.valor?.getMonetarioString()
        lblTaxa.text = agendamentoManager.calcularTaxa(dados).getMonetarioString()
        lblData.text = dados.data?.getString("dd/MM/yyyy")
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tela = self.storyboard?.instantiateViewControllerWithIdentifier("Detalhes")     as! DetalhesViewController
        tela.agendamento = lista![indexPath.row]
    
        self.navigationController?.pushViewController(tela, animated: true)
    }

    //Mark: Metodos ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        lista = agendamentoManager.listaAgendamentos()
        tabela.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

