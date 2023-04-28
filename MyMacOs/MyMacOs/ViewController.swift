//
//  ViewController.swift
//  MyMacOs
//
//  Created by 王本东 on 2023/3/3.
//

import Cocoa

class ViewController: NSViewController,NSTextFieldDelegate,NSSplitViewDelegate,NSTabViewDelegate {

    // MARK: - 属性
    //NSTextField
    @IBOutlet weak var nameTextField : NSTextField!
    @IBOutlet weak var passwordTextField : NSSecureTextField!
    //Label
    @IBOutlet weak var nameLabel : NSTextField!
    @IBOutlet weak var  passworldLabel : NSTextField!
    //Button
    @IBOutlet weak var loginBtn : NSButton!
    //checkBox
    @IBOutlet weak var  agreeBtn : NSButton!
    //radio Button
    @IBOutlet weak var manBtn : NSButton!
    @IBOutlet weak var womenBtn : NSButton!
    //imageView  视图
    @IBOutlet weak var headImageView : NSImageView!
    //组合框
    @IBOutlet weak var comboBox  : NSComboBox!
    //日期📅
    @IBOutlet weak var dateHorizontalPicker : NSDatePicker!
    @IBOutlet weak var dateVerticalPicker : NSDatePicker!
    //进度条
    @IBOutlet weak var  progress : NSProgressIndicator!
    @IBOutlet weak var  indicator : NSProgressIndicator!  //菊花
    //NSBox 边框  横竖线
    @IBOutlet weak var  lineBox : NSBox!
    //NSTabView  卡片视图
    @IBOutlet weak var tabView :NSTabView!
    
    // NSSplitView  隔离的2 view
    var  mysplitView : NSSplitView!
    //NSWindow
    var windowController: NSWindowController?
    var myWindow : NSWindow!
    
    var progressTimer : Timer!
    
