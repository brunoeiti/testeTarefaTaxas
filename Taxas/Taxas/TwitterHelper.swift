//
//  TwitterHelper.swift
//  Taxas
//
//  Created by Bruno on 11/8/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import UIKit

class TwitterHelper: NSObject, FHSTwitterEngineAccessTokenDelegate {
    
    override init() {
        super.init()
        FHSTwitterEngine.sharedEngine().permanentlySetConsumerKey("cozsMe9hEZ0fZoKp21W3A", andSecret: "3tRRWwwiSvQffjAte2oL7fqyPtIPGpdGk8wiBec5f0")
        FHSTwitterEngine.sharedEngine().delegate = self
        FHSTwitterEngine.sharedEngine().loadAccessToken()
    }
    
    func postTweet(msg:String){
        if FHSTwitterEngine.sharedEngine().authenticatedID==nil{
            let loginController = FHSTwitterEngine.sharedEngine().loginControllerWithCompletionHandler { (Bool success) -> Void in
                
                let r = self.enviaPost(msg)
                if r==nil{
                    //TODO: TIRAR ALerta daqui e mandar para o ViewController

                    UIAlertView(title: "Twitter", message: "Tweet enviado", delegate: nil, cancelButtonTitle: "OK").show()
                }else{
                    //TODO: TIRAR ALerta daqui e mandar para o ViewController
                    UIAlertView(title: "Erro", message: "Falha do enviar tweet", delegate: nil, cancelButtonTitle: "OK").show()
                }
               
            }
            let tela = UIApplication.sharedApplication().keyWindow!.rootViewController
            tela!.presentViewController(loginController, animated: true, completion: nil)
        }else{
            let r = self.enviaPost(msg)
            if r==nil{
                //TODO: TIRAR ALerta daqui e mandar para o ViewController
                
                UIAlertView(title: "Twitter", message: "Tweet enviado", delegate: nil, cancelButtonTitle: "OK").show()
            }else{
                //TODO: TIRAR ALerta daqui e mandar para o ViewController
                UIAlertView(title: "Erro", message: "Falha do enviar tweet", delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
    }
    private func enviaPost(msg:String)->NSError?{
        return FHSTwitterEngine.sharedEngine().postTweet(msg)
    }
    
    
    //MARK:FHSTwitterEngineAccessTokenDelegate
    func storeAccessToken(accessToken: String!) {
        NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "SavedAccessHTTPBody")
    }
    
    func loadAccessToken() -> String? {
        if let outputStr = NSUserDefaults.standardUserDefaults().objectForKey("SavedAccessHTTPBody") as? String{
            return outputStr
        }
        return nil
    }


}
