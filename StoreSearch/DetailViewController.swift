//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by cmStudent on 2024/6/16.
//

import UIKit

class DetailViewController: BaseViewController,XMLParserDelegate {

    var Shops: [ShopModel] = []

    var eName: String = ""
    var address = ""
    var desc = ""
    var name = ""
    var name_kana = ""
    var urls = ""
    var id = ""
    var logo_image = ""
    var open = ""

    @IBOutlet weak var iconImg: UIImageView!
    
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var addressL: UILabel!
    
    @IBOutlet weak var timeL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatHeadeViewString("", andHaveLeft: true, andHaveright: false)

        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    func getSearch(_ string:String){
        
        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=f164346d1cedc6d4&id="+string)!,timeoutInterval: Double.infinity)
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
                            
            let parser = XMLParser(data: data)
                            
            parser.delegate = self
                            
            parser.parse()
            
            DispatchQueue.main.async {
                let model = self.Shops.first

                self.iniCell(model?.name ?? "", model?.address ?? "", model?.open ?? "", model?.logo_image ?? "")
            }
                            
            print("success\(String(describing: parser))")
           print(String(data: data, encoding: .utf8)!)
           semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        
    }
    func iniCell(_ title : String,_ address : String,_ time : String,_ url : String)
    {
        self.nameL.text = title
        self.addressL.text = address
        self.timeL.text = time

        self.iconImg.af.setImage(withURL: NSURL(string: url)! as URL)
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
           print("解析: \(elementName)")
        print("元素: \(attributeDict)")

        eName = elementName
        
        
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
            shopModel.open = open
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
                if name.count == 0{
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
            }else if eName == "open" {
                open = data
            }
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        print("XML解析完了")
    }
}