    lazy var sharePopover : NSPopover = {
        let popover = NSPopover()
        let popVC : NSViewController = CustPopView(nibName: "CustPopView", bundle: Bundle.main)
        popover.contentViewController = popVC
//        popover.contentViewController = CustPopView()
        popover.behavior = .transient
        return popover
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allowedUrl = NSURL(fileURLWithPath: "/Users/wangbendong/Desktop/")
        allowedUrl.startAccessingSecurityScopedResource()
        
        
        //点击保存
        let custView = DrawView(frame: NSRect(x: 20, y: 50, width: 200, height: 150))
//        custView.frame(forAlignmentRect: NSRect(x: 0, y: 0, width: 20, height: 10))
        self.view.addSubview(custView)
        
        // MARK: label
//        nameLabel = NSTextField(frame: NSRect(x: 0, y: 0, width: 100, height: 30))
        nameLabel.isEditable = false
        nameLabel.isBezeled = false   //边框
        passworldLabel.stringValue = "密码：\n(数字+字母)"
        
        // MARK: Button
        loginBtn.bezelStyle = .rounded
        loginBtn.title = ".登录."
        loginBtn.target = self
        loginBtn.action = #selector(loginAction(_sender : ))
        
        // MARK: ImageView
        headImageView.wantsLayer = true
        headImageView.layer?.backgroundColor = NSColor.systemGreen.cgColor //背景
        
        // MARK: 组合框
        self.comboBox.bezelStyle = .roundedBezel// 椭圆 .squareBezel  贝塞尔
        let items = ["方案1","方案2","方案3"]
//        self.comboBox.removeAllItems()
        self.comboBox.addItem(withObjectValue: "方案")//单个值
        self.comboBox.addItems(withObjectValues: items)
        self.comboBox.selectItem(at: 5)
        
        // MARK: NSBox
        let boxFrame = NSRect(x: 30, y: 300, width: 940, height: 20)
        lineBox.frame = boxFrame
        // 1.separator垂直或水平分隔线。未与子视图一起使用  选择后变成一根线
        //2.primary 使用标准外观对子视图进行分组。这是默认样式
        //3.custom 自定义框完全基于用户参数绘制
        lineBox.boxType = .custom
        
        let myBox = NSBox(frame: NSRect(x: 30, y: 320, width: 200, height: 60))
        myBox.boxType = .primary
        myBox.title = "Box标题"
        myBox.wantsLayer = true
        myBox.layer?.backgroundColor = NSColor.systemGray.cgColor //背景
        myBox.contentViewMargins = NSSize(width: 0, height: 0) //contentViewMargins 内容视图页边距
        self.view.addSubview(myBox)
        let  boxTexField = NSTextField(frame: NSRect(x: 10, y: 0, width: 80, height: 20))
        myBox.contentView?.addSubview(boxTexField)
        
        // MARK: NSSplitView  隔离的 view
        mysplitView = NSSplitView(frame: NSRect(x: 300, y: 330, width: 200, height: 80))
        mysplitView.isVertical = true
        mysplitView.delegate = self
        mysplitView.dividerStyle = .thick // 1.thick  厚度 2.thin 外壳薄 3.paneSplitter案例窗格拆分器
        self.view.addSubview(mysplitView)
        
        let leftView = NSView(frame: NSRect(x: 0, y:30, width: 100, height: 80)) //view 好像默认被撑满
        leftView.wantsLayer = true
        leftView.layer?.backgroundColor = NSColor.systemGreen.cgColor
        self.mysplitView.addSubview(leftView)
        let rightView = NSView(frame: NSRect(x: 100, y: 0, width: 100, height: 80))
        rightView.wantsLayer = true
        rightView.layer?.backgroundColor = NSColor.systemYellow.cgColor
        self.mysplitView.addSubview(rightView)
        
        // MARK:
//        let item0 : NSTabViewItem = tabView.tabViewItems[0]
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        //MARK: 进度条
        progress.frame = NSMakeRect(loginBtn.frame.minX-32, loginBtn.frame.minY-30, 32, 32)//目前改变不了 宽高
        progress.style = .spinning
        progress.controlSize = .large
        progress.layer?.backgroundColor = NSColor.green.cgColor
//        progress.sizeToFit() //frame大了 自己变小
        
        indicator.frame = NSMakeRect(loginBtn.frame.maxX, loginBtn.frame.minY-30, 40, 40)  //可大可小
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.更新视图（如果已加载）。
        }
    }
    
    // MARK: - 方法
    @IBAction func creatWindow(_sender : NSButton)
    {
        if (myWindow != nil){
            myWindow.makeKeyAndOrderFront(self)
            return
        }
        
        let frame = CGRect(x: 0, y: 0, width: 400, height: 300)
        let style  : NSWindow.StyleMask = [NSWindow.StyleMask.titled , NSWindow.StyleMask.closable,NSWindow.StyleMask.resizable ,NSWindow.StyleMask.miniaturizable]//titled 顶部标题栏边框 closable有关闭按钮  resizable 恢复按钮   miniaturizable 最小化按钮
        myWindow = NSWindow(contentRect: frame, styleMask: style, backing: .buffered, defer: false)//defer  延迟
        myWindow.title = "myWindow 标题"
        myWindow.representedURL = URL(string: "www.baidu.com")
        let headImage = NSImage(named: "50icon")
        myWindow.standardWindowButton(.documentIconButton)?.image = headImage;
        myWindow.isRestorable = true   //是可恢复的
        myWindow.makeKeyAndOrderFront(self)
        myWindow.center()
        
        self.addButtonTitleBar()
    }

    //同意 按钮
    @IBAction func AgreeAction(_sender: NSButton)
    {
        let state = _sender.state;
        print(state == .on ? "同意":"不同意")
    }
    
    //radio Button 单选按钮   必须同一个父视图 才能互斥
    @IBAction func manAndWomen(_sender : NSButton)
    {
        
    }
    
    //添加注册按钮
    func addButtonTitleBar()
    {
        let titleView = myWindow.standardWindowButton(.closeButton)?.superview
        let btn = NSButton()
        let frame = CGRect(x: (myWindow.contentView?.frame.size.width ?? 100) - 100, y: 0, width: 80, height: 24)
        btn.frame = frame
        btn.title = "注册b"
        btn.bezelStyle = .rounded
        titleView?.addSubview(btn)
        
    }
    
    //登录按钮
    @objc func loginAction(_sender : NSButton)
    {
        print("\(_sender.title)按钮  和 ImageView设置")
        
        headImageView.wantsLayer = true
        headImageView.layer?.backgroundColor = NSColor.black.cgColor //背景
        headImageView.layer?.cornerRadius = 20 //圆角
        headImageView.layer?.borderWidth = 2   //边框
        headImageView.layer?.borderColor = NSColor.green.cgColor
        /*
         resizeAspectFill 调整纵横比填充大小
         resizeAspect 调整纵横比大小
         */
        headImageView.layer?.contentsGravity = CALayerContentsGravity.center
        
        /*
         scaleAxesIndependently 填充满
         scaleProportionallyDown （中心）按比例向下
         scaleProportionallyUpOrDown  按比例向上或向下缩放
         */
        headImageView.imageScaling = .scaleProportionallyUpOrDown //等比显示
        
        //进度条
        self.progress.doubleValue+=10  //先执行
        self.indicator.startAnimation(nil)
        progressTimer = Timer(timeInterval: 1.5, repeats: true, block: { neiTimer in
            //1.5后自动执行
            self.progress.doubleValue+=10
            self.indicator.startAnimation(nil)
            if self.progress.doubleValue >= 100{
                self.indicator.stopAnimation(nil)
                self.progressTimer.invalidate()
            }
        })
        RunLoop.main.add(progressTimer, forMode: .common)
        
        //删除
        if self.tabView.tabViewItems.count>0{
            self.tabView.removeTabViewItem(self.tabView.tabViewItems.last!)
//            self.tabView.tabViewItems.remove(at: self.tabView.tabViewItems.count-1)//这个方法有问题
        }
    }
    
    //组合框  选择后方法
    @IBAction func comboBoxAction(_ sender: NSComboBox) {
        let selectIndex = sender.indexOfSelectedItem
        let itemString = sender.stringValue
        print("选择\(selectIndex)  内容是\(itemString)")
    }
    
    //长条日期
    @IBAction func dateHorizontalAction(_ sender: NSDatePicker) {
      let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = formatter.string(from: self.dateHorizontalPicker.dateValue)
        print("横日期：\(date)")
    }
    //方形日期
    @IBAction func dateVerticalAction(_ sender: NSDatePicker) {
        let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = formatter.string(from:sender.dateValue)
          print("方形日期：\(date)")
    }
    //NSSplitView  收缩
    @IBAction func myPlistViewAction(_sender : NSButton)
    {
        let splitViewItems = mysplitView.arrangedSubviews
        let leftView = splitViewItems[0]
        if mysplitView.isSubviewCollapsed(leftView){ //仅左边收缩   不isHidden = true 不认为是收缩
            mysplitView.setPosition(100, ofDividerAt: 0)
            leftView.isHidden = false
        }
        else{
            mysplitView.setPosition(0, ofDividerAt: 0)
            leftView.isHidden = true
        }
        mysplitView.adjustSubviews()//刷新的意思
    }
    //NSPopover
    @IBAction func popMyViewAction(_sender : NSButton)
    {
        sharePopover.show(relativeTo: _sender.bounds, of: _sender, preferredEdge: .minX)//maxY
    }

    // MARK: - 代理
    //NSTextFieldDelegate
    func controlTextDidBeginEditing(_ obj: Notification) {
        print("开始编辑")
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        print("结束编辑")
    }
    
     func controlTextDidChange(_ obj: Notification) {
        let textfield = obj.object as? NSTextField?
         if textfield == nameTextField{
             print("\(nameTextField.stringValue)")
         }
         else if textfield == passwordTextField{
             print("\(passwordTextField.stringValue)")
         }
    }
    
    //NSTabViewDelegate
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
//        print("当前NSTabView视图: \(String(describing: tabViewItem?.label))")
        print("当前NSTabView视图: \(self.tabView.tabViewItems))")
        if tabViewItem?.identifier != nil && tabViewItem?.identifier as! String == "add"{
            let tempTabviewItem = NSTabViewItem()
            tempTabviewItem.label = "临时"
            tempTabviewItem.view = NSView(frame: NSZeroRect)
            self.tabView.addTabViewItem(tempTabviewItem)
        }
        else if tabViewItem?.identifier != nil  && tabViewItem?.identifier as! String == "remove"{
            //删除会 刷新
        }
    }
}

