//
//  AlamofireVC.swift
//  ALPersonalSwiftTool
//
//  Created by Alvin on 2018/12/9.
//  Copyright © 2018年 company. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices

public typealias SwiftClosure = ((_ data: Data?, _ progressValue:Float, _ error: Error?) -> Void)

class AlamofireVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    /**
     *  定义闭包属性,可选类型
     */
    public var callBackClosure : SwiftClosure?
    /**
     *初始化一个data，用来存储下载下来的数据
     */
    private var _responseData: NSMutableData!
    
    var progressView: UIProgressView?
    var progressValue: Float = 0.0
    var imageUrlArray =  ["http://image.nationalgeographic.com.cn/2015/0121/20150121033625957.jpg",
        "http://image.nationalgeographic.com.cn/2017/0703/20170703042329843.jpg",
        "http://image.nationalgeographic.com.cn/2017/0702/20170702124619643.jpg",
        "http://image.nationalgeographic.com.cn/2017/0702/20170702124619643.jpg"]
    
    
    var responseData: NSMutableData!{
        get{
            if _responseData == nil{
                _responseData = NSMutableData()
            }
            return _responseData
        }
        set{
            _responseData = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    @IBAction func AlamofireUploadEvent(_ sender: UIButton) {
//        let urlString = "https://httpbin.org/post"
//        let imageURL = url(forResource: "rainbow", withExtension: "jpg")
//
//        Alamofire.upload(imageURL, to: urlString).validate().responseData{ response in
//            debugPrint(response)
//        }
        
//            let image = UIImage(named: "xxx")
//            //将图片转化为JPEG类型的data 后面的参数是压缩比例
//            let jpegImage = UIImageJPEGRepresentation(image!, 0.5)
//            //要传的参数（比如我们带用户的加密uid）
//            let uid = ["uid" : "user.uid"]
//            //let ecodeUid = EncryptionHelper.getParamsString(uid as [String : AnyObject])
//            let ecodeUid = "ecodeUid"
//            //将参赛转化为data
//            let ecodeData = ecodeUid.data(using: .utf8)
//
//            //全部代码如下
//            Alamofire.upload(multipartFormData: { (multipartFormData) in
//                multipartFormData.append(ecodeData!, withName: "data")
        //第二个参数"data"
        //服务端以这个字段名获取加密的uid(个人以为应该用"uid")
//                multipartFormData.append(jpegImage!, withName: "avatar", fileName: "avatar"+".jpeg", mimeType: "image/jpeg")
        //带一个参数"jpegImage"，就是我们加密的二进制图片流
        //带二个参数"withName"，后台通过西字段来获取图片
        //带三个参数"fileName"，后台检图片类型的，主要是后缀名
        //带四个参数"mimeType"，传输的文件类型。
//            }, to: "https://www.ka5188.com/app/api/v1/user/uploadImg" , encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        if let data = response.data {
//                            let responseJson = JSON(data: data)
//                            if responseJson["status"].intValue == 1 {
//                                //上传成功，刷新当前头像
//                            }
//                        } else {
//                            let msg = responseJson["msg"].stringValue
//                            self.showMessage(msg)
//                        }
//                    }
//                case .failure(let encodingError):
//                log.debug(encodingError)
//                self.showMessage("上传图片失败")
//            }
//        })
    }
    
    @IBAction func alamofireGetEvent(_ sender: UIButton) {
        guard let url = URL(string: "http://www.wangsocial.com:8088/common/upToken")else{
            return;
        }
//        Alamofire.request(url).response{ response in
//            weak var weakSelf = self
//            weakSelf!.printLog(message: response.data ?? "", needTransToJSONString: true)
//        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            print("Progress: \(progress.fractionCompleted)")
        }
        .validate{ requst, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
            //no use
            return .failure(AFError.responseValidationFailed(reason: .dataFileNil))
        }
        .responseJSON { response in
            //debugPrint(response.data!)
            weak var weakSelf = self
            weakSelf!.printLog(message: response.data ?? "", needTransToJSONString: true)
        }
        
    }
    
    @IBAction func alamofirePostEvent(_ sender: UIButton) {
        guard let url = URL(string: "http://www.wangsocial.com:8088/app/idea/feedback?v=3.0.0")else{
            return;
        }
        let parameters = ["content": "feedback test!", "ideaType": "1",  "pictures": ""]
        let Auth_header: [String:String] = ["Accept":"application/json", "Content-Type" : "application/json; charset=utf-8", "Authorization":"Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxNzYxMjg4OTAwNiIsImNyZWF0ZWQiOjE1NDQ0MTQzNTcyMzUsImlkIjoxNTMsImV4cCI6MTU0NTAxOTE1N30.4BKOKd3M25cjdWyzIAyVo3rMN2JTYqBcGHpZ59nxvr_jSAOX-tZ7JoYRNJ4EBXj46vr_uxLNgla5dP9fZPiA6w"]
        //表单请求
        //如果后请求的接收方式是以post时，后台接收方式是以 from 表单时 encoding 一定要为URLEncoding.queryString。不然后台接收不到数据
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.queryString, headers: Auth_header).responseJSON {(DataResponse) in
            weak var weakSelf = self
            weakSelf!.printLog(message: DataResponse.data ?? "", needTransToJSONString: true)
        }
        
        
//        let urlString = "  "
//        let json = "{\"offset\":0,\"limit\":5}"
//        let url = URL(string: urlString)!
//        let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//
//        Alamofire.request(request).responseJSON {
//            (response) in
//            if response.result.isSuccess {
//                let json = JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.mutableContainers)
//            } else {
//
//            }
//        }
        
    }
    
    @IBAction func alamofireDownloadEvent(_ sender: UIButton) {
        //let destination = DownloadRequest.suggestedDownloadDestination()
//        let destination = DownloadRequest.suggestedDownloadDestination(
//            for: .cachesDirectory,
//            in: .userDomainMask
//        )
//        Alamofire.download("http://image.nationalgeographic.com.cn/2017/0703/20170703042329843.jpg", to: destination).response { response in
//            print(response.request as Any)
//            print(response.response as Any)
//            print(response.temporaryURL as Any)
//            print(response.destinationURL as Any)
//            print(response.error as Any)
//        }
        let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL: URL =  directoryURLs[0].appendingPathComponent("testAlamofire.jpg")
        
        
        //let fileURL: URL = URL(fileURLWithPath: "testAlamofire")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
        }
        let parameters: Parameters = ["foo": "bar"]
        
        //let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        let Auth_header: [String:String] = ["Accept":"application/json", "Content-Type" : "application/json; charset=utf-8", "Authorization":"Bearer MyToken"]
        Alamofire.download("http://image.nationalgeographic.com.cn/2017/0703/20170703042329843.jpg", method: .get, parameters: parameters, encoding: JSONEncoding.default, headers:Auth_header, to: destination).downloadProgress(queue:DispatchQueue.global(qos: .utility)){ progress in
            print("Progress: \(progress.fractionCompleted)")
        }.validate { request, response, temporaryURL, destinationURL in
                // Custom evaluation closure now includes file URLs (allows you to parse out error messages if necessary)
            return .success
        }
            //responseString responseJSON
            //
        .responseString { response in
            debugPrint(response)
            print(response.temporaryURL as Any)
            print(response.destinationURL as Any)
        }
    }
    
    @IBAction func downLoadRequest(_ sender: UIButton) {
        self.loadNetImage()
    }
    
    @IBAction func postRequest(_ sender: Any) {
        guard let url = URL(string: "http://www.wangsocial.com:8088/app/idea/feedback?v=3.0.0")else{
            return;
        }
        let parameters = ["content": "feedback test!", "ideaType": "1",  "pictures": ""]
        
        //传递的文件
//        let files = [
//            (
//                name: "file1",
//                path:Bundle.main.path(forResource: "1", ofType: "jpg")!
//            ),
//            (
//                name: "file2",
//                path:Bundle.main.path(forResource: "2", ofType: "png")!
//            )
//        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //分隔线
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type")
        //"token" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxNzYxMjg4OTAwNiIsImNyZWF0ZWQiOjE1NDQ0MTQzNTcyMzUsImlkIjoxNTMsImV4cCI6MTU0NTAxOTE1N30.4BKOKd3M25cjdWyzIAyVo3rMN2JTYqBcGHpZ59nxvr_jSAOX-tZ7JoYRNJ4EBXj46vr_uxLNgla5dP9fZPiA6w"
        request.addValue("Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxNzYxMjg4OTAwNiIsImNyZWF0ZWQiOjE1NDQ0MTQzNTcyMzUsImlkIjoxNTMsImV4cCI6MTU0NTAxOTE1N30.4BKOKd3M25cjdWyzIAyVo3rMN2JTYqBcGHpZ59nxvr_jSAOX-tZ7JoYRNJ4EBXj46vr_uxLNgla5dP9fZPiA6w", forHTTPHeaderField: "Authorization")
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
//            return
//        }
//        request.httpBody = httpBody
        
        request.httpBody = try! createBody(with: parameters, files: [], boundary: boundary)
        
        let session = URLSession.shared
        //let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        session.dataTask(with: request) { (data, response, error) in
            weak var weakSelf = self;
            if let response = response {
                print("response:")
                weakSelf?.printLog(message: response, needTransToJSONString: false)
            }
            
            if let data = data{
                print("data:")
                weakSelf?.printLog(message: (request.urlRequest?.url?.absoluteString ?? "") + ("\nparameters:\(parameters)"))
                weakSelf?.printLog(message: data, needTransToJSONString: true)
//                print(data);
//                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                if json != nil{
//                    print("json:")
//                    print(json as Any)
//                }
            }
        }.resume()
    }
    
    @IBAction func getRequest(_ sender: UIButton) {
        guard let url = URL(string: "http://www.wangsocial.com:8088/common/upToken")else{
            return;
        }
        
        let session = URLSession.shared
        session.dataTask(with: url){(data,response,error) in
            if let response = response {
                print("response:")
                print(response)
            }
            
            if let data = data{
                print("data:")
                print(data);
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if json != nil{
                    print("json:")
                    print(json as Any)
                }
            }
        }.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AlamofireVC{
    
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        self.createProgressView()
    }
    
    func createProgressView(){
        progressView = UIProgressView.init(progressViewStyle: .default)
        progressView?.frame = CGRect(x: 9, y: kNavigationAndStatusBarHeight, width: kScreenW, height: 1)
        progressView?.progressTintColor = UIColor.red
        progressView?.trackTintColor = UIColor.black
        self.view.addSubview(progressView!)
    }
    
    func loadNetImage(){
        self.sessionDownload(imageUrlArray[1], "GET") { (data, progressValue, error) in
            //避免循环引用，weak当对象销毁的时候，对象会被指定为nil
            //weak var weakSelf = self //对象推到，省略了ViewController
            weak var weakSelf : AlamofireVC? = self  //等同与上面的表达式
            DispatchQueue.main.async {
                weakSelf?.progressView?.setProgress(progressValue, animated: true)
                print("------进度打印:\(progressValue)")
                
                if error == nil, data != nil{
                    let image = UIImage(data: data!)
                    weakSelf?.imageView.image = image
                }
            }
        }
    }
    
    func sessionDownload(_ url: String, _ method: String, _ callback: @escaping SwiftClosure){
        callBackClosure = callback
        guard let url = URL(string: url) else {
            return
        }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let loadDataTask = session.dataTask(with: urlRequest)
        loadDataTask.resume()
    }
    
    fileprivate func printLog(message:Any, needTransToJSONString:Bool = false, fileName:String = #file, methodName:String = #function,lineNumber:Int = #line){
        #if DebugType
            var tempMessage:Any = message
            if needTransToJSONString {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: message as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    
                    if let prettyString = String(data: prettyData, encoding: .utf8) {
                        tempMessage = prettyString;
                    }
                } catch {
                    if let string = NSString(data: message as! Data, encoding: String.Encoding.utf8.rawValue) {
                        tempMessage = string;
                    }
                }
            }
        
            print("\n\(fileName)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\n\(tempMessage)");
        #endif
        }
    
    
    //创建表单body
    private func createBody(with parameters: [String: String]?,
                            files: [(name:String, path:String)],
                            boundary: String) throws -> Data {
        var body = Data()
        
        //添加普通参数数据
        if parameters != nil {
            for (key, value) in parameters! {
                // 数据之前要用 --分隔线 来隔开 ，否则后台会解析失败
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        //添加文件数据
        for file in files {
            let url = URL(fileURLWithPath: file.path)
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            let mimetype = mimeType(forPathExtension: url.pathExtension)
            
            // 数据之前要用 --分隔线 来隔开 ，否则后台会解析失败
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; "
                + "name=\"\(file.name)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n") //文件类型
            body.append(data) //文件主体
            body.append("\r\n") //使用\r\n来表示这个这个值的结束符
        }
        
        // --分隔线-- 为整个表单的结束符
        body.append("--\(boundary)--\r\n")
        return body
    }
    //根据后缀获取对应的Mime-Type
    private func mimeType(forPathExtension pathExtension: String) -> String {
        if let id = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue(),
            let contentType = UTTypeCopyPreferredTagWithClass(id, kUTTagClassMIMEType)?.takeRetainedValue()
        {
            return contentType as String
        }
        //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
        return "application/octet-stream"
    }
    
}

