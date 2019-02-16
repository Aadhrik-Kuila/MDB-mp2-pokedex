//
//  ViewController.swift
//  MP2 PokeDex
//
//  Created by Aadhrik Kuila on 2/15/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var pTitle: UILabel!
    
    var attackMin: UITextField!
    var healthMin: UITextField!
    var defenseMin: UITextField!
    
    var namePokemon: String!
    var search: UITextField!
    var findB: UIButton!
    var randomB: UIButton!
    var randomPokemon: Set<Int>!
    
    var xSide:CGFloat = 56
    var filteredType = Set<Int>()
    
    var stringAttack: String!
    var stringHealth: String!
    var stringDefense: String!
    
    var attack =  0
    var health = 0
    var defense = 0
    var types = ["Grass", "Water", "Electric"]
    var pokemonArray = PokemonGenerator.getPokemonArray()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for i in 0 ... 2 {
            
            let b = UIButton()
            b.tag = i
            b.backgroundColor = .blue
            b.setTitle(types[i], for: .normal)
            b.setTitleColor(.white, for: .normal)
            b.layer.cornerRadius = 10
            b.addTarget(self, action: #selector(typeButtonTouched), for: UIControl.Event.touchUpInside)
            b.frame = CGRect(x: xSide, y: 200, width: 80, height: 50)
            view.addSubview(b)
            xSide = xSide + 10 + b.frame.size.width
            
        }
        
        pTitle = UILabel(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 60))
        pTitle.textColor = .red
        pTitle.textAlignment = .center
        pTitle.text = "MP2 Pokedex"
        view.addSubview(pTitle)
        
        search = UITextField(frame: CGRect(x: 30, y: 110, width: 200, height: 50))
        search.placeholder = "Search"
        search.borderStyle = .roundedRect
        search.addTarget(self, action: #selector(searchText), for: .allEditingEvents)
        view.addSubview(search)
        
        findB = UIButton(frame: CGRect(x: 250, y: 110, width: 90, height: 50))
        findB.backgroundColor = .green
        findB.setTitle("Find", for: .normal)
        findB.setTitleColor(.white, for: .normal)
        findB.layer.cornerRadius = 8
        findB.addTarget(self, action: #selector(pressFind), for: .touchUpInside)
        view.addSubview(findB)
        
        attackMin = UITextField(frame: CGRect(x: 80, y: 270, width: 200, height: 50))
        attackMin.placeholder = "Minimum Attack"
        attackMin.borderStyle = .roundedRect
        attackMin.addTarget(self, action: #selector(attackText), for: .allEditingEvents)
        view.addSubview(attackMin)
        
        healthMin = UITextField(frame: CGRect(x: 80, y: 340, width: 200, height: 50))
        healthMin.placeholder = "Minimum Health"
        healthMin.borderStyle = .roundedRect
        healthMin.addTarget(self, action: #selector(healthText), for: .allEditingEvents)
        view.addSubview(healthMin)
        
        defenseMin = UITextField(frame: CGRect(x: 80, y: 410, width: 200, height: 50))
        defenseMin.placeholder = "Minimum Defense"
        defenseMin.borderStyle = .roundedRect
        defenseMin.addTarget(self, action: #selector(defenseText), for: .allEditingEvents)
        view.addSubview(defenseMin)
        
        randomB = UIButton(frame: CGRect(x: 120, y: 500, width: 120, height: 60))
        randomB.backgroundColor = .red
        randomB.setTitle("Random", for: .normal)
        randomB.setTitleColor(.white, for: .normal)
        randomB.layer.cornerRadius = 8
        randomB.addTarget(self, action: #selector(randomBTapped), for: .touchUpInside)
        view.addSubview(randomB)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        randomPokemon = Set<Int>()
        self.search.delegate = self
        self.attackMin.delegate = self
        self.healthMin.delegate = self
        self.defenseMin.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func attackText(sender: UITextField) {
        stringAttack = sender.text
        if stringAttack != "" {
            attack = Int(stringAttack)!
        }
    }
    
    @objc func healthText(sender:UITextField) {
        stringHealth = sender.text
        if stringHealth != "" {
            health = Int(stringHealth)!
        }
    }
    @objc func defenseText(sender: UITextField) {
        stringDefense = sender.text
        if stringDefense != "" {
            defense = Int(stringDefense)!
        }
    }
    
    @objc func searchText (sender: UITextField) {
        let numPokemon = Int(sender.text!)
        if numPokemon != nil {
            for i in pokemonArray {
                if numPokemon == i.number {
                    namePokemon = i.name
                }
            }
        } else {
            namePokemon = sender.text
        }
    }
    
    @objc func randomBTapped(sender: UIButton) {
        while randomPokemon.count < 20 {
            randomPokemon.insert(Int(arc4random_uniform(80)) + 1)
        }
        self.performSegue(withIdentifier: "find", sender: self)
    }
    
    @objc func typeButtonTouched(sender: UIButton) {
        if (filteredType.contains(sender.tag)){
            filteredType.remove(sender.tag)
            sender.layer.borderWidth = 0
        } else {
            filteredType.insert(sender.tag)
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @objc func pressFind(sender: UIButton) {
        self.performSegue(withIdentifier: "find", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "find" {
            let filtered = segue.destination as! FilteredViewController
            filtered.namePokemon = namePokemon
            filtered.types = filteredType
            filtered.attack = attack
            filtered.health = health
            filtered.defense = defense
            filtered.randomPokemon = randomPokemon
            filtered.pokemonArray = pokemonArray
        }
        
    }
}

