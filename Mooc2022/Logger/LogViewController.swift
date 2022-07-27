//
//  LogViewController.swift
//  Mooc2022
//
//  Created by Trieu Le on 25/07/2022.
//

#if DEBUG
import UIKit

class LogViewController: UIViewController {

    @IBOutlet weak var tvLog: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        tvLog.attributedText = loadLog()
    }
    
    @IBAction func btnSharePressed(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [self.tvLog.text ?? ""], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func btnClearPressed(_ sender: Any) {
        LogFile.instance.clear()
        tvLog.attributedText = loadLog()
    }


    @IBAction func btnClosePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func loadLog() -> NSAttributedString {
        let readHandler = FileHandle(forReadingAtPath: LogFile.instance.logFilename)
        guard let data = readHandler?.readDataToEndOfFile(),
              let readString = String(data: data, encoding: String.Encoding.utf8) else {
            return NSAttributedString(string: "")
        }
        if  readString.count > 0 {
            let attributedString = NSMutableAttributedString(string: readString)
            var searchedRange = readString.range(of: readString)
            var currentErrorRange = readString.range(of: Log.error.rawValue, options: .literal, range: searchedRange, locale: nil)
            while let range = currentErrorRange {

                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:1.0, green:0.149, blue:0.0, alpha:1.0), range: NSRange(range, in: readString))
                attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value:UIColor(red:0.999, green:0.986, blue:0.0, alpha:1.0), range: NSRange(range, in: readString))
                
                searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange!.upperBound))
                currentErrorRange = readString.range(of: Log.error.rawValue, options: .literal, range: searchedRange, locale: nil)
            }
            return attributedString
        } else {
            let attributedString = NSAttributedString(string: "👌🏻", attributes:[NSAttributedString.Key.font:UIFont(name:"AppleColorEmoji", size:40.0)!])
            return attributedString
        }
    }
}
#endif
