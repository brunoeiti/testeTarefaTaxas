//
//  CadstroViewController.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import UIKit

class CadstroViewController: UIViewController {

    @IBOutlet weak var txtContaOrigem: UITextField!
    
    @IBOutlet weak var txtContaDestino: UITextField!
    
    @IBOutlet weak var txtValor: UITextField!
    
    @IBOutlet weak var txtDataAgendamento: UITextField!
    
    @IBOutlet weak var segTipo: UISegmentedControl!
    
    @IBOutlet weak var lblTaxa: UILabel!
    
    @IBOutlet weak var lblValorTaxa: UILabel!
    
    private let datePicker = UIDatePicker()
    
    @IBAction func mudaTipo(sender: AnyObject) {
    }
    
    
    func salvar(){
        
    }
    
    func fecharData(){
        txtDataAgendamento.resignFirstResponder()
    }
    func mudaData(){
        txtDataAgendamento.text = datePicker.date.getString("dd/MM/yyyy")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .Bordered, target: self, action: "salvar")
        
        datePicker.datePickerMode = .Date
        
        txtDataAgendamento.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let btn = UIBarButtonItem(title: "Fechar", style: .Bordered, target: self, action: "fecharData")
        toolbar.items = [btn]
        txtDataAgendamento.inputAccessoryView = toolbar
        txtDataAgendamento.addTarget(self, action: "mudaData", forControlEvents: .ValueChanged)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for var v in self.view.subviews{
            v.resignFirstResponder()
        }
    }

}
