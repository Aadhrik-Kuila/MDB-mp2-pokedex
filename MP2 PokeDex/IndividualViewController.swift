//
//  IndividualViewController.swift
//  MP2 PokeDex
//
//  Created by Aadhrik Kuila on 2/15/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit
import SafariServices

class IndividualViewController: UIViewController {
    
    var typesImage: UIImageView!
    var p: Pokemon!
    var pImage: UIImageView!
    var pName: UILabel!
    var pTotal: UILabel!
    var pNumber: UILabel!
    var pAttack: UILabel!
    var pSpecialAttack: UILabel!
    var pDefense: UILabel!
    var pHealth: UILabel!
    var pSpecialDefense: UILabel!
    var pSpecies: UILabel!
    var pSpeed: UILabel!
    var pTypes: UILabel!
    var types = ["Grass", "Water", "Electric"]
    var typeSentence: String!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pName = UILabel(frame: CGRect(x: 100, y: 110, width: 140, height: 40))
        pName.textColor = .red
        pName.textAlignment = .center
        pName.text = "#\(p.number!) \(p.name!)"
        view.addSubview(pName)
        
        pImage = UIImageView(frame: CGRect(x: 80, y: 260, width: 200, height: 200))
        checkImage()
        view.addSubview(pImage)
        
        pAttack = UILabel(frame: CGRect(x: 30, y: 170, width: 100, height: 20))
        pAttack.textColor = .black
        pAttack.text = "Attack: \(p.attack!)"
        pAttack.textAlignment = .center
        view.addSubview(pAttack)
        
        pDefense = UILabel(frame: CGRect(x: 140, y: 170, width: 100, height: 20))
        pDefense.textColor = .black
        pDefense.textAlignment = .center
        pDefense.text = "Defense: \(p.defense!)"
        view.addSubview(pDefense)
        
        pHealth = UILabel(frame: CGRect(x: 250, y: 170, width: 100, height: 20))
        pHealth.textColor = .black
        pHealth.textAlignment = .center
        pHealth.text = "HP: \(p.health!)"
        view.addSubview(pHealth)
        
        pSpecialAttack = UILabel(frame: CGRect(x: 30, y: 200, width: 100, height: 20))
        pSpecialAttack.textColor = .black
        pSpecialAttack.textAlignment = .center
        pSpecialAttack.text = "SpecialA: \(p.specialAttack!)"
        view.addSubview(pSpecialAttack)
        
        pSpecialDefense = UILabel(frame: CGRect(x: 140, y: 200, width: 100, height: 20))
        pSpecialDefense.textColor = .black
        pSpecialDefense.textAlignment = .center
        pSpecialDefense.text = "SpecialD: \(p.specialDefense!)"
        view.addSubview(pSpecialDefense)
        
        pSpeed = UILabel(frame: CGRect(x: 250, y: 200, width: 100, height: 20))
        pSpeed.textColor = .black
        pSpeed.textAlignment = .center
        pSpeed.text = "Speed: \(p.speed!)"
        view.addSubview(pSpeed)
        
        pSpecies = UILabel(frame: CGRect(x: 20, y: 510, width: view.frame.width-40, height: 30))
        pSpecies.textColor = .black
        pSpecies.textAlignment = .center
        pSpecies.text = "Species: \(p.species!)"
        view.addSubview(pSpecies)
        
    }
    
    func checkImage() {
        let url = URL(string: p.imageUrl)
        if url != nil {
            do {
                let data = try Data(contentsOf: url!)
                pImage.image = UIImage(data: data)
            } catch {
                pImage.image = UIImage(named: "pokedex")
            }
        } else {
            pImage.image = UIImage(named: "pokedex")
        }
    }
    
}
