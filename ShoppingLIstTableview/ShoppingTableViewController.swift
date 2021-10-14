//
//  ShoppingTableViewController.swift
//  ShoppingLIstTableview
//
//  Created by 김정민 on 2021/10/14.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shopList:[Shop] = [] {
        didSet {
            saveData()
        }
    }
    

    func saveData() {
        var shop : [[String : Any ]] = [ ]
        
        for list in shopList {
            
            let data : [String : Any] = [
                "item" : list.item
            ]
            
            shop.append(data)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(shop, forKey: "shopList")
        
        tableView.reloadData()

    }
    
    func loadData(){
        
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: "shopList") as?
            [[String:Any]]{
        
            var shop = [Shop]()

            for datum in data {
                guard let item = datum["item"] as? String else {
                    return
                }
                shop.append(Shop(item: item))
            }
            self.shopList = shop
        }
   
    }
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "쇼핑"
        self.textField.placeholder = "무엇을 구매하실 건가요?"
        self.addButton.setTitle("추가", for: .normal)
        
        loadData()
        
        
    }
    
    @IBAction func buyButtonClicked(_ sender: UIButton) {
        
        if let text = textField.text {
            let shop = Shop(item: text)
        
            shopList.append(shop)
            
            textField.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.identifier, for: indexPath) as? ShoppingTableViewCell
        else { return UITableViewCell()
        }
            
        let row = shopList[indexPath.row]
        
        cell.shopItemLabel?.text = row.item
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            
            tableView.beginUpdates()
            shopList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UIScreen.main.bounds.height / 15
    }

}
