//
//  HomeController.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/15/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
extension UISearchBar {
    func changeSearchBarColor(color : UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                if subSubView.conforms(to: UITextInputTraits.self) {
                    let textField = subSubView as! UITextField
                    textField.backgroundColor = color
                    break
                }
            }
        }
    }
}
class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {
    var user : User = AppUtils.getInstance().objects(User.self).first!
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

    
    var selectedIndex : Int = 0
    
    @IBOutlet weak var UI_searchbar: UISearchBar!
    var itemsection = [Section]()
    var filteredData = [Section]()
    @IBOutlet weak var UI_tableview: UITableView!
    var inSearchMode = false
     var searchstring : String = ""
    override func viewDidLoad() {
        setGradientBackground()
        super.viewDidLoad()
        configUI()
        itemsection = [
              Section(name: "", items: [Debit()]),
            Section(name: "Đến hạn", items: []),
            Section(name: "Chưa đến hạn", items: []),
            Section(name: "Quá hạn", items: [])
        ]
        filteredData = [
             Section(name: "", items: [Debit()]),
            Section(name: "Đến hạn", items: []),
            Section(name: "Chưa đến hạn", items: []),
            Section(name: "Quá hạn", items: [])
        ]
       
        try! AppUtils.getInstance().write {
            let temp = Debit()
            temp._id = "1"
            temp.ammount = 300000
            temp.name = "Tô Tử Siêu"
            temp.notification = false
            temp.timestart = 1534343533
            temp.timeend = 1534343533
            temp.type = AppUtils.FORRENT
            user.listdebit.insert(temp, at: 0)
            user.listdebit.insert(temp, at: 0)
            user.listdebit.insert(temp, at: 0)
            user.listdebit.insert(temp, at: 0)
            user.listdebit.insert(temp, at: 0)
            user.listdebit.insert(temp, at: 0)
            user.listdebit.insert(temp, at: 0)
            user.listdebit.insert(temp, at: 0)
            let temp2 = Debit()
            temp2._id = "2"
            temp2.ammount = 4500000
            temp2.name = "Bùi Thùy Trang"
            temp2.notification = false
            temp2.timestart = 1533916226
            temp2.timeend = 1538295909
            temp2.type = AppUtils.RENT
            
            user.listdebit.insert(temp2, at: 0)
            let temp3 = Debit()
            temp3._id = "3"
            temp3.ammount = 45000000
            temp3.name = "Hiển ml"
            temp3.notification = false
            temp3.timestart = 1539186626
            temp3.timeend = 1540295910
            temp3.type = AppUtils.FORRENT
            user.listdebit.insert(temp3, at: 0)
            print(user.listdebit)
           AppUtils.getInstance().add(user, update: true)
            
            
            
        }
    
        loadData()
        UI_tableview.delegate = self
        UI_tableview.dataSource = self
     
        // Do any additional setup after loading the view.
    }
    
