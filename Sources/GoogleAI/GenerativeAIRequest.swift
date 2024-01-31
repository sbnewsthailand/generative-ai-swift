// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

@available(iOS 15.0, macOS 11.0, macCatalyst 15.0, *)
protocol GenerativeAIRequest: Encodable {
  associatedtype Response: Decodable

  var url: URL { get }

  var options: RequestOptions { get }
}

/// Configuration parameters for sending requests to the backend.
@available(iOS 15.0, macOS 11.0, macCatalyst 15.0, *)
public struct RequestOptions {
  /// The request’s timeout interval in seconds; if not specified uses the default value for a
  /// `URLRequest`.
  let timeout: TimeInterval?
  /// The API version to use in requests to the backend.
  let apiVersion: String

  /// Asynchronous methods that manipulate the `URLRequest` before being sent.
  /// Similar in concept to
  /// [Event Hooks](https://docs.python-requests.org/en/latest/user/advanced/#event-hooks) in the
  /// Python Requests library.
  let hooks: [(_: inout URLRequest) async throws -> Void]

  /// Initializes a request options object.
  ///
  /// - Parameters:
  ///   - timeout The request’s timeout interval in seconds; if not specified uses the default value
  ///   for a `URLRequest`.
  ///   - apiVersion The API version to use in requests to the backend; defaults to "v1".
  /// - Parameter hooks An array of asynchronous methods that manipulate the `URLRequest` before
  /// being sent (e.g., to add headers); if none specified, the `URLRequest` is unchanged.
  public init(timeout: TimeInterval? = nil, apiVersion: String = "v1",
              hooks: [(_: inout URLRequest) async throws -> Void] = []) {
    self.timeout = timeout
    self.apiVersion = apiVersion
    self.hooks = hooks
  }
}
