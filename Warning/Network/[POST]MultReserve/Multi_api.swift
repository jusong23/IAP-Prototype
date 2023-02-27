//
//  Reserve.swift
//  Warning
//
//  Created by 이주송 on 2022/09/25.
//

import Foundation


// MARK: - [POST] 열람실 좌석 다중 예약하기
class postMultiReserve{
    func reserve (token:String, data:Array<Any>) {
        let Testurl = URL(string: "https://api.pgh268400.duckdns.org/api/reserves")!

        
        // Array<Any>로 받아온 data를 Datum_MultiRequest 여기다 넣어줘야함

        var RequestArray:Array<Any> = [
//            Datum_MultiRequest(roomNum: 1, sheetNum: 33),
//            Datum_MultiRequest(roomNum: 1, sheetNum: 1),
//            Datum_MultiRequest(roomNum: 1, sheetNum: 31)
        ]
        
        for i in 0..<data.count {
            RequestArray.append(data[i])
        }
        
        print("--0--")
        print(data)
        print("--0--")
        
        var cardInfo = MultiRequest(token: token, data: RequestArray as! [Datum_MultiRequest])

            guard let jsonData = try? JSONEncoder().encode(cardInfo) else {
                print("error: cannot encode data")
                return
            }
            print(jsonData)

            var request1 = URLRequest(url: Testurl)
            request1.httpMethod = "POST"
            request1.setValue("application/json", forHTTPHeaderField: "Content-Type")

            request1.httpBody = jsonData

            URLSession.shared.dataTask(with: request1) { (data, response, error) in
                guard error == nil else {
                    print("error at first")
                    print(error)
                    return
                }

                guard let data = data else {
                    print("error at data")
                    return
                }

                guard let response = response else {
                    print("error at response")
                    return
                }

                do { // 요청 O 응답 O
                    let decoder = JSONDecoder()
                    // json 객체에서 data 유형의 인스턴스로 디코딩하는 객체! Decodable, Codable 프로토콜을 준수하는 라인!
                    let result = try decoder.decode(MultiRequest.self, from: data)

                    print(result)
                }


                catch {
                    print("error while print json")
                }

            }.resume()
        }

}
