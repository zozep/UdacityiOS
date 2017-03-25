//
//  VillainCollectionViewController.swift
//  BondVillains
//
//  Created by Joseph Park on 3/22/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "Cell"

class VillainCollectionViewController: UICollectionViewController {
    
    // MARK: Properties

    let allVillains = Villain.allVillains
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allVillains.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VillainCollectionViewCell", for: indexPath) as! VillainCollectionViewCell
        
        let villain = self.allVillains[indexPath.row]
        
        //Set the name and image
        cell.nameLabel.text = villain.name
        cell.VillainImageView?.image = UIImage(named: villain.imageName)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
        detailController.villain = self.allVillains[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