    //======================     filter debit type
    @IBAction func type_change(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            selectedIndex = 0
          (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).view_forrent.isHidden = false
              (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).view_rent.isHidden = false
           if(searchstring != "")
           {
               filterwithString()
            }
            
        case 1:
             selectedIndex = 1
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).view_forrent.isHidden = false
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).view_rent.isHidden = true
             if(searchstring != "")
             {
                filterwithStringType()
            }
             else{
                filterwithType()
            }
        default:
              selectedIndex = 2
        
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).view_forrent.isHidden = true
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).view_rent.isHidden = false
       
              if(searchstring != "")
              {
                filterwithStringType()
              }
              else{
                filterwithType()
            }
        }
      reloadTable()
      
    }
    func reloadTable(){
      
        reloadAmount(    cell: (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell))
        UIView.performWithoutAnimation {
            let contentOffset = UI_tableview.contentOffset
            let range = NSMakeRange(1, 3)
            let sections = NSIndexSet(indexesIn: range)
            self.UI_tableview.reloadSections(sections as IndexSet, with: .none)
            UI_tableview.layoutIfNeeded()
            UI_tableview.setContentOffset(contentOffset, animated: false)
        }
      
    }
    func reloadAmount(cell : FirstCell){
        if(!inSearchMode && selectedIndex == 0)
        {
            var first_ammount = itemsection[1].items.filter({$0.type == 1}).reduce(0, {$0 + $1.ammount})
            var second_ammount = itemsection[2].items.filter({$0.type == 1}).reduce(0, {$0 + $1.ammount})
            var third_ammount = itemsection[3].items.filter({$0.type == 1}).reduce(0, {$0 + $1.ammount})
           cell.total_amount_forrent.text = "\(first_ammount + second_ammount + third_ammount) đ"
            
            first_ammount = itemsection[1].items.filter({$0.type == 2}).reduce(0, {$0 + $1.ammount})
            second_ammount = itemsection[2].items.filter({$0.type == 2}).reduce(0, {$0 + $1.ammount})
            third_ammount = itemsection[3].items.filter({$0.type == 2}).reduce(0, {$0 + $1.ammount})
           cell.total_amount_rent.text = "\(first_ammount + second_ammount + third_ammount) đ"
        }
        else{
            
        }
    }
    func filterwithStringType()
    {
    filteredData[1].items = itemsection[1].items.filter({   ($0.name?.lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timestart).lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timeend).lowercased().range(of:searchstring.lowercased()) != nil) && $0.type == selectedIndex })
    filteredData[2].items = itemsection[2].items.filter({   ($0.name?.lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timestart).lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timeend).lowercased().range(of:searchstring.lowercased()) != nil) && $0.type == selectedIndex })
    filteredData[3].items = itemsection[3].items.filter({   ($0.name?.lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timestart).lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timeend).lowercased().range(of:searchstring.lowercased()) != nil) && $0.type == selectedIndex })
    }
    func filterwithString()
    {
        filteredData[1].items = itemsection[1].items.filter({   ($0.name?.lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timestart).lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timeend).lowercased().range(of:searchstring.lowercased()) != nil) })
        filteredData[2].items = itemsection[2].items.filter({   ($0.name?.lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timestart).lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timeend).lowercased().range(of:searchstring.lowercased()) != nil) })
        filteredData[3].items = itemsection[3].items.filter({   ($0.name?.lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timestart).lowercased().range(of:searchstring.lowercased()) != nil || AppUtils.dayString(from: $0.timeend).lowercased().range(of:searchstring.lowercased()) != nil) })
    }
    func filterwithType()
    {
        filteredData[1].items = itemsection[1].items.filter({$0.type == selectedIndex})
        filteredData[2].items = itemsection[2].items.filter({$0.type == selectedIndex})
        filteredData[3].items = itemsection[3].items.filter({$0.type == selectedIndex})
    }
    func reloadsegment(){
        if(!inSearchMode && selectedIndex == 0)
        {
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).segmented_control.setTitle("Tất cả (\(itemsection[1].items.count + itemsection[2].items.count + itemsection[3].items.count))", forSegmentAt: 0)
           (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).segmented_control.setTitle("Cho vay (\(itemsection[1].items.filter({$0.type == 1}).count + itemsection[2].items.filter({$0.type == 1}).count + itemsection[3].items.filter({$0.type == 1}).count))", forSegmentAt: 1)
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).segmented_control.setTitle("Đã vay (\(itemsection[1].items.filter({$0.type == 2}).count + itemsection[2].items.filter({$0.type == 2}).count + itemsection[3].items.filter({$0.type == 2}).count))", forSegmentAt: 2)
          
        }
        else
        {
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).segmented_control.setTitle("Tất cả (\(filteredData[1].items.count + filteredData[2].items.count + filteredData[3].items.count))", forSegmentAt: 0)
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).segmented_control.setTitle("Cho vay (\(filteredData[1].items.filter({$0.type == 1}).count + filteredData[2].items.filter({$0.type == 1}).count + filteredData[3].items.filter({$0.type == 1}).count))", forSegmentAt: 1)
            (UI_tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstCell).segmented_control.setTitle("Đã vay (\(filteredData[1].items.filter({$0.type == 2}).count + filteredData[2].items.filter({$0.type == 2}).count + filteredData[3].items.filter({$0.type == 2}).count))", forSegmentAt: 2)
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
       
     
           searchBar.sizeToFit()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        
       
           searchBar.sizeToFit()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar .resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
      
      
           searchBar.sizeToFit()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar .resignFirstResponder()
       
        searchBar.setShowsCancelButton(false, animated: true)
      
           searchBar.sizeToFit()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            
            view.endEditing(true)
            searchstring = ""
              reloadsegment()
           reloadTable()
            
        } else {
            
            inSearchMode = true
            searchstring = searchText
            if(selectedIndex == 0)
            {
               filterwithString()
            }
            else{
                 filterwithStringType()
            }
            reloadsegment()
          reloadTable()
        }
    }
    func setGradientBackground() {
//        let colorTop =  UIColor(red: 64/255.0, green: 70/255.0, blue: 84/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 58/255.0, green: 64/255.0, blue: 78/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    func loadData()  {
          let result = AppUtils.getInstance().objects(Debit.self).sorted(byKeyPath: "timeend", ascending: false)
        print(result)
        for index in 0...result.count - 1 {
            
            if AppUtils.countDay(from: result[index].timeend) < 0
            {
                itemsection[3].items.insert(result[index], at: 0)
            }
                
            else if AppUtils.countDay(from: result[index].timeend) == 0
            {
                
                itemsection[1].items.insert(result[index], at: 0)
               
            }
                
            else
            {
                itemsection[2].items.insert(result[index], at: 0)
              
            }
//            if let section = itemsection.index(where: {$0.name == AppUtils.dayString(from : listDebit[index].timestart)}) {
//                    itemsection[section].items.insert( listDebit[index], at: 0)
//            } else {
//                itemsection.insert(Section(name: AppUtils.dayString(from : listDebit[index].timestart), items: [listDebit[index]]), at: 0)
//                // item could not be found
//            }

        }

      
  
    }
    func configUI(){
      
        UI_searchbar.layer.borderWidth = 1
        UI_searchbar.layer.borderColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
          UI_searchbar.changeSearchBarColor(color: UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1))
        UI_searchbar.returnKeyType = UIReturnKeyType.done
        // border
        let searchBarStyle = UI_searchbar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .whileEditing
        UI_searchbar.delegate = self
     
      
    }
    
    
    //===================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if inSearchMode {