extension AlamofireVC: URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    @available(iOS 7.0, *)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void){
        //允许继续加载数据
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //每次获取的data在此拼装
        print("Data......\(data)")
        self.responseData.append(data)
        
        let currentBytes: Float = Float(self.responseData.length)
        let allTotalBytes: Float = Float((dataTask.response?.expectedContentLength)!)
        
        let proValu :Float = Float(currentBytes/allTotalBytes)
        print("----下载进度:------\(proValu*100)%");
        if callBackClosure != nil,((dataTask.response?.expectedContentLength) != nil) {
            //避免循环引用，weak当对象销毁的时候，对象会被指定为nil
            //weak var weakSelf = self //对象推到，省略了ViewController
            weak var weakSelf: AlamofireVC? = self
            DispatchQueue.main.async {
                weakSelf?.callBackClosure!(nil,proValu,nil)
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if callBackClosure != nil, let data = self.responseData {
            weak var weakSelf: AlamofireVC? = self
            DispatchQueue.main.async {
                weakSelf?.callBackClosure!(data as Data, 1.0, nil)
            }
        }
    }
    
    //上传代理方法，监听上传进度
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didSendBodyData bytesSent: Int64, totalBytesSent: Int64,
                    totalBytesExpectedToSend: Int64) {
        //获取进度
        let written = (Float)(totalBytesSent)
        let total = (Float)(totalBytesExpectedToSend)
        let pro = written/total
        print("当前进度：\(pro)")
    }
}

extension AlamofireVC{
    private func url(forResource fileName: String, withExtension ext:String) -> URL {
        let bundle = Bundle(for: AlamofireVC.self)
        return bundle.url(forResource: fileName, withExtension: ext)!
    }
}
