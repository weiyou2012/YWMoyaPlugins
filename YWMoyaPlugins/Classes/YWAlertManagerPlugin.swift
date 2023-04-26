import Foundation
import Moya

public protocol TipManagerUIDelegate {
    
    /// This plug-in calls this method when network delays need to be alerted.
    ///
    /// You can set a view to indicate high network latency, such as a rotating circle.
    ///
    func alertProgress()
    
    /// This method is called when you need to hide network latency alerts.
    ///
    /// Hide the view that alerts the network to high latency.
    ///
    func hideProgressAlert()
    
    /// When the network response is successful, this method is called to prompt some information.
    ///
    /// Set up a message prompt view to prompt custom information returned by some services.
    ///
    func alertMessageSuccess(response: Response)
    
    /// When the network fails to respond, call this method to prompt some information.
    ///
    /// Set up a network error alert view to alert the network of error messages.
    ///
    func alertMessageFailure(moyaError: MoyaError)
}

public final class YWAlertManagerPlugin: PluginType {
    private let tipReqKey = "Request—Local-Tip-UUID"
    private var isShowProgress: Bool = false
    private var requestingIdList: [String] = []
    
    public var tipDelegate: TipManagerUIDelegate?
    
    public init() {}
    public init(tipDelegate: TipManagerUIDelegate?) {
        self.tipDelegate = tipDelegate
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let reqId = UUID().uuidString
        var newReq = request
        newReq.addValue(reqId, forHTTPHeaderField: tipReqKey)
        return newReq
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        let id = request.request?.headers.value(for: tipReqKey) ?? ""
        requestingIdList.append(id)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
            if self.requestingIdList.contains(id) && !self.isShowProgress {
                self.tipDelegate?.alertProgress()
                self.isShowProgress = true
            }
        }
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        tipErrorHandler(with: result)
    }
    
    private func tipErrorHandler(with result: Result<Response, MoyaError>) {
        switch result {
        case .success(let response):
            checkToHideProgressTip(with: response)
            tipDelegate?.alertMessageSuccess(response: response)
        case .failure(let moyaError):
            checkToHideProgressTip(with: moyaError.response)
            tipDelegate?.alertMessageFailure(moyaError: moyaError)
        }
    }
    
    private func checkToHideProgressTip(with response: Response?) {
        if let id = response?.request?.value(forHTTPHeaderField: tipReqKey) {
            requestingIdList.removeAll { $0 == id }
        } else {
            requestingIdList.removeAll()
        }
        if requestingIdList.isEmpty {
            tipDelegate?.hideProgressAlert()
            isShowProgress = false
        }
    }
}
