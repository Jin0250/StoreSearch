//
//  SearchViewController.swift
//  StoreSearch
//
//  Created by cmStudent on 2024/6/16.
//

import UIKit

import Alamofire
import Foundation
import MapKit
import CoreLocation

class SearchViewController: BaseViewController,XMLParserDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    var mylocation: CLLocation!
    var searchBar: UISearchBar!
    var Shops: [ShopModel] = []

    var eName: String = ""
    var address = ""
    var desc = ""
    var name = ""
    var name_kana = ""
    var urls = ""
    var id = ""
    var logo_image = ""
    var index = 0;
    
    //tableview
    private lazy var tableView : UITableView = {
        let tableview = UITableView(frame:CGRectZero, style: .plain)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(AddressTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(AddressTableViewCell.self))
        tableview.backgroundColor = UIColor.white.withAlphaComponent(0)
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.creatHeadeViewString("", andHaveLeft: true, andHaveright: false)
        //検索バー
        self.searchBar = UISearchBar(frame: CGRect(x: wid(50), y: StatusBarHeight, width: SCREEN_WIDTH-wid(65), height: 44))
        self.base_topView.addSubview(searchBar)
        searchBar.placeholder = "Please enter keywords"
        searchBar.barStyle = UIBarStyle.default
        searchBar.showsBookmarkButton = true
        searchBar.showsSearchResultsButton = true
        searchBar.delegate = self
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topHeight+10)
            make.bottom.equalTo(-bottomSafe-wid(67))
        }
        
        
        getSearch("5",searchBar.text ?? "")

        let width = (SCREEN_WIDTH - wid(70+15*4))/5
        
        let titles = ["300m","500m","1Km","2Km","3Km"]
        
        for i in 0...4 {
            let button = UIButton.init(frame: CGRect.init(x: wid(35)+(wid(15)+CGFloat(width))*CGFloat(i), y: SCREEN_HEIGHT-bottomSafe-40, width: width, height: 40))
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = wid(18)
            button.clipsToBounds = true
            button.tag = 100+i
            button.layer.borderWidth = 2
            button.layer.borderColor = RBG_Text("#D5A0FF").cgColor
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            self.view.addSubview(button)
            
        }
        
        // Do any additional setup after loading the view.
    }
    @objc func buttonAction(_ sender : UIButton)
    {
        let titles = ["1","2","3","4","5"]
        getSearch(titles[sender.tag-100], self.searchBar.text ?? "")

    }
    func getSearch(_ area:String,_ string:String){
        
        var semaphore = DispatchSemaphore (value: 0)
//https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(apiKey)&keyword=\(keyword)&lat=\(37.09024)&lng=\(138.88642)&range=\(range)
        let str = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=f164346d1cedc6d4&range=\(area)&lat=\(self.mylocation.coordinate.latitude)&lng=\(self.mylocation.coordinate.longitude)&keyword=\(string)"
        var request = URLRequest(url: URL(string: "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=f164346d1cedc6d4&range=\(area)&lat=\(self.mylocation.coordinate.latitude)&lng=\(self.mylocation.coordinate.longitude)&keyword=\(string)")!,timeoutInterval: Double.infinity)
        request.addValue("Apifox/1.0.0 (https://apifox.com)", forHTTPHeaderField: "User-Agent")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("webservice.recruit.co.jp", forHTTPHeaderField: "Host")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           guard let data = data else {
              print(String(describing: error))
              semaphore.signal()
              return
           }
            self.Shops.removeAll()
                            
            let parser = XMLParser(data: data)
                            
            parser.delegate = self
                            
            parser.parse()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
                            
            print("success\(String(describing: parser))")
           print(String(data: data, encoding: .utf8)!)
           semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        
    }
    //MARK: TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return wid(100)
      }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.Shops.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell : AddressTableViewCell = tableView.dequeueReusableCell(withIdentifier:NSStringFromClass(AddressTableViewCell.self)) as! AddressTableViewCell
          cell.selectionStyle = .none
          cell.backgroundColor = UIColor.white.withAlphaComponent(0)
          cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0)
          let model = self.Shops[indexPath.row]
          cell.iniCell(model.name,model.address,model.logo_image)
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          let model = self.Shops[indexPath.row]
          let vc = DetailViewController()
          vc.getSearch(model.id)
          self.navigationController?.pushViewController(vc, animated: true)
      }
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
           print("解析: \(elementName)")
        print("元素: \(attributeDict)")

        eName = elementName
        
        if eName == "shop" {
            
            name = ""
        }
        
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("解析完了: \(elementName)")
        if elementName == "shop" {
            let shopModel = ShopModel()
                       
            shopModel.address = address
            shopModel.name = name
            shopModel.id = id
            shopModel.name_kana = name_kana
            shopModel.urls = urls
            shopModel.desc = desc
            shopModel.logo_image = logo_image
                       
            Shops.append(shopModel)
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("キャラクターサーチ: \(string)")
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
                    
            if eName == "address" {
                address = data
                
            } else if eName == "desc" {
                desc = data
                
            } else if eName == "name" {
                if name.count < 2{
                    name = data

                }                
            } else if eName == "id" {
                id = data
                
            } else if eName == "name_kana" {
                name_kana = data
                
            } else if eName == "urls" {
                urls = data
                
            }else if eName == "logo_image" {
                logo_image = data
            }
               
        }

        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("XML解析完了")
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getSearch("5",searchBar.text ?? "")
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        getSearch("5",searchBar.text ?? "")
    }
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
         
        getSearch("5",searchBar.text ?? "")
    }
}
