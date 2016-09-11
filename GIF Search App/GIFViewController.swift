//
//  GIFViewController.swift
//  GIF Search App
//
//  Created by Janmarc on 9/3/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Gifu

class GIFViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

   struct StoryBoard {
      static let collectionViewCell = "GifCell"
   }
   
   // MARK: IBOutlets
   @IBOutlet weak var gifsCollectionView: UICollectionView!
   @IBOutlet weak var gifSearchBar: UISearchBar!
   
   // MARK: Variables
   var GIFs = [GIF]() {
      didSet{
         gifsCollectionView?.reloadData()
      }
   }
   
   let alamoHandler = AlamofireHandler()
   
   //MARK: LifeCycle
   override func viewDidLoad() {
      print("viewDidLoad fired")
      super.viewDidLoad()
      gifSearchBar.delegate = self
   }
   
   override func viewWillAppear(animated: Bool) {
      print("viewWillAppear fired")
      super.viewWillAppear(animated)
      
      alamoHandler.getTrending { (json) in
         self.alamoHandler.getURL(json, completion: { (gifs) in
            self.GIFs = gifs
         })
      }
   }
   
   // MARK: Collection View Delegate & Data Source
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("numberOfItemsInSection executed")
      
      return GIFs.count
   }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GifCell", forIndexPath: indexPath) as! GIFCollectionViewCell
      
      return cell
   }
   
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
      guard let cell = cell as? GIFCollectionViewCell else { return }
      cell.whiteView.hidden = false
      cell.loadingAnimation.startAnimating()
      cell.setAnimatableImageView(GIFs[indexPath.row])
   }
   
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
      guard let cell = cell as? GIFCollectionViewCell else { return }
      cell.whiteView.hidden = false
   }
   
   // MARK: Search Bard Delegates
   
   func searchBarTextDidEndEditing(searchBar: UISearchBar) {
      print("searchBarTextDidEndEditing fired")
      
      if let text = searchBar.text where !text.isEmpty {
         alamoHandler.search(text) { (json) in
            self.alamoHandler.getURL(json, completion: { (gifs) in
               self.GIFs = gifs
            })
         }
      }
   }
   
   func searchBarSearchButtonClicked(searchBar: UISearchBar) {
      print("searchBarSearchButtonClicked fired")
      
   }
   
   func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
      print("searchBar fired")
      
      
      
      if let text = searchBar.text where !text.isEmpty {
         alamoHandler.search(text) { (json) in
            self.alamoHandler.getURL(json, completion: { (gifs) in
               self.GIFs = gifs
            })
         }
      }
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}