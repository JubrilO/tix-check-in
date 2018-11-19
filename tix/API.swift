//  This file was automatically generated and should not be edited.

import Apollo

public final class SignInMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation SignIn($email: String!, $password: String!) {\n  signIn(email: $email, password: $password) {\n    __typename\n    authenticationToken\n  }\n}"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("signIn", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(SignIn.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(signIn: SignIn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "signIn": signIn.flatMap { (value: SignIn) -> ResultMap in value.resultMap }])
    }

    public var signIn: SignIn? {
      get {
        return (resultMap["signIn"] as? ResultMap).flatMap { SignIn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "signIn")
      }
    }

    public struct SignIn: GraphQLSelectionSet {
      public static let possibleTypes = ["AuthType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("authenticationToken", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(authenticationToken: String) {
        self.init(unsafeResultMap: ["__typename": "AuthType", "authenticationToken": authenticationToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var authenticationToken: String {
        get {
          return resultMap["authenticationToken"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "authenticationToken")
        }
      }
    }
  }
}

public final class GetEventsQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetEvents {\n  currentUser {\n    __typename\n    events(last: 30) {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          title\n          startDate\n        }\n      }\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("currentUser", type: .object(CurrentUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(currentUser: CurrentUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "currentUser": currentUser.flatMap { (value: CurrentUser) -> ResultMap in value.resultMap }])
    }

    public var currentUser: CurrentUser? {
      get {
        return (resultMap["currentUser"] as? ResultMap).flatMap { CurrentUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "currentUser")
      }
    }

    public struct CurrentUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("events", arguments: ["last": 30], type: .object(Event.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(events: Event? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "events": events.flatMap { (value: Event) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var events: Event? {
        get {
          return (resultMap["events"] as? ResultMap).flatMap { Event(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "events")
        }
      }

      public struct Event: GraphQLSelectionSet {
        public static let possibleTypes = ["EventConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "EventConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["EventEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "EventEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Event"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("startDate", type: .nonNull(.scalar(Int.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String? = nil, startDate: Int) {
              self.init(unsafeResultMap: ["__typename": "Event", "title": title, "startDate": startDate])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var title: String? {
              get {
                return resultMap["title"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            public var startDate: Int {
              get {
                return resultMap["startDate"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startDate")
              }
            }
          }
        }
      }
    }
  }
}