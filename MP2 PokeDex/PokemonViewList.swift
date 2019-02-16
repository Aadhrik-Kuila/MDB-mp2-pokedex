//
//  PokemonViewCell2.swift
//  MP2 PokeDex
//
//  Created by Aadhrik Kuila on 2/15/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit

protocol PokemonViewListDelegate {
    func listButton(forCell: PokemonViewList)
}

class PokemonViewList: UITableViewCell {
    
    var pokemonImageView: UIImageView!
    var label: UILabel!
    var delegate: PokemonViewList? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label = UILabel(frame: CGRect(x: 120, y: 30, width: 200, height: 30))
        contentView.addSubview(label)
        pokemonImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 80, height: 60))
        contentView.addSubview(pokemonImageView)
    }
    
}
