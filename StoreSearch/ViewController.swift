////
////  ViewController.swift
////  StoreSearch
////
////  Created by cmStudent on 2024/6/15.
////
//
//import UIKit
//import Alamofire
//import Foundation
//
// class ViewController: UIViewController,XMLParserDelegate {
//    var Shops: [ShopModel] = []
//
//    var eName: String = ""
//    var address = ""
//    var desc = ""
//    var name = ""
//    var name_kana = ""
//    var urls = ""
//    var id = ""
//    let xmlString = """
//<?xml version="1.0" encoding="UTF-8" ?>
//<results xmlns="http://webservice.recruit.co.jp/HotPepper/">
//    <api_version>1.30</api_version>
//    <results_available>27</results_available>
//    <results_returned>10</results_returned>
//    <results_start>1</results_start>
//    <shop>
//        <address>東京都新宿区細工町1－15</address>
//        <desc>1</desc>
//        <genre>
//            <name>その他グルメ</name>
//        </genre>
//        <id>J003323577</id>
//        <name>ORGANIC DELI GAJYUMAARU オーガニック デリ ガジュマール</name>
//        <name_kana>オーガニック　デリ　ガジュマール</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ003323577/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都渋谷区代官山町19-1　白磁館2Ｆ　Ａ号室</address>
//        <desc>1</desc>
//        <genre>
//            <name>アジア・エスニック料理</name>
//        </genre>
//        <id>J001200157</id>
//        <name>オーガニック&amp;エスニック料理 Vege Holic 代官山</name>
//        <name_kana>おーがにっくあんどえすにっくりょうり　べじほりっく　だいかんやま</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ001200157/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都西多摩郡日の出町平井226-5</address>
//        <desc>1</desc>
//        <genre>
//            <name>カフェ・スイーツ</name>
//        </genre>
//        <id>J001130259</id>
//        <name>Organic Cafe koto-koto</name>
//        <name_kana>オーガニックカフェコトコト</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ001130259/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都渋谷区渋谷２‐８‐４佐野ビル１Ｆ</address>
//        <desc>1</desc>
//        <genre>
//            <name>和食</name>
//        </genre>
//        <id>J000140221</id>
//        <name>オーガニック 鮨 大内</name>
//        <name_kana>おおがにっくすしおおうち</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ000140221/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都中央区八重洲２-2-7 スーパーホテルPremiere東京駅八重洲中央口1階</address>
//        <desc>1</desc>
//        <genre>
//            <name>洋食</name>
//        </genre>
//        <id>J003591001</id>
//        <name>ORGANIC TABLE</name>
//        <name_kana>オーガニックテーブル</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ003591001/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都港区新橋１-５-６ 銀座第3誠和ビル 5F</address>
//        <desc>1</desc>
//        <genre>
//            <name>イタリアン・フレンチ</name>
//        </genre>
//        <id>J001128276</id>
//        <name>オーガニック野菜 × バルkitchen Kampos カンポーズ 銀座店</name>
//        <name_kana>おーがにっくやさいばるきっちんかんぽーずぎんざてん</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ001128276/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都港区白金台４-６-１　東京大学医科学研究所近代医科学記念館</address>
//        <desc>1</desc>
//        <genre>
//            <name>イタリアン・フレンチ</name>
//        </genre>
//        <id>J001128722</id>
//        <name>オーガニックラボカフェ・チャオベッラ</name>
//        <name_kana>おーがにっくらぼかふぇ・ちゃおべっら</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ001128722/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都新宿区三栄町19大河ビル1F</address>
//        <desc>0</desc>
//        <genre>
//            <name>その他グルメ</name>
//        </genre>
//        <id>J001028000</id>
//        <name>Organic　Dining　nic (オーガニック　ダイニング　ニック）</name>
//        <name_kana>おーがにっく　だいにんぐ　にっく</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ001028000/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都中央区銀座5-14-5ダヴィンチB1F</address>
//        <desc>0</desc>
//        <genre>
//            <name>イタリアン・フレンチ</name>
//        </genre>
//        <id>J000863203</id>
//        <name>オーガニック＆チーズ　フレンチレストラン　ジェイズ ガーデン 銀座</name>
//        <name_kana>おーがにっく　ちーず　れんちれすとらん　じぇいず　がーでん　ぎんざ</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ000863203/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//    <shop>
//        <address>東京都中央区東日本橋3-3-17Ｒｅ－Ｋｎｏｗビル５Ｆ</address>
//        <desc>0</desc>
//        <genre>
//            <name>その他グルメ</name>
//        </genre>
//        <id>J000814262</id>
//        <name>オーガニックカフェ ハスハチキッチン</name>
//        <name_kana>おーがにっくかふぇ　はすはちきっちん</name_kana>
//        <urls>
//            <pc>https://www.hotpepper.jp/strJ000814262/?vos=nhppalsa000016</pc>
//        </urls>
//    </shop>
//</results>
//"""
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        var semaphore = DispatchSemaphore (value: 0)
//
//        var request = URLRequest(url: URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=sample&large_area=Z011")!,timeoutInterval: Double.infinity)
//        request.addValue("Apifox/1.0.0 (https://apifox.com)", forHTTPHeaderField: "User-Agent")
//        request.addValue("*/*", forHTTPHeaderField: "Accept")
//        request.addValue("webservice.recruit.co.jp", forHTTPHeaderField: "Host")
//        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
//
//        request.httpMethod = "GET"
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//           guard let data = data else {
//              print(String(describing: error))
//              semaphore.signal()
//              return
//           }
//            
//                            
//            let parser = XMLParser(data: data)
//                            
//            parser.delegate = self
//                            
//            parser.parse()
//                            
//            print("success\(String(describing: parser))")
//           print(String(data: data, encoding: .utf8)!)
//           semaphore.signal()
//        }
//        
//        task.resume()
//        semaphore.wait()
//        
////        getData()
//        // Do any additional setup after loading the view.
//    }
//    func getData() {
//        print("get送信")
//        //api
//        let url = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=f164346d1cedc6d4&large_area=Z011"
//        AF.request(url).responseData(completionHandler: { res in
//            switch res.result {
//                case let .success(Data):
//                
//                let jsonStringx = String(data: Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
//                print(jsonStringx ?? "")
//
//                if let htmlString = String(data: Data, encoding: .utf8) {
//                    print(htmlString)
//                } else {
//                    print("error")
//                }
//                case let .failure(error):
//                    print("error\(error)")
//            }
//        })
//    }
//    
//    
//    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
//           print("解析: \(elementName)")
//        print("元素: \(attributeDict)")
//
//        eName = elementName
//        
//        
//       }
//    
//    
//    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        print("解析完了: \(elementName)")
//        if elementName == "shop" {
//            let shopModel = ShopModel()
//                       
//            shopModel.address = address
//            shopModel.name = name
//            shopModel.id = id
//            shopModel.name_kana = name_kana
//            shopModel.urls = urls
//            shopModel.desc = desc
//                       
//            Shops.append(shopModel)
//        }
//        
//    }
//    
//    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        print("キャラクターサーチ: \(string)")
//        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
//        if (!data.isEmpty) {
//                    
//            if eName == "address" {
//                address += data
//                
//            } else if eName == "desc" {
//                desc += data
//                
//            } else if eName == "name" {
//                name += data
//                
//            } else if eName == "id" {
//                id += data
//                
//            } else if eName == "name_kana" {
//                name_kana += data
//                
//            } else if eName == "urls" {
//                urls += data
//                
//            }
//               
//        }
//
//        
//    }
//    
//    func parserDidEndDocument(_ parser: XMLParser) {
//        print("XML解析完了")
//        
//    }
//
//
//}
//
