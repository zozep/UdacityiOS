//
//  TableVC.swift
//  memeMe
//
//  Created by Joseph Park on 3/27/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {

    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath)
        let meme = memes[indexPath.row]
        cell.memeImg.image = meme.memedImage
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeView = self.storyboard?.instantiateViewController(withIdentifier: "DetailMemeVC") as! DetailMemeVC
        memeView.name = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeView, animated: true)
    }

}
