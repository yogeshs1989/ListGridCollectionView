//
//  ListGridCollectionViewController.swift
//  ListGridCollectionView
//
//  Created by Kundan Suthar on 07/08/17.
//  Copyright © 2017 Yogesh Suthar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "imageCell"

class ListGridCollectionViewController: UICollectionViewController {

    private var imageColors : [UIColor] = []
    
    private let listFlowLayout = ProductsListFlowLayout()
    private let gridFlowLayout = ProductsGridFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.collectionView?.setCollectionViewLayout(self.listFlowLayout, animated: false)
        
        for _ in 0..<50 {
            let red = arc4random_uniform(255) + 1
            let green = arc4random_uniform(255) + 1
            let blue = arc4random_uniform(255) + 1
            
            let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
            imageColors.append(color)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageColors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListGridCollectionViewCell
        cell.imageView.backgroundColor = imageColors[indexPath.row]
        return cell
    }
    @IBAction func gridButtonClicked(_ sender: Any) {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.setCollectionViewLayout(self.gridFlowLayout, animated: true)
        }
    }
    
    @IBAction func listButtonClicked(_ sender: Any) {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.setCollectionViewLayout(self.listFlowLayout, animated: true)
        }
    }
    
}

class ProductsGridFlowLayout: UICollectionViewFlowLayout {
    
    // here you can define the height of each cell
    let itemHeight: CGFloat = 120
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    /// here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width/2)-1
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height:itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height:itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}

class ProductsListFlowLayout: UICollectionViewFlowLayout {
    
    let itemHeight: CGFloat = 120
    
    override init() {
        super.init()
        setupLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
        return collectionView!.frame.width
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height:itemHeight)
        }
        get {
            return CGSize(width: itemWidth(), height:itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
