
import UIKit

import AVFoundation

import Photos

import UserNotifications

import SnapKit

let App_Delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let APP_WID : NSInteger = 1

let APP_Name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")

let APP_Version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")

let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.size.height

let ISIphoneX : Bool = ((UIScreen.main.bounds.size.height/UIScreen.main.bounds.size.width)>=2.16)

let StatusBarHeight : CGFloat = {
    var statusBarHeight: CGFloat = 0
    if #available(iOS 13.0, *) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let statusBarManager = windowScene?.statusBarManager
        statusBarHeight = statusBarManager?.statusBarFrame.height ?? 0
    } else {
        statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
}()

let tabbarHeight : CGFloat = (ISIphoneX ? 83.0 : 49.0)

let topHeight : CGFloat = (SCREEN_HEIGHT >= 812.0 ? 88 : 64)

let bottomSafe : CGFloat = (ISIphoneX ? 34 : 0)

func isLogin() -> Bool
{
   return UserDefaults.standard.bool(forKey: "isLogin")
}

func getHeightForLabel(_ str : String,andFont font:UIFont,andWidth width:CGFloat) -> CGFloat
{
    let label = UILabel.init(frame: CGRectMake(0,0,width,0))
    label.text = str
    label.font = font
    label.numberOfLines = 0
    label.sizeToFit()
    return label.height
}

func getWidthForLabel(_ str : String,andFont font:UIFont,andHeight height:CGFloat) -> CGFloat
{
    let label = UILabel.init(frame: CGRectMake(0,0,0,height))
    label.text = str
    label.font = font
    label.numberOfLines = 1
    label.sizeToFit()
    return label.width
}

func getAttHeightForLabel(_ str : NSAttributedString,andFont font:UIFont,andWidth width:CGFloat) -> CGFloat
{
    let label = UITextView.init(frame: CGRectMake(0,0,width,0))
    label.attributedText = str
    label.font = font
    label.sizeToFit()
    return label.height
}

func showHintInfoWithString(_ infoStr:String){
    var view : UIView
    if keyWindow()?.viewWithTag(20200) != nil {
        view = (keyWindow()?.viewWithTag(20200))!
        view.layer.removeAllAnimations()
        view.removeFromSuperview()
    }
    view = UIView.init(frame:CGRectMake(0,-topHeight,SCREEN_WIDTH,topHeight))
    view.backgroundColor =  RBG_Text("#333333")
    view.tag = 20200
    let label = creatLabel(infoStr,fontSizeR(16),RBG_Text("#FFFFFF"))
    label.numberOfLines = 0
    label.textAlignment = .center
    label.width = SCREEN_WIDTH-wid(72);
    label.sizeToFit()
    view.addSubview(label)
    let width = label.width+wid(16)*2
    let height = label.height+wid(12)*2
    view.frame = CGRectMake((SCREEN_WIDTH-width)/2.0,SCREEN_HEIGHT-height-wid(29),width,height)
    label.frame = view.bounds
    view.layer.masksToBounds = true
    view.layer.cornerRadius = wid(16)
    view.alpha = 1
    keyWindow()?.addSubview(view)
    UIView.animate(withDuration: 0.3, delay: 2) {
        view.alpha = 0
    }completion: { finished in
        if(finished)
        {
            view.subviews.forEach{ subview in
                subview.removeFromSuperview()
            }
            view.layer.removeAllAnimations()
            view.removeFromSuperview()
        }
    }
}

func keyWindow() -> UIWindow? {
    if #available(iOS 13.0, *) {
        
        for scene in UIApplication.shared.connectedScenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows {
                    if window.isKeyWindow {
                        return window
                    }
                }
            }
        }
    } else {
        
        for window in UIApplication.shared.windows {
            if window.isKeyWindow {
                return window
            }
        }
    }
    return nil
}

func haveCameraPermissions() -> Bool{
    let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    if authStatus == .denied || authStatus == .restricted{
        return false
    }else{
        return true
    }
}
func havePhotoPermission() -> Bool{
    let library : PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    if library == .denied || library == .restricted{
        return false
    }else{
        return true
    }
}


func creatLabel(text:String,fontSize:UIFont,color:UIColor,isMore:Bool) -> UILabel{
   let label = UILabel.init()
    label.text = text
    label.font = fontSize
    label.textColor = color
    label.numberOfLines = (isMore ? 0 : 1)
    label.sizeToFit()
    return label
}
func creatLabel(_ str:String,_ font:UIFont,_ color : UIColor) -> UILabel{
    let label = UILabel.init();
    label.font = font;
    label.text = str;
    label.textColor = color;
    label.sizeToFit();
    return label
}

func navy(_ y:CGFloat) -> CGFloat{
    return StatusBarHeight+(topHeight-StatusBarHeight-y)/2.0
}

func wid(_ x:CGFloat) -> CGFloat{
    return (x*(SCREEN_WIDTH/375.0))
}

func hig(_ y:CGFloat) -> CGFloat{
    return (y*(SCREEN_HEIGHT/812.0))
}

