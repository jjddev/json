//
//  ViewController.swift
//  filmes
//
//  Created by PUCPR on 29/03/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var vPoster: UIImageView!
    @IBOutlet weak var vTitulo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlBase = "https://api.themoviedb.org/3/movie/550?api_key="
        
        let key = "4102490176cb4c40d776cc1d9bf066a9"
        
        
        let url = "\(urlBase)\(key)"
        
        let baseImage = "https://image.tmdb.org/t/p/w500"
        
        
        Alamofire.request(url).responseJSON { (response) in
            //print(response.result.value)
            
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                self.vTitulo.text = json["title"].stringValue
                
                //montar caminho
                let imagePath = "\(baseImage)\(json["poster_path"].stringValue)"
                
                let urlImage = URL(string: imagePath)
                

                DispatchQueue.global().async { [weak self] in
                    if let bytes: Data? = try? Data(contentsOf: urlImage!) {
                        if let imagem = UIImage(data: bytes!) {
                            DispatchQueue.main.async {
                                self!.vPoster.image = imagem
                            }
                        }
                    }
                }
            
            }
}
}
}




