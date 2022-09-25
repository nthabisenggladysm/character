//
//  characterViewController.swift
//  characterAPI
//
//  Created by IACD-014 on 2022/06/24.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType?.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
        else { return }
        DispatchQueue.main.async() { [weak self] in
            self?.image = image
        }
      }.resume()
     }
    func downloaded(from link: String,contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
   
}
class characterViewController: UIViewController {

    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var char: characterStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameLabel.text = char?.name
        actorLabel.text = char?.portrayed
        statusLabel.text = char?.status
        characterImg.downloaded(from: char!.img )
        
    }
}