func RBG(_ r:CGFloat,_ b:CGFloat,_ g:CGFloat) -> UIColor{
    return RBGA(r,b,g,1)
}
func RBGA(_ r:CGFloat,_ b:CGFloat,_ g:CGFloat,_ a:CFloat) -> UIColor{
    return UIColor.init(red: r/255.0, green: b/255.0, blue: g/255.0, alpha: CGFloat(a))
}
func RBG_Text(_ str:String) -> UIColor {
    return RBG_TextA(str,1);
}
func RBG_TextA(_ str:String,_ alp:CGFloat) -> UIColor {
    var colorString = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    if colorString.count < 6 {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    if colorString.hasPrefix("0x") || colorString.hasPrefix("0X"){
        colorString = (colorString as NSString).substring(from: 2)
    }
    if colorString.hasPrefix("#") {
        colorString = (colorString as NSString).substring(from: 1)
    }
    if colorString.count < 6 {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    var rang = NSRange()
    rang.location = 0
    rang.length = 2
    if colorString.count == 6 {
        let rString = (colorString as NSString).substring(with: rang)
        rang.location = 2
        let gString = (colorString as NSString).substring(with: rang)
        rang.location = 4
        let bString = (colorString as NSString).substring(with: rang)

        var r:UInt64 = 0, g:UInt64 = 0,b: UInt64 = 0
        
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: alp)
    } else{
        let aString = (colorString as NSString).substring(with: rang)
        rang.location = 2
        let rString = (colorString as NSString).substring(with: rang)
        rang.location = 4
        let gString = (colorString as NSString).substring(with: rang)
        rang.location = 6
        let bString = (colorString as NSString).substring(with: rang)
        
        var r:UInt64 = 0, g:UInt64 = 0,b: UInt64 = 0, a: UInt64 = 0
                  
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)

        Scanner(string: aString).scanHexInt64(&a)
                  
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        let alp = CGFloat(a) / 255.0
       return  UIColor.init(red: red, green: green, blue: blue, alpha: alp)
    }
}

func daysInMonth(year: Int, month: Int) -> Int {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = 1
    let calendar = Calendar.current
    if let date = calendar.date(from: components),
       let range = calendar.range(of: .day, in: .month, for: date) {
           return range.count
    }
    return 0
}

func fontSizeR(_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.init(name: "PingFangSC-Regular", size: x) ?? UIFont.systemFont(ofSize: x);
}
func fontSizeSM(_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.init(name: "PingFangSC-Semibold", size: x) ?? UIFont.systemFont(ofSize: x);
}
func fontSizeM(_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.init(name: "PingFangSC-Medium", size: x) ?? UIFont.systemFont(ofSize: x);
}
func fontSizeRound(_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.init(name: "YouSheBiaoTiYuan", size: x) ?? UIFont.systemFont(ofSize: x);
}
func BoladFontSize(_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.boldSystemFont(ofSize: x)
}

func showAlert(_ title : String,_ connect : String){
    let alert = UIAlertController(title: title, message: connect, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    keyWindow()?.rootViewController?.present(alert, animated: true)
}

func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

func isString(_ str: Any?) -> String {
    if str is NSNull {
        return ""
    } else if let str = str as? String {
        return str
    } else {
        return ""
    }
}

func isArray(_ arr: Any?) -> [Any] {
    if arr is NSNull {
        return []
    } else if let arr = arr as? [Any] {
        return arr
    } else {
        return []
    }
}

func isDic(_ dic: Any?) -> [String: Any] {
    if dic is NSNull {
        return [:]
    } else if let dic = dic as? [String: Any] {
        return dic
    } else {
        return [:]
    }
}

func imageToBase64(image: UIImage) -> String {
    let imageData: Data = image.pngData() ?? Data()  // 也可以使用 image.jpegData(compressionQuality: 1.0) 来获取 JPEG 数据
    let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
    return base64String
}

func base64ToImage(base64String: String) -> UIImage {
    guard let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
        return UIImage()
    }
    guard let image = UIImage(data: data) else {
        return UIImage()
    }
    return image
}


extension UIView{
    
    var origin:CGPoint{
        get{
            return self.frame.origin
        }
        set(newValue){
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }
    }
    var size:CGSize {
        get {
            return self.frame.size
        }
        set(newValue) {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    var width:CGFloat{
        get{
            return self.frame.size.width
        }
        set(newValue) {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    var height:CGFloat{
        get{
            return self.frame.size.height
        }
        set(newValue){
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    var right:CGFloat {
        get {
            return (self.frame.origin.x + self.frame.size.width)
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.x = (newValue - self.frame.size.width)
            self.frame = rect
        }
    }
    
    var bottom:CGFloat {
        get {
            return (self.frame.origin.y + self.frame.size.height)
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = (newValue - self.frame.size.height)
            self.frame = rect
        }
    }
    
    func removeAllSubs(){
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }

    func layer(radius:CGFloat, borderWidth:CGFloat, borderColor:UIColor) -> Void
    {
        if (0.0 < radius)
        {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
        if (0.0 < borderWidth)
        {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

}
