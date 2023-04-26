import Foundation
import Moya

public struct YWLogPlugin: PluginType {
    
    public init() {}
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let resp):
            logInfo(resp: resp)
        case .failure(let error):
            if let resp = error.response {
                self.logInfo(resp: resp)
            }
            #if DEBUG
            print("\n--[\(currtTimeStr)]----YW--Moya--Log--------------")
            print("-Response Error:\n - Request Url: \(target.baseURL.absoluteString + target.path)\n - Message: \(error.localizedDescription)")
            #endif
        }
    }
    
    private func logInfo(resp: Response) {
        #if DEBUG
        var reqInfo = "\n-Request:\n"
        var respInfo = "-Response:\n"
        guard let req = resp.request else {
            return
        }
        
        if let url = req.url {
            reqInfo += "- \(url.absoluteString)\n"
        }
        
        if let method = req.method {
            reqInfo += "- \(method.rawValue)\n"
        }
        
        if let headerData = try? JSONSerialization.data(withJSONObject: req.headers.dictionary, options: .prettyPrinted),
           let headersStr = String(data: headerData, encoding: .utf8)
        {
            reqInfo += "- httpHeaders: \(headersStr)\n"
        } else {
            reqInfo += "- httpHeaders: {}\n"
        }
        
        if let reqData = req.httpBody, let s = reqData.prettyPrintedJSON {
            reqInfo += "- httpBody: \(s)\n"
        }
        
        respInfo += "- \(resp.statusCode)\n"
        
        if let dataStr = resp.data.prettyPrintedJSON {
            respInfo += " - \(dataStr)\n"
        }
        print("--[\(currtTimeStr)]----YW--Moya--Log--------------")
        print(reqInfo + "\n" + respInfo)
        #endif
    }
    
    private var currtTimeStr: String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSSS"
        return dformatter.string(from: Date())
    }
    
}

extension Data {
    var prettyPrintedJSON: String? {
        guard
            let jsonData = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
            let jd = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted),
            let dataStr = String(data: jd, encoding: .utf8)
        else {
            return nil
        }
        return dataStr
    }
}
