//
//  ViewController.swift
//  ThemeGod
//
//  Created by Max Nelson on 11/28/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class MNTextView:UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    init(title:String = "title", text:String = "textview text", icon:FAType, pasteIcon:FAType, pasteVisible:Bool = false,colors:[CGColor] = [UIColor.grayDient.cgColor, UIColor.appleBlue.withAlphaComponent(0.5).cgColor]) {
        super.init(frame: .zero)
        self.text = text
        self.title = title
        self.icon = icon
        self.pasteIcon = pasteIcon
        self.pasteOrNah = pasteVisible
        self.translatesAutoresizingMaskIntoConstraints = false
        phaseTwo()
    }
    
    //grayDient && appleBlue.withAlphaComponent(0.5)
    var colors:[CGColor] = [UIColor.white.cgColor, UIColor.white.cgColor]
//  [UIColor(rgb: 0xFFFFFF).cgColor, UIColor.grayDient.cgColor]
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pasteOrNah:Bool = false
    
    var delegate:UITextViewDelegate {
        get {
            return textView.delegate!
        }
        set {
            textView.delegate = newValue
        }
    }
    
    var text:String {
        get {
            return textView.text
        }
        set {
            textView.text = newValue
        }
    }
    
    var title:String {
        get {
            return label.text!
        }
        set {
            label.text = newValue.lowercased()
        }
    }
    
    var icon:FAType {
        get {
            return .FACopy
        }
        set {
            button.setFAIcon(icon: newValue, forState: .normal)
        }
    }
    var pasteIcon:FAType {
        get {
            return .FAPaste
        }
        set {
            paste.setFAIcon(icon: newValue, forState: .normal)
        }
    }
    
    var button:UIButton = {
        let b = UIButton()
        b.setFATitleColor(color: UIColor.appleBlue)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var paste:UIButton = {
        let b = UIButton()
        b.setFATitleColor(color: UIColor.appleBlue)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var textView:UITextView = {
        let t = UITextView()
        t.layer.cornerRadius = 12
        t.backgroundColor = UIColor.textbg.withAlphaComponent(0)
        t.textColor = UIColor.darkGray
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 15)
        return t
    }()
    
    var label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 22)
        return label
    }()
    
    var stack:UIStackView = {
       let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        return s
    }()

    func phaseTwo() {

        let g = gradientView(colors:colors)
        g.layer.cornerRadius = 12
        g.addDropShadowToView()
        
        axis = .vertical
        stack.addSubview(g)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(paste)
        stack.addArrangedSubview(button)
        stack.setCustomSpacing(20, after: button)
        paste.addTarget(self, action: #selector(self.pasteToTextView), for: .touchUpInside)
        button.addTarget(self, action: #selector(self.copyToClipBoard), for: .touchUpInside)
        addArrangedSubview(stack)
        addArrangedSubview(textView)
        NSLayoutConstraint.activate([
            g.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            g.leftAnchor.constraint(equalTo: self.leftAnchor),
            g.rightAnchor.constraint(equalTo: self.rightAnchor),
            g.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40),
            
            stack.heightAnchor.constraint(equalToConstant: 20),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40),
            
            paste.widthAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 20),
            label.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -60)
            ])
        
        if !pasteOrNah {
            paste.removeFromSuperview()
            textView.isUserInteractionEnabled = false
            textView.isUserInteractionEnabled = false
        }
    }
    
    @objc func copyToClipBoard() {
        animate()
        UIPasteboard.general.string = textView.text
    }
    
    @objc func pasteToTextView() {
        if let string = UIPasteboard.general.string {
            animate()
            self.textView.text = string
        } else {
            self.textView.text = "nothing to copy"
        }
    }
    
    func animate() {
        self.textView.isUserInteractionEnabled = false
        self.button.isUserInteractionEnabled = false
        self.paste.isUserInteractionEnabled = false
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                self.textView.alpha = 0.6
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {
                self.textView.alpha = 1
            })
        }) { (false) in
            self.textView.isUserInteractionEnabled = true
            self.button.isUserInteractionEnabled = true
            self.paste.isUserInteractionEnabled = true
        }
    }
    
}

