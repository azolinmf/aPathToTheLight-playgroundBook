//
//  CutsceneViewController.swift
//  BookCore
//
//  Created by Maria Fernanda Azolin on 13/05/20.
//

import UIKit

public class CutsceneViewController: UIViewController {

    let view0 = UIImageView(image: UIImage(named: "Page4"))
    let view1 = UIImageView(image: UIImage(named: "Page 3"))
    let view2 = UIImageView(image: UIImage(named: "Page 2"))
    let view3 = UIImageView(image: UIImage(named: "Page 1"))
    let view4 = UIImageView(image: UIImage(named: "Page 0"))
    
    var page = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)

    
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
        
        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
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
        
    }

}


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
