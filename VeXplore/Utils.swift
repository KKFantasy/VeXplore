//
//  Utils.swift
//  VeXplore
//
//  Copyright © 2016 Jimmy. All rights reserved.
//

//////////////////////////////
////// Data Persistence //////
//////////////////////////////

func pageCacheDirPath() -> String?
{
    if let sysCacheDirPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    {
        let pageCacheDirPath = (sysCacheDirPath as NSString).appendingPathComponent("pagesData")
        var isDir: ObjCBool = false
        let fileManager = FileManager.default
        var dirExists = fileManager.fileExists(atPath: pageCacheDirPath, isDirectory: &isDir)
        do {
            if dirExists == true && isDir.boolValue == false
            {
                try fileManager.removeItem(atPath: pageCacheDirPath)
                dirExists = false
            }
            if dirExists == false
            {
                try fileManager.createDirectory(atPath: pageCacheDirPath, withIntermediateDirectories: false, attributes: nil)
            }
            return pageCacheDirPath
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    return nil
}

func cachePathString(withFilename filename: String) -> String?
{
    var filePath: String? = nil
    if let dirPath = pageCacheDirPath()
    {
        filePath = (dirPath as NSString).appendingPathComponent(filename)
    }
    return filePath
}

func clearPageCache()
{
    if let dirPath = pageCacheDirPath()
    {
        do {
            try FileManager.default.removeItem(atPath: dirPath)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}


////////////////////
////// Others //////
////////////////////

func statusBarHeight() -> CGFloat
{
    let statusBarFrame = UIApplication.shared.statusBarFrame
    return min(statusBarFrame.width, statusBarFrame.height)
}

func versionBuild() -> String
{
    let version = currentVersion()
    let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    return "Version \(version)(\(build))"
}

func currentVersion() -> String
{
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}

// remove user defaults, for test
func removeUserDefaults()
{
    let appDomain = Bundle.main.bundleIdentifier
    UserDefaults.standard.removePersistentDomain(forName: appDomain!)
}