class Logic {
    static func randomize(_ arr:[String], limit: Int) -> [String] {
        var r:[String] = []
        var usedIndexes:[Int] = []
        var remaining = limit
        while remaining != 0 {
            var strPlaced:Bool = false
            while !strPlaced {
                let randIndex = Int(arc4random_uniform(UInt32(arr.count)))
                if !usedIndexes.contains(randIndex) {
                    let str = arr[randIndex]
                    if str != "" {
                        usedIndexes.append(randIndex)
                        r.append(str)
                        strPlaced = true
                    }
                }
            }
            remaining -= 1
        }
        return r
    }
}



extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        current = textView
        var distance:CGFloat = -15
        if textView == newBotTagsView.textView {
            distance = 200
        }
        if textView == newTagsView.textView {
            distance = 115
        }
    
        UIView.animate(withDuration: 0.4) {
            var t = CGAffineTransform.identity
            t = t.scaledBy(x: 1.025, y: 1.025)
            self.current.superview?.transform = t
            self.view.transform = CGAffineTransform(translationX: 0, y: distance)
        }

        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.4) {
            var t = CGAffineTransform.identity
            t = t.scaledBy(x: 1, y: 1)
            self.current.superview?.transform = t
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        
    }
    @objc func dis() {
        current.resignFirstResponder()
    }
}

class gradientView:UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    init(colors:[CGColor] = [UIColor(rgb: 0xFFFFFF).cgColor, UIColor.grayDient.cgColor]) {
        super.init(frame: .zero)
        self.colors = colors
        self.translatesAutoresizingMaskIntoConstraints = false
        phaseTwo()
    }
    
    var colors:[CGColor] = [UIColor(rgb: 0xFFFFFF).cgColor, UIColor.grayDient.cgColor]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var layerColors:[CGColor] {
        set {
            if let laya = self.layer as? CAGradientLayer {
                laya.colors = newValue
                laya.locations = [0.0, 1.0]
            }
        }
        get {
            return [ UIColor(rgb: 0xFFFFFF).cgColor, UIColor.grayDient.cgColor ]
        }
    }
    
    func phaseTwo() {
        if let laya = self.layer as? CAGradientLayer {
            //yellowgreenishbluefade            laya.colors = [ UIColor(rgb: 0x82D15C).cgColor, UIColor(rgb: 0x11C2D3).cgColor ]
            laya.colors = self.colors
            laya.locations = [0.0, 1.5]
        }
    }
}


class ViewController: UIViewController {

    var stack:UIStackView = {
        let stack = UIStackView() 
        stack.spacing = 10
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var topStack:UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        return s
    }()
    
    var current:UITextView = UITextView()
    
    var tagsView = MNTextView(title: "all your possible tags", text: "#its #freaking #lit #fam", icon: .FACopy, pasteIcon: .FAPaste, pasteVisible: true)
    
    var newTagsView = MNTextView(title: "post tags", text: "your post tags appear here", icon: .FACopy, pasteIcon: .FAPaste)
    
    var newBotTagsView = MNTextView(title: "bot tags", text: "your bot tags appear here", icon: .FACopy, pasteIcon: .FAPaste)
    
