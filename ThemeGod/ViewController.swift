//
//  ViewController.swift
//  ThemeGod
//
//  Created by Max Nelson on 11/28/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit

class MNTextView:UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        phaseTwo()
    }
    
    init(title:String = "title", text:String = "textview text") {
        super.init(frame: .zero)
        self.text = text
        self.title = title
        self.translatesAutoresizingMaskIntoConstraints = false
        phaseTwo()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    var textView:UITextView = {
        let t = UITextView()
        t.layer.cornerRadius = 12
        t.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        t.textColor = .white
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 15)
        return t
    }()
    
    var label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(customFont: .ProximaNovaRegular, withSize: 20)
        return label
    }()
    
    func phaseTwo() {
        axis = .vertical
        addArrangedSubview(label)
        addArrangedSubview(textView)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 20),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40)
            ])
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
        var distance:CGFloat = 0
        if textView == newBotTagsView.textView {
            distance = 200
        }
        if textView == newTagsView.textView {
            distance = 100
        }
        view.animateView(direction: .up, distance: distance)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        view.animateView(direction: .down, distance: 0)
    }
    @objc func dis() {
        current.resignFirstResponder()
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
    
    var current:UITextView!
    
    var tagsView = MNTextView(title: "all your possible tags", text: "#its #freaking #lit #fam")
    
    var newTagsView = MNTextView(title: "post tags", text: "your post tags appear here")
    
    var newBotTagsView = MNTextView(title: "bot tags", text: "your bot tags appear here")
    
    var shuffleButton:UIButton = {
        let b = UIButton()
        b.setTitle("shuffle them tags boi", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 12
        b.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        b.titleLabel?.textColor = .white
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()

    var label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Tag Shuffler 1.0 son"
        label.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 30)
        return label
    }()
    
    var tags = ["#code", "#coder", "#swiftlang", "#ios", "#iosdeveloper", "#developer", "#programmer", "#programming", "#webdeveloper", "#siliconslopes", "#siliconvalley", "#process", "#habit", "#android", "#java", "#csharp", "#django", "#python #javascript", "#css", "#html", "#web", "#software", "#startup", "#wwdc", "#apple", "#clean", "#minimalistic", "#minimal", "#simple", "#simplicity", "#airpods", "#ikea", "#modern", "#teamapple", "#photography", "#mobilemag", "#visualsoflife", "#utah", "#saltlakecity", "#newyorkcity", "#sanfransisco", "#moodygrams", "#fatalframes", "#worldcode", "#sony", "#bootcamp", "#frontend", "#bootstrap", "#sass", "#inspiration", "#design", "#webdesign", "#workspace", "#digital", "#setup", "#inspiration", "#sublime", "#work", "#hustle", "#grind", "#html5", "#isetups", "#computerscience", "#computer", "#macbookpro", "#mac", "#macbookair", "#website", "#designer", "#illustrator", "#mkbhd", "#freelance", "#quotes", "#motivation", "#codegoals"]
    
    //        var tags0 = ["hi","max"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tagsView.text = tagsToText(tags)
        ui()
    }
    
    func ui() {
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dis)))
        
        view.backgroundColor = UIColor.white
        view.addSubview(stack)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(tagsView)
        stack.addArrangedSubview(newTagsView)
        stack.addArrangedSubview(newBotTagsView)
        stack.addArrangedSubview(shuffleButton)
        
        tagsView.delegate = self
        newTagsView.delegate = self
        newBotTagsView.delegate = self
 
        shuffleButton.addTarget(self, action: #selector(self.shuffle), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.1),
            tagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.3),
            newTagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.25),
            newBotTagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.25),
            shuffleButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
//            shuffleButton.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.1)

            ])
        
        NSLayoutConstraint.activate(stack.getConstraintsTo(view: view, withInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)))
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

