

import UIKit
import WebKit
class H5ViewController: BaseViewController {

    var titleStr : String = ""
    var url : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatHeadeViewString(self.titleStr, andHaveLeft: true, andHaveright: false)
        let web = WKWebView(frame: CGRectMake(0,topHeight,SCREEN_WIDTH, SCREEN_HEIGHT-topHeight))
        web.load(URLRequest(url: URL(string: self.url)!))
        self.view.addSubview(web)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
