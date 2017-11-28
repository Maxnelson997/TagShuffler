//
//  ViewController.swift
//  ThemeGod
//
//  Created by Max Nelson on 11/28/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit

class Logic {
    static func randomize(_ arr:[String]) -> [String] {
        var r:[String] = arr
        var usedIndexes:[Int] = []
        for str in arr {
            var strPlaced:Bool = false
            while !strPlaced {
                let randomIndex = Int(arc4random_uniform(UInt32(arr.count)))
                if !usedIndexes.contains(randomIndex) {
                    r[randomIndex] = str
                    usedIndexes.append(randomIndex)
                    strPlaced = true
                }
            }
            
        }
        return r
    }
}

class ViewController: UIViewController {
    
    var stack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var tagsView:UITextView = {
        let t = UITextView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    var newTagsView:UITextView = {
        let t = UITextView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    var shuffleButton:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 12
        b.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        return b
    }()
    
    var tags = ["#code", "#coder", "#swiftlang", "#ios", "#iosdeveloper", "#developer", "#programmer", "#programming", "#webdeveloper", "#siliconslopes", "#siliconvalley", "#process", "#habit", "#android", "#java", "#csharp", "#django", "#python #javascript", "#css", "#html", "#web", "#software", "#startup", "#wwdc", "#apple", "#clean", "#minimalistic", "#minimal", "#simple", "#simplicity", "#airpods", "#ikea", "#modern", "#teamapple", "#photography", "#mobilemag", "#visualsoflife", "#utah", "#saltlakecity", "#newyorkcity", "#sanfransisco", "#moodygrams", "#fatalframes", "#worldcode", "#sony", "#bootcamp", "#frontend", "#bootstrap", "#sass", "#inspiration", "#design", "#webdesign", "#workspace", "#digital", "#setup", "#inspiration", "#sublime", "#work", "#hustle", "#grind", "#html5", "#isetups", "#computerscience", "#computer", "#macbookpro", "#mac", "#macbookair", "#website", "#designer", "#illustrator", "#mkbhd", "#freelance", "#quotes", "#motivation", "#codegoals"
    ]
    
    //        var tags0 = ["hi","max"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tagsView.text = tagsToText(tags)
        ui()
    }
    
    func ui() {
        view.addSubview(stack)
        stack.addArrangedSubview(tagsView)
        stack.addArrangedSubview(newTagsView)
        stack.addArrangedSubview(shuffleButton)
        shuffleButton.addTarget(self, action: #selector(self.shuffle), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            tagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.35),
            newTagsView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.35)
            ])
        
        NSLayoutConstraint.activate(stack.getConstraintsTo(view: view, withInsets: UIEdgeInsets(top: 60, left: 10, bottom: 20, right: 10)))
    }
    
    @objc func shuffle() {
        tags = textToTags(tagsView.text)
        let shuffled = Logic.randomize(tags)
        newTagsView.text = tagsToText(shuffled)
    }
    
    func textToTags(_ text:String) -> [String] {
        let nsText = text as NSString
        let arr = nsText.components(separatedBy: "\n")
        return arr
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

