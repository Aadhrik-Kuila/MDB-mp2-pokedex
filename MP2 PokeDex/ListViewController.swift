//
//  FilteredViewController.swift
//  MP2 PokeDex
//
//  Created by Aadhrik Kuila on 2/15/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit

class FilteredViewController: UIViewController {
    
    var attack = 0
    var health = 0
    var defense = 0
    var randomPokemon = Set<Int>()
    var namePokemon: String!
    var pokemon: Pokemon!
    
    var types = Set<Int>()
    var getTypes = Set<String>()
    
    var gridView: UICollectionView!
    var listView: UITableView!
    var pokemonArray = [Pokemon]()
    var getfilteredPokemon = Array<Pokemon>()
    var num: Int = 800
    var pokemonTypes = ["Grass", "Water", "Electric"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        gridView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        gridView.register(PokemonViewGrid.self, forCellWithReuseIdentifier: "pokemonGrid")
        gridView.tag = 0
        gridView.delegate = self
        gridView.dataSource = self
        gridView.backgroundColor = .white
        view.addSubview(gridView)
        
        listView = UITableView(frame: view.frame)
        listView.register(PokemonViewList.self, forCellReuseIdentifier: "pokemonList")
        listView.rowHeight = 80
        listView.showsVerticalScrollIndicator = true
        listView.bounces = true
        listView.tag = 1
        listView.delegate = self
        listView.dataSource = self
        view.addSubview(listView)
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white;
        let items = ["Grid", "List"]
        let customSC = UISegmentedControl(items: items)
        customSC.addTarget(self, action: #selector(switchingSC), for: .valueChanged)
        customSC.selectedSegmentIndex = 0
        gridView.isHidden = false
        listView.isHidden = true
        customSC.sizeToFit()
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = .blue
        customSC.tintColor = .white
        self.navigationItem.titleView = customSC

        filtering()
        gridView.reloadData()
        listView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        if getfilteredPokemon.count == 0 {
            let alert = UIAlertController(title: "No Pokemon Found!", message: "Adjust filters to find some.", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case.default:
                    self.navigationController?.popToRootViewController(animated: true)
                    
                case.cancel:
                    self.navigationController?.popToRootViewController(animated: true)
                    
                case.destructive:
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }))
        }
    }
    
    func filtering() {
        if !randomPokemon.isEmpty {
            for i in pokemonArray {
                for j in randomPokemon {
                    if i.number == j {
                        getfilteredPokemon.append(i)
                    }
                }
                
            }
        } else if namePokemon != nil && namePokemon != "" {
            for i in pokemonArray {
                if (i.name == namePokemon) {
                    getfilteredPokemon.append(i)
                }
            }
        } else if attack == 0 && defense == 0 && health == 0  && types.isEmpty {
            for i in pokemonArray {
                getfilteredPokemon.append(i)
            }
        } else {
            for i in pokemonArray {
                if types.isEmpty {
                    if i.attack >= attack && i.defense >= defense && i.health >= health {
                        getfilteredPokemon.append(i)
                    }
                } else {
                    for j in types {
                        getTypes.insert(pokemonTypes[j])
                    }
                    if i.attack >= attack && i.defense >= defense && i.health >= health {
                        let listSet = Set(i.types)
                        
                        let allElemsContained = getTypes.isSubset(of: listSet)
                        if allElemsContained {
                            getfilteredPokemon.append(i)
                        }
                    }
                }
            }
        }
        num = getfilteredPokemon.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoSegue" {
            let Individual = segue.destination as! IndividualViewController
            Individual.p = pokemon
        }
        
    }
    
    @objc func switchingSC(sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            gridView.isHidden = false
            listView.isHidden = true
        case 1:
            gridView.isHidden = true
            listView.isHidden = false
        default:
            break
        }
    }
}

extension FilteredViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonList", for: indexPath) as! PokemonViewList
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pokemonCell = cell as! PokemonViewList
        let pokemon = getfilteredPokemon[indexPath.item]
        let url = URL(string: pokemon.imageUrl)
        if url != nil {
            do {
                let data = try Data(contentsOf: url!)
                pokemonCell.pokemonImageView.image = UIImage(data: data)
                pokemonCell.label.text = "#\(pokemon.number!) \(pokemon.name!)"
            } catch {
                pokemonCell.pokemonImageView.image = UIImage(named: "pokedex")
                pokemonCell.label.text = "#\(pokemon.number!) \(pokemon.name!)"
            }
        } else {
            pokemonCell.pokemonImageView.image = UIImage(named: "pokedex")
            pokemonCell.label.text = "#\(pokemon.number!) \(pokemon.name!)"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemon = getfilteredPokemon[indexPath.row]
        CellTapped()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonGrid", for: indexPath) as! PokemonViewGrid
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pokemonCell = cell as! PokemonViewGrid
        let pokemon = getfilteredPokemon[indexPath.item]
        let url = URL(string: pokemon.imageUrl)
        if url != nil {
            do {
                let data = try Data(contentsOf: url!)
                pokemonCell.pokemonImageView.image = UIImage(data: data)
                pokemonCell.label.text = "#\(pokemon.number!) \(pokemon.name!)"
            } catch {
                pokemonCell.pokemonImageView.image = UIImage(named: "pokedex")
                pokemonCell.label.text = "#\(pokemon.number!) \(pokemon.name!)"
            }
        } else {
            pokemonCell.pokemonImageView.image = UIImage(named: "pokedex")
            pokemonCell.label.text = "#\(pokemon.number!) \(pokemon.name!)"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width)/3.2, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokemon = getfilteredPokemon[indexPath.item]
        CellTapped()
    }
    
    func CellTapped() {
        self.performSegue(withIdentifier: "infoSegue", sender: self)
    }
    
}

extension FilteredViewController: PokemonViewGridDelegate, PokemonViewListDelegate {
    
    func gridButton(forCell: PokemonViewGrid) {
        forCell.backgroundColor = UIColor.clear
    }
    
    func listButton(forCell: PokemonViewList) {
        forCell.backgroundColor = UIColor.clear
    }
    
}
