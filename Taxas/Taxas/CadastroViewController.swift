//
//  CadstroViewController.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController, UITextFieldDelegate {

    //MARK: Elementos da tela
    @IBOutlet weak var txtContaOrigem: VMaskTextField!
    
    @IBOutlet weak var txtContaDestino: VMaskTextField!
    
    @IBOutlet weak var txtValor: UITextField!
    
    @IBOutlet weak var txtDataAgendamento: UITextField!
    
    @IBOutlet weak var segTipo: UISegmentedControl!
    
    @IBOutlet weak var lblTaxa: UILabel!
    
    
    private let datePicker = UIDatePicker()
    
    //MARK: Elementos negocios
    
    var agendamentoManager = AgendamentoManager()
    

    //MARK: Eventos interface
    
    @IBAction func mudaTipo(sender: AnyObject) {
        atualizaTaxa()
        for  v in self.view.subviews{
            v.resignFirstResponder()
        }
    }
    
    func atualizaTaxa(){
        let valor = agendamentoManager.calcularTaxa(montaAgendamento())
        if let strValor = valor.getMonetarioString(){
            lblTaxa.text = "Taxa: R$ \(strValor)"
        }else{
            lblTaxa.text = "---"
        }
    }
    func salvar(){
        let resultado =  agendamentoManager.salvarAgendamento(montaAgendamento())
        if let resultado = resultado{
            UIAlertView(title: "Erro", message: resultado, delegate: self, cancelButtonTitle: "OK").show()
        }else{
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    //avança para a proxima caixa de texto (efeito tab)
    func proximo(){
        if txtContaOrigem.isFirstResponder(){
            txtContaDestino.becomeFirstResponder()
        }else if txtContaDestino.isFirstResponder(){
            txtValor.becomeFirstResponder()
        }else if txtValor.isFirstResponder(){
            txtDataAgendamento.becomeFirstResponder()
        }else{
            txtDataAgendamento.resignFirstResponder()
        }
    }
    func mudaData(){
        txtDataAgendamento.text = datePicker.date.getString("dd/MM/yyyy")
        atualizaTaxa()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.4, animations: {
            textField.alpha = 1
        })
    }
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(0.4, animations: {
            textField.alpha = 0.5
        })
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField==txtContaOrigem || textField==txtContaDestino{
            //aplico a mascara de conta
            let txt = textField as! VMaskTextField
            return txt.shouldChangeCharactersInRange(range, replacementString: string)
        }else if textField==txtValor{
            atualizaTaxa()
        }
        return true
    }

    
    //MARK: Funcoes ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .Bordered, target: self, action: "salvar")
        
        datePicker.datePickerMode = .Date
        
        txtDataAgendamento.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let btn = UIBarButtonItem(title: "Proximo", style: .Bordered, target: self, action: "proximo")
        toolbar.items = [btn]
        txtDataAgendamento.inputAccessoryView = toolbar
        txtContaDestino.inputAccessoryView = toolbar
        txtContaOrigem.inputAccessoryView = toolbar
        txtValor.inputAccessoryView = toolbar
        
        datePicker.addTarget(self, action: "mudaData", forControlEvents: .ValueChanged)
        datePicker.minimumDate = NSDate()
        
        //inicio com uma data padrão na tela
        datePicker.date = NSDate()
        mudaData()
        
        //Mascaras de conta
        txtContaDestino.mask = "#####-#"
        txtContaOrigem.mask = "#####-#"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for  v in self.view.subviews{
            v.resignFirstResponder()
        }
    }
    //MARK: Funcoes internas
    private func montaAgendamento() ->AgendamentoTO{
        let a = AgendamentoTO()
        a.tipo = AgendamentoTipo(rawValue:segTipo.selectedSegmentIndex)
        a.data = datePicker.date
        a.contaOrigem = txtContaOrigem.text
        a.contaDestino = txtContaDestino.text
        a.valor = NSDecimalNumber(string: txtValor.text)
        return a
    }

}
