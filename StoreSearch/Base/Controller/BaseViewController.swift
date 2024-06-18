

import UIKit


class BaseViewController: UIViewController, UIGestureRecognizerDelegate
{
    
    var base_topView : UIView = UIView.init()
   
    var base_leftBtn : UIButton = UIButton.init()
   
    var base_titleLabel : UILabel = creatLabel(" ",fontSizeSM(16),RBG_Text("#FFFFFF"))
    
    var base_rightBtn : UIButton = UIButton.init()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if self.navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) ?? false
        {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = RBG_Text("#161616")
        // Do any additional setup after loading the view.
    }
   
    func creatHeadeViewString(_ title: String, andHaveLeft isleft: Bool, andHaveright isright: Bool)
    {
        self.base_topView.backgroundColor = UIColor.clear
        self.view.addSubview(self.base_topView)
        self.base_topView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.right.equalTo(self.view)
            make.height.equalTo(topHeight)
        }
        
        if isleft
        {
            self.base_topView.addSubview(self.base_leftBtn)
            self.base_leftBtn.snp.makeConstraints { make in
                make.top.equalTo(( StatusBarHeight + (topHeight - StatusBarHeight - wid(40))/2.0))
                make.size.equalTo(CGSizeMake(wid(52),wid(40)))
                make.left.equalTo(self.base_topView)
            }
            
            let img = UIImageView.init()
            img.image =  UIImage(named: "base_return")?.withTintColor(.black)
            img.tag = 200
            self.base_leftBtn.addSubview(img)
            img.snp.makeConstraints { make in
                make.center.equalTo(self.base_leftBtn)
                make.width.height.equalTo(wid(22))
            }
            self.base_leftBtn.addTarget(self, action: #selector(Base_leftBtnAction), for: .touchUpInside)
        }
        
        self.base_titleLabel.text = title
        self.base_topView.addSubview(self.base_titleLabel)
        self.base_titleLabel.snp.makeConstraints { make in
            make.top.equalTo(StatusBarHeight+(topHeight-StatusBarHeight-self.base_titleLabel.height)/2.0)
            make.centerX.equalTo(self.base_topView)
        }
        
        if isright
        {
            self.base_topView.addSubview(self.base_rightBtn)
            self.base_rightBtn.snp.makeConstraints { make in
                make.top.equalTo(( StatusBarHeight + (topHeight - StatusBarHeight - wid(40))/2.0))
                make.size.equalTo(CGSizeMake(wid(52),wid(40)))
                make.right.equalTo(self.base_topView)
            }
            
            let img = UIImageView.init()
            img.tag = 200
            self.base_rightBtn.addSubview(img)
            img.snp.makeConstraints { make in
                make.center.equalTo(self.base_rightBtn)
                make.width.height.equalTo(wid(22))
                
            }
            self.base_rightBtn.addTarget(self, action: #selector(Base_rightBtnAction), for: .touchUpInside)
        }
    }

    func setBase_RightBtnTitle(_ title: String, titleColor: UIColor, font: UIFont)
    {
        if let img = self.base_rightBtn.viewWithTag(200) as? UIImageView {
            img.alpha = 0
        }
        self.base_rightBtn.setTitle(title, for: .normal)
        self.base_rightBtn.setTitleColor(titleColor, for: .normal)
        self.base_rightBtn.titleLabel?.font = font
        self.base_rightBtn.titleLabel?.sizeToFit()
        let width = wid(65)
        self.base_rightBtn.snp.removeConstraints()
        self.base_rightBtn.snp.makeConstraints { make in
            make.top.height.equalTo(( StatusBarHeight + (topHeight - StatusBarHeight - wid(40))/2.0))
            make.size.equalTo(CGSizeMake(width,wid(40)))
            make.right.equalTo(self.base_topView)
        }
    }

    func setTitle(_ title: String, font: UIFont, color: UIColor)
    {
        self.base_titleLabel.text = title
        self.base_titleLabel.font = font
        self.base_titleLabel.textColor = color
    }
   
    @objc func Base_leftBtnAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func Base_rightBtnAction()
    {
        self.navigationController?.popViewController(animated: true)

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