    var shuffleButton:UIButton = {
        let b = UIButton()
        b.setTitle("Shuffle Tags", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 3
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        b.backgroundColor = UIColor.init(red: 14, green: 122, blue: 254)
        b.titleLabel?.textColor = .white
        b.addDropShadowToView()
        return b
    }()

    var label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "ShuffleTag"
        label.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 32)
        return label
    }()
    
    var reset:UIButton = {
        let b = UIButton()
        b.setFATitleColor(color: UIColor.init(red: 14, green: 122, blue: 254))
        b.setFAIcon(icon: .FAUndo, iconSize: 30, forState: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    var maxsTags = ["#code", "#coder", "#swiftlang", "#ios", "#iosdeveloper", "#developer", "#programmer", "#programming", "#webdeveloper", "#siliconslopes", "#siliconvalley", "#process", "#habit", "#android", "#java", "#csharp", "#django", "#python #javascript", "#css", "#html", "#web", "#software", "#startup", "#wwdc", "#apple", "#clean", "#minimalistic", "#minimal", "#simple", "#simplicity", "#airpods", "#ikea", "#modern", "#teamapple", "#photography", "#mobilemag", "#visualsoflife", "#utah", "#saltlakecity", "#newyorkcity", "#sanfransisco", "#moodygrams", "#fatalframes", "#worldcode", "#sony", "#bootcamp", "#frontend", "#bootstrap", "#sass", "#inspiration", "#design", "#webdesign", "#workspace", "#digital", "#setup", "#inspiration", "#sublime", "#work", "#hustle", "#grind", "#html5", "#isetups", "#computerscience", "#computer", "#macbookpro", "#mac", "#macbookair", "#website", "#designer", "#illustrator", "#mkbhd", "#freelance", "#quotes", "#motivation", "#codegoals"]
    
    var defaultTags = ["#put","#your","#hashtags","#in","#here","#like","#this","#then","#hit","#shuffle","#tags","#below","#this","#will","#generate","#30","#randomized","#hashtags","#from","#this","#list","#instagram","#only","#lets","#you","#post","#up","#to","#30","#hashtags","#on","#your","#pics","#so","#this","#app","#will","#help","#you","#quickly","#and","#easily","#randomly","#choose","#30","#hashtags","#from","#your","#given","#list","#this","#is","#super","#helpful","#if","#you","#want","#to","#mix","#up","#your","#hashtags","#every","#nowandthen"]
  
    var tags:[String] = []
    
    //        var tags0 = ["hi","max"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tags = defaultTags
        let g = gradientView(colors: [UIColor(rgb: 0xFFFFFF).cgColor, UIColor.darkPurp.cgColor])
        view.addSubview(g)
        NSLayoutConstraint.activate(g.getConstraintsTo(view: view, withInsets: .zero))
        tagsView.text = tagsToText(tags)
        ui()
    }
    
    func ui() {
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dis)))
        
        view.addSubview(stack)
        topStack.addArrangedSubview(label)
        topStack.addArrangedSubview(reset)
        topStack.setCustomSpacing(20, after: reset)
        stack.addArrangedSubview(topStack)
        stack.addArrangedSubview(tagsView)
        stack.addArrangedSubview(newTagsView)
        stack.addArrangedSubview(newBotTagsView)
        stack.addArrangedSubview(shuffleButton)
        
        tagsView.delegate = self
        newTagsView.delegate = self
        newBotTagsView.delegate = self
 
        shuffleButton.addTarget(self, action: #selector(self.shuffle), for: .touchUpInside)
        reset.addTarget(self, action: #selector(self.resetAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            reset.widthAnchor.constraint(equalTo: topStack.heightAnchor, constant: -32),
            label.widthAnchor.constraint(lessThanOrEqualTo: topStack.widthAnchor),
            
            topStack.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.1),
            tagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.3),
            newTagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.25),
            newBotTagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.25),
            shuffleButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            ])
        
        NSLayoutConstraint.activate(stack.getConstraintsTo(view: view, withInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)))
    }
    
    @objc func resetAction() {
        tags = defaultTags
        tagsView.text = tagsToText(tags)
        newTagsView.text = "your post tags appear here"
        newBotTagsView.text = "your bot tags appear here"
    }
    
    @objc func shuffle() {
        //you can't include more than 5 @ mentions in a single comment.
        //You can't include more than 30 hashtags in a single comment.             <------------ THIS fam.
        //You can't post the same comment multiple times (including emoji)
        tags = textToTags(tagsView.text)
        let shuffled = Logic.randomize(tags, limit: 30)
        newTagsView.text = tagsToText(shuffled)
        newBotTagsView.text = tagsToArrayString(shuffled)
    }
    
    func tagsToArrayString(_ arr:[String]) -> String {
        var tagsWithCommas:String = ""
        for tag in arr {
            let index = tag.index(tag.startIndex, offsetBy: 1)
            tagsWithCommas += String(tag[index...])
            if arr.index(of: tag) != (arr.count-1) {
                tagsWithCommas += ", "
            }
        }
        let template = "tags = [\(tagsWithCommas)]"
        return template
    }
    
    func textToTags(_ text:String) -> [String] {
        return text.components(separatedBy: " ")
    }
    
    func tagsToText(_ arr:[String]) -> String {
        var newString:String = ""
        for element in arr {
            newString += element + " "
        }
        return newString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

