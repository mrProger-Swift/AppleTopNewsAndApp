//
//  NewTableViewCell.swift
//  probeGenerics
//
//  Created by User on 17.12.2020.
//
import SDWebImage
import UIKit
struct CacheImage {
  
}
class NewTableViewCell: UITableViewCell {
    
    static var reusableId = "NewCell"
    static var nibName = "NewTableViewCell"
    
    var cacheImage = CacheImage()
    
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    
    func appleCellConfigure(currentData: Interface) {
        album.text = currentData.name
        author.text = currentData.artistName
        newImage.sd_setImage(with: URL(string: currentData.artworkUrl100 ?? Constants.resetAddress),
                             completed: nil)
    }
    
    func newsCellConfigure(array: [InterfaceNews], indexPath: IndexPath) {
        guard array.isEmpty == false else {return}
        let current = array[indexPath.row]
        album.text = current.title
        author.text = "Author \(current.source?.name ?? "")"
        newImage.sd_setImage(with: URL(string: current.urlToImage ?? Constants.resetAddress),
                             completed: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newImage.image = nil
    }
    
}
