//
//  MultipartFormData.swift
//  MastodonSwift
//
//  Created by Marcus Kida on 31.10.22.
//

import Foundation

extension Data {
    
    func getMultipartFormDataBuilder(withBoundary boundary: String) -> MultipartFormDataBuilder? {
        return MultipartFormDataBuilder(data: self, boundary: boundary)
    }
    
    struct MultipartFormDataBuilder {
        private let boundary: String
        private var httpBody = NSMutableData()
        
        private let data: Data

        fileprivate init(data: Data, boundary: String) {
            self.data = data
            self.boundary = boundary
        }

        func addTextField(named name: String, value: String) -> Self {
            httpBody.append(textFormField(named: name, value: value))
            return self
        }

        private func textFormField(named name: String, value: String) -> String {
            var fieldString = "--\(boundary)\r\n"
            fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
            fieldString += "Content-Type: text/plain; charset=UTF-8\r\n"
            fieldString += "\r\n"
            fieldString += "\(value)\r\n"

            return fieldString
        }

        func addDataField(named name: String, data: Data, mimeType: String) -> Self {
            httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
            return self
        }

        private func dataFormField(named name: String, data: Data, mimeType: String) -> Data {
            let fieldData = NSMutableData()

            fieldData.append("--\(boundary)\r\n")
            fieldData.append("Content-Disposition: form-data; name=\"\(name)\"\r\n")
            fieldData.append("Content-Type: \(mimeType)\r\n")
            fieldData.append("\r\n")
            fieldData.append(data)
            fieldData.append("\r\n")

            return fieldData as Data
        }
        
        func build() -> Data {
//            var request = URLRequest(url: url)
//
//            request.httpMethod = "POST"
//            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//            httpBody.append(string: "--\(boundary)--")
//            request.httpBody = httpBody as Data
            return httpBody as Data
        }
    }
}

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
