//
//  PokemonViewCell.swift
//  MP2 PokeDex
//
//  Created by Aadhrik Kuila on 2/15/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit

protocol PokemonViewGridDelegate {
    func gridButton(forCell: PokemonViewGrid)
}

class PokemonViewGrid: UICollectionViewCell {
    
    var pokemonImageView: UIImageView!
    var label: UILabel!
    var delegate: PokemonViewGridDelegate? = nil
    
    override func awakeFromNib() {
        label = UILabel(frame: CGRect(x: 10, y: contentView.frame.maxY - 25, width: contentView.frame.width - 10, height: 20))
        contentView.addSubview(label)
        pokemonImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: contentView.frame.width - 20, height: contentView.frame.height - 40))
        contentView.addSubview(pokemonImageView)
    }
    
}
