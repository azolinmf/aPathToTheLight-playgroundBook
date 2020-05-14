//
//  CutsceneViewController.swift
//  BookCore
//
//  Created by Maria Fernanda Azolin on 13/05/20.
//

import UIKit

public class CutsceneViewController: UIViewController {
    
    let intro = UIImageView(image: UIImage(named: "introBackground"))
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)

        
        createIntro()
        createFirstPage()
        
        
    }
    
    func createFirstPage() {
        
    }
    
    func createIntro() {
        
        //imports custom fonts
        let cfURL = Bundle.main.url(forResource: "Helios Regular", withExtension: "ttf") as! CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let titleFont = UIFont(name: "Helios Pro", size:  90.0)
        
        let cfURL2 = Bundle.main.url(forResource: "jd_equinox", withExtension: "ttf") as! CFURL
        CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)
        let subtitleFont = UIFont(name: "JD Equinox", size:  60.0)
        
        //creates and adds title
        let title = UITextField(frame: intro.frame)
        title.text = "PATH FINDING ALGORITHMS"
        title.adjustsFontSizeToFitWidth = true
        title.textColor = .white
        title.backgroundColor = .clear
        title.textAlignment = .center
        title.font = titleFont
        
        
        intro.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: intro.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: intro.centerYAnchor),
            title.widthAnchor.constraint(equalTo: intro.widthAnchor, multiplier: 0.9),
            title.heightAnchor.constraint(equalTo: intro.heightAnchor, multiplier: 0.15)
        ])
        
        //creates and adds subtitle
        let subtitle = UITextField(frame: intro.frame)
        subtitle.text = "IN OUTER SPACE"
        subtitle.adjustsFontSizeToFitWidth = true
        subtitle.textColor = .white
        subtitle.backgroundColor = .clear
        subtitle.textAlignment = .center
        subtitle.font = subtitleFont
        
        intro.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitle.centerXAnchor.constraint(equalTo: intro.centerXAnchor),
            subtitle.centerYAnchor.constraint(equalTo: title.centerYAnchor, constant: 100),
            subtitle.widthAnchor.constraint(equalTo: intro.widthAnchor, multiplier: 0.9),
            subtitle.heightAnchor.constraint(equalTo: intro.heightAnchor, multiplier: 0.15)
        ])
        
        
        //creates and adds the view containing the title, subtitle and background
        view.addSubview(intro)
        intro.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            intro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            intro.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            intro.widthAnchor.constraint(equalTo: view.widthAnchor),
            intro.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
    }
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        /*
        switch (page) {
        case 0:
            view4.isHidden = true
            page += 1
        case 1:
            view3.isHidden = true
            page += 1
        case 2:
            view2.isHidden = true
            page += 1
        case 3:
            view1.isHidden = true
            page += 1
        default:
            break;
        }
         */
        
    }

}

/*

 //let view2 = UIView(frame: view.frame)
 //view2.backgroundColor = .red

 view.addSubview(view0)
 view.addSubview(view1)
 view.addSubview(view2)
 view.addSubview(view3)
 view.addSubview(view4)
 //view.addSubview(view2)
 
 view0.translatesAutoresizingMaskIntoConstraints = false

 NSLayoutConstraint.activate([
     view0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     view0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
     view0.widthAnchor.constraint(equalTo: view.widthAnchor),
     view0.heightAnchor.constraint(equalTo: view.heightAnchor)
 ])

 view1.translatesAutoresizingMaskIntoConstraints = false

 NSLayoutConstraint.activate([
     view1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     view1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
     view1.widthAnchor.constraint(equalTo: view.widthAnchor),
     view1.heightAnchor.constraint(equalTo: view.heightAnchor)
 ])
 
 view2.translatesAutoresizingMaskIntoConstraints = false

 NSLayoutConstraint.activate([
     view2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     view2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
     view2.widthAnchor.constraint(equalTo: view.widthAnchor),
     view2.heightAnchor.constraint(equalTo: view.heightAnchor)
 ])
 
 view3.translatesAutoresizingMaskIntoConstraints = false

 NSLayoutConstraint.activate([
     view3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     view3.centerYAnchor.constraint(equalTo: view.centerYAnchor),
     view3.widthAnchor.constraint(equalTo: view.widthAnchor),
     view3.heightAnchor.constraint(equalTo: view.heightAnchor)
 ])
 
 view4.translatesAutoresizingMaskIntoConstraints = false

 NSLayoutConstraint.activate([
     view4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     view4.centerYAnchor.constraint(equalTo: view.centerYAnchor),
     view4.widthAnchor.constraint(equalTo: view.widthAnchor),
     view4.heightAnchor.constraint(equalTo: view.heightAnchor)
 ])
 */


//
//public class CutsceneViewController: UIViewController {
//
//    override public func viewDidLoad() {
//        super.viewDidLoad()
//
//       let titleURL = Bundle.main.url(forResource: "Helios Regular", withExtension: "ttf")
//        CTFontManagerRegisterFontsForURL(titleURL! as CFURL, CTFontManagerScope.process, nil)
//        //let font1 = UIFont(name: "Helios Regular", size: 50)!
//
//        setFirstPage()
//
//
//        //let view2 = UIView(frame: view.frame)
//        //view2.backgroundColor = .red
//
//    }
//
//    func setFirstPage() {
//        let title = UITextView(frame: view.frame)
//        title.font = UIFont(name: "Helios Regular", size: 50)
//
//        view.addSubview(title)
//
//       title.translatesAutoresizingMaskIntoConstraints = false
//
//        let textView = UITextView(frame: CGRect(x: 20.0, y: 90.0, width: 250.0, height: 100.0))
//        self.automaticallyAdjustsScrollViewInsets = false
//
//        textView.center = self.view.center
//        textView.textAlignment = NSTextAlignment.justified
//        textView.textColor = UIColor.blue
//        textView.backgroundColor = UIColor.lightGray
//
//
//        view.addSubview(textView)
//
//
//        let view1 = UIView(frame: view.frame)
//        view1.backgroundColor = .green
//
//        view1.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            view1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            view1.widthAnchor.constraint(equalTo: view.widthAnchor),
//            view1.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//
//        view.addSubview(view1)
//    }
//
//
//}