//            return filteredData[section].collapsed ? 0 : filteredData[section].items.count
//
//        }
//        return itemsection[section].collapsed ? 0 : itemsection[section].items.count
//         return listDebit.count
        if inSearchMode || selectedIndex != 0 {
            return filteredData[section].collapsed ? 0 : filteredData[section].items.count
            
        }
        return itemsection[section].collapsed ? 0 : itemsection[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemsection.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0)
        {
            return 350
            
        }
        else
        {
             return itemsection[(indexPath as NSIndexPath).section].collapsed ? 0 : 70
        }
       
//           return 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let processor = RoundCornerImageProcessor(cornerRadius: 160)
            let cell = tableView.dequeueReusableCell(withIdentifier: "first_cell", for: indexPath) as! FirstCell
            cell.UI_avatar.kf.setImage(with: URL(string: user.photoprofile!),options: [.transition(.fade(1)),.processor(processor)], completionHandler: { image, error, cacheType, imageURL in
                
                
            })
            cell.UI_name.text = user.name
            if(user.type == 0)
            {
                cell.UI_type.text = "Facebook"
                cell.UI_type.textColor = UIColor.blue
            }
            else
            {
                cell.UI_type.text = "Google"
                cell.UI_type.textColor = UIColor.red
            }
            
            reloadAmount(  cell: cell)
            
            
           cell.segmented_control.setTitle("Tất cả (\(itemsection[1].items.count + itemsection[2].items.count + itemsection[3].items.count))", forSegmentAt: 0)
           cell.segmented_control.setTitle("Cho vay (\(itemsection[1].items.filter({$0.type == 1}).count + itemsection[2].items.filter({$0.type == 1}).count + itemsection[3].items.filter({$0.type == 1}).count))", forSegmentAt: 1)
           cell.segmented_control.setTitle("Đã vay (\(itemsection[1].items.filter({$0.type == 2}).count + itemsection[2].items.filter({$0.type == 2}).count + itemsection[3].items.filter({$0.type == 2}).count))", forSegmentAt: 2)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "debit_cell", for: indexPath) as! DebitViewCell
            var data : Debit
            
            
            //            data = listDebit[indexPath.row]
            if inSearchMode || selectedIndex != 0 {
                
                data = filteredData[indexPath.section].items[indexPath.row]
                
            } else {
                
                data = itemsection[indexPath.section].items[indexPath.row]
            }
         
            
            cell.name.text = data.name
            cell.ammount.text = "\(data.ammount) đ"
            cell.start.text = AppUtils.dayString(from : data.timestart)
            cell.expired.text = AppUtils.dayString(from : data.timeend)
            switch data.type {
            case AppUtils.RENT:
                cell.UI_ImageView?.image = UIImage(named: "rent")
                cell.ammount.textColor = AppUtils.rentColor()
                
            default:
                cell.UI_ImageView?.image = UIImage(named: "forrent")
                cell.ammount.textColor = AppUtils.forrentColor()
            }
            
            
            return cell
        }
       
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
   
    @objc func labelTapped(tapGestureRecognizer: UITapGestureRecognizer) {

        let collapsed = !itemsection[(tapGestureRecognizer.view?.tag)!].collapsed

        // Toggle collapse
        itemsection[(tapGestureRecognizer.view?.tag)!].collapsed = collapsed


        // Reload the whole section
        UI_tableview.reloadSections(NSIndexSet(index: (tapGestureRecognizer.view?.tag)!) as IndexSet, with: .automatic)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 0
        }
        else{
            var height : CGFloat = 42.0
            switch section {
            case 1:
                if(itemsection[1].items.count==0)
                {
                    height = 0.0
                }
                
                
            case 2:
                if(itemsection[2].items.count==0)
                {
                    height = 0.0
                }
                
            default:
                if(itemsection[3].items.count==0)
                {
                    height = 0.0
                }
            }
            return height
        }
      
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = UI_tableview.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")


        if inSearchMode || selectedIndex != 0{
            
            header.titleLabel.text = "\(filteredData[section].name) (\(filteredData[section].items.count))"
            
        } else {
            
            header.titleLabel.text = "\(itemsection[section].name) (\(itemsection[section].items.count))"
        }

        
        header.section = section
       
        header.titleLabel.tag = section
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelTapped(tapGestureRecognizer:)))
        header.titleLabel.isUserInteractionEnabled = true
        header.titleLabel.addGestureRecognizer(tapGestureRecognizer)
        if(itemsection[section].collapsed == true)
        {
            switch (section) {
            case 1:
                header.backgroundView?.backgroundColor = UIColor.red
                header.titleLabel.textColor = UIColor.white
            case 2:
                header.backgroundView?.backgroundColor = UIColor.init(red: 254/255, green: 193/255, blue: 7/255, alpha: 1)
                header.titleLabel.textColor = UIColor.white
            default:
                header.backgroundView?.backgroundColor = UIColor.init(red: 54/255, green: 156/255, blue: 18/255, alpha: 1)
                header.titleLabel.textColor = UIColor.white
            }
        }
        else
        {
            switch section {
            case 1:
               header.backgroundView?.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
              
                   header.titleLabel.textColor = UIColor.init(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
                
            case 2:
            header.backgroundView?.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
                    header.titleLabel.textColor = UIColor.init(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
            default:
            header.backgroundView?.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
                    header.titleLabel.textColor = UIColor.init(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
              
            }
        }


        return header
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
