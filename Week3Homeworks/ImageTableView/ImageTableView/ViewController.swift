//
//  ViewController.swift
//  ImageTableView
//
//  Created by semra on 9.07.2021.
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var itemList = [ItemModel]();
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredUsers = [ItemModel]()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //clearAllCoreData();
        tableView.layer.cornerRadius = CGFloat(8.0);
        let footerView = UIView()
        footerView.backgroundColor = view.backgroundColor
        tableView.tableFooterView = footerView
        tableView.delegate = self;
        tableView.dataSource = self;
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Candies"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    public func clearAllCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
               let context = appDelegate.persistentContainer
        let entities = context.managedObjectModel.entities
        entities.flatMap({ $0.name }).forEach(clearDeepObjectEntity)
    }

    private func clearDeepObjectEntity(_ entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        getItems();
        tableView.reloadData();
        
    }
    
    func getItems(){
        itemList.removeAll();
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.returnsObjectsAsFaults = false
        guard let results = try? context.fetch(fetchRequest) as? [NSManagedObject] else { return }
        for result in results {
            guard let id = result.value(forKey: "id") as? UUID,
                  let name = result.value(forKey: "name") as? String,
                  let image = result.value(forKey: "image") as? NSData else { continue }
                let item = ItemModel(id: id, name: name, image: UIImage(data: image as Data) ?? UIImage());
            itemList.append(item);
        }
    }
    func deleteItemFromDb(item: ItemModel)  {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "ANY %K == %@", "id", item.id as CVarArg)
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                guard let object = object as? NSManagedObject else { continue }
                context.delete(object)
            }
            try context.save()
        } catch let error {
            
        }
    }
    
    func filterContextForSearchText(searchText: String) {
        filteredUsers = itemList.filter({ (item: ItemModel) -> Bool in
            return item.name.lowercased().contains(searchText.lowercased())
        })
        if filteredUsers.isEmpty && searchText.count > 0 {
            tableView.setEmptyView(title: "Search could not found.", message: "Try another one!")
        }else {
            tableView.restore()
        }
        tableView.reloadData()
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredUsers.count
        }
        if(itemList.count == 0){
            tableView.setEmptyView(title: "No item in List", message: "Add Item")
            return 0;
        }
        tableView.restore()
        return itemList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item: ItemModel
        
        if isFiltering {
            item = filteredUsers[indexPath.row]
        } else {
            item = itemList[indexPath.row]
        }
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemViewCell;
        itemCell.imageCell.image = nil;
        
        print(item.image)
        itemCell.configure(itemModel: item);
        return itemCell;
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Delete", message: "Do you want to delete item ? ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                tableView.beginUpdates()
                self.deleteItemFromDb(item: self.itemList[indexPath.row] )
                self.itemList.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContextForSearchText(searchText: searchBar.text!)
    
  }
}
extension UITableView {
    
    func setEmptyView(title: String, message: String){
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
