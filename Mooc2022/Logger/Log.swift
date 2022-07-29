//
//  Log.swift
//  Mooc2022
//
//  Created by Trieu Le on 25/07/2022.
//

import Foundation

enum Log: String{
    case debug = "[DEBUG]"
    case error = "[ERROR]"
}

#if DEBUG
fileprivate var timeDict:Dictionary = [String: Date]()

fileprivate let dateFormatter:DateFormatter = {
    let dateFormatter = DateFormatter.init()
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
    return dateFormatter
}()
#endif

extension Log {

    func out(_ items: Any..., file: String = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
            let message = "\(dateFormatter.string(from: Date.init())) \(self.rawValue) \((file as NSString).lastPathComponent)[\(line)], \(method): \(items)"
            writeLog(message)
        #endif
    }

    #if DEBUG
    private func writeLog(_ message:String){
        print(message)
        LogFile.instance.write(message: message)
    }
    #endif
}

#if DEBUG
public class LogFile {
    private (set) var logFilename : String

    /// File handle for the log file
    internal var logFileHandle: FileHandle? = nil

    /// Option: whether or not to append to the log file if it already exists
    internal var shouldAppend: Bool

    /// Option: if appending to the log file, the string to output at the start to mark where the append took place
    internal var appendMarker: String?

    /// Option: Attributes to use when creating a new file
    internal var fileAttributes: [FileAttributeKey: Any]? = nil

    static let instance: LogFile = {
        let instance = LogFile(filename: "debug.log.txt")
        return instance
    }()

    init(filename:String, shouldAppend: Bool = true, appendMarker: String? = "----------------"){
        self.logFilename = filename
        self.shouldAppend = shouldAppend
        self.appendMarker = appendMarker
        self.openFile(filename: filename)
    }

    deinit {
        // close file stream if open
        closeFile()
    }

    // MARK: - File Handling Methods
    /// Open the log file for writing.
    ///
    /// - Parameters:   None
    ///
    /// - Returns:  Nothing
    ///
    private func openFile(filename:String) {
        if logFileHandle != nil {
            closeFile()
        }

        let fileManager: FileManager = FileManager.default
        let baseURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let writeToFileURL = baseURL.appendingPathComponent(filename)
        let fileExists: Bool = fileManager.fileExists(atPath: writeToFileURL.path)

        self.logFilename = writeToFileURL.path

        do {
            if !shouldAppend || !fileExists {
                fileManager.createFile(atPath: writeToFileURL.path, contents: nil, attributes: nil)
            }

            logFileHandle = try FileHandle(forWritingTo: writeToFileURL)
            if fileExists && shouldAppend {
                logFileHandle?.seekToEndOfFile()

                if let appendMarker = appendMarker {
                    self.write(message: appendMarker)
                }
            }
        }
        catch let error as NSError {
            print("open log file failure.")
            print(error.description)
            logFileHandle = nil
            return
        }
    }

    /// Close the log file.
    ///
    /// - Parameters:   None
    ///
    /// - Returns:  Nothing
    ///
    private func closeFile(){
        self.write(message: "close log file!!!")
        logFileHandle?.synchronizeFile()
        logFileHandle?.closeFile()
        logFileHandle = nil
    }


    /// Write the log to the log file.
    ///
    /// - Parameters:
    ///     - message:   Formatted/processed message ready for output.
    ///
    /// - Returns:  Nothing
    ///
    func write(message: String) {
        if let encodedData = "\(message)\n".data(using: String.Encoding.utf8, allowLossyConversion: true) {
            self.logFileHandle?.write(encodedData)
            self.logFileHandle?.synchronizeFile()
        }
    }

    func clear(){
        logFileHandle?.truncateFile(atOffset: 0)
    }
}
#endif

import UIKit

extension UIWindow {
    
#if DEBUG
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if event == nil || motion != .motionShake {
            return
        }
        guard let rootViewController = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController else {
            return
        }
        let alert = UIAlertController(title: "Debug Tools", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log View", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            
            let dt = UIStoryboard(name: "LogViewController", bundle: nil)
            let logVC: LogViewController = dt.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
            
            if let presentedViewController = rootViewController.presentedViewController {
                presentedViewController.present(logVC, animated: true, completion: nil)
            } else {
                rootViewController.present(logVC, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: {_ in
            if LoginService.shared.signOut() {
                DispatchQueue.main.async {
                    let loginVC = UINavigationController(rootViewController: LoginViewController())
                    loginVC.setNavigationBarHidden(true, animated: true)
                    UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }?.rootViewController = loginVC
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        if let presentedViewController = rootViewController.presentedViewController {
            presentedViewController.present(alert, animated: true, completion: nil)
        } else {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
#endif
}

