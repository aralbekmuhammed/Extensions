import Alamofire
class NetworkManager{
    var queue: DispatchQueue{
        DispatchQueue.global(qos: .userInteractive)
    }
    func getDataFromAPI(url: String,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        headers: HTTPHeaders? = API().authorizationHeader,
                        completionHandler: @escaping(Result<([String:Any], Int),Error>)->()
    ){
        queue.async {
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                DispatchQueue.main.async {
                    switch response.result{
                    case .success(let data):
                        let json = data as! [String:Any]
                        completionHandler(.success((json, response.response!.statusCode)))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            }
        }
    }
    func getDataFromAPIAndDecode<T: Decodable>(url: String,
                                               method: HTTPMethod = .get,
                                               parameters: Parameters? = nil,
                                               headers: HTTPHeaders? = API().authorizationHeader,
                                               decodeModel: T.Type,
                                               completionHandler: @escaping(Result<(T, Int),Errors>)->()){
        queue.async {
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                DispatchQueue.main.async {
                    switch response.result{
                    case .success(let data):
                        do{
                            let serialized = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
                            do{
                                let decoded = try JSONDecoder().decode(decodeModel, from: serialized)
                                completionHandler(.success((decoded,response.response!.statusCode)))
                            }catch(let error){
                                print(error)
                                completionHandler(.failure(Errors.errorWhenParsing))
                            }
                        }catch{
                            completionHandler(.failure(Errors.errorWhenSerializing))
                        }
                    case .failure(let error):
                        completionHandler(.failure(Errors.errorWhenDownloadingData))
                        print(error)
                    }
                }
            }
        }
    }
    func uploadImages(url: String,
                      method: HTTPMethod = .post,
                      images: [[String:UIImage]],
                      headers: HTTPHeaders? = API().authorizationHeader,
                      completionHandler: @escaping(Result<Int,Error>)->()){
        queue.async {
            AF.upload(
                multipartFormData: { multipartFormData in
                    for image in images{
                        for (key, value) in image{
                            guard let jpeg = value.jpegData(compressionQuality: 0.5) else{return}
                            multipartFormData.append(jpeg, withName: key , fileName: "image.jpeg", mimeType: "image/jpeg")
                        }
                    }
                }, to: url, method: method, headers: headers).responseJSON { response in
                    DispatchQueue.main.async {
                        switch response.result{
                        case .success(_):
                            guard let response = response.response else{return}
                            completionHandler(.success(response.statusCode))
                        case .failure(let error):
                            completionHandler(.failure(error))
                        }
                    }
                }
        }
    }
}
