//
//  CollectionExtension.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import Foundation
import UIKit
extension GameScreenVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        guard (viewModel.gameManager?.gameElementsArray.count) != nil else {return 0}
        return (viewModel.gameManager?.gameElementsArray.count)!
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel.gameManager?.gameElementsArray[section].symbols.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.id, for: indexPath) as! GameCollectionViewCell
        cell.setupImage(with: (viewModel.gameManager?.gameElementsArray[indexPath.section].symbols[indexPath.row])!)
        return cell
    }
    

}


extension GameScreenVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell
        cell.backgroundImage.layer.shadowOpacity = 1
        cell.backgroundImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.backgroundImage.layer.shadowRadius = 10
        cell.backgroundImage.layer.shadowColor = UIColor.red.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell
        cell.backgroundImage.layer.shadowOpacity = 0
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        visibleCellsIndexPaths = collectionView.indexPathsForVisibleItems
        updateVisibleCellsMatrix()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionView.layoutIfNeeded()
        visibleCellsIndexPaths = collectionView.indexPathsForVisibleItems
        updateVisibleCellsMatrix()
    }
   
    
}
