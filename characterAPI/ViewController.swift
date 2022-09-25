//
//  ViewController.swift
//  characterAPI
//
//  Created by IACD-014 on 2022/06/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var characters = [characterStats]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let char = characters[indexPath.row]
        cell.textLabel?.text = char.name.capitalized
        cell.detailTextLabel?.text = char.status.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? characterViewController {
            
            destination.char = characters[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://breakingbadapi.com/api/characters")
        
        URLSession.shared.dataTask(with: url!) { data, response, err in
            
            if err == nil {
                do {
                self.characters = try JSONDecoder().decode([characterStats].self, from: data!)
                DispatchQueue.main.async {
                    completed()
                }
            }
            catch{
                print("error fetching data from api")
            }
          }
        }.resume()
    }


}

