//  This file was automatically generated and should not be edited.

import Apollo

/// Possible order statuses
public enum OrderStatus: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case `open`
  case complete
  case expired
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "open": self = .open
      case "complete": self = .complete
      case "expired": self = .expired
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .open: return "open"
      case .complete: return "complete"
      case .expired: return "expired"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: OrderStatus, rhs: OrderStatus) -> Bool {
    switch (lhs, rhs) {
      case (.open, .open): return true
      case (.complete, .complete): return true
      case (.expired, .expired): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

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

public final class CheckInMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CheckIn($order: ID, $amountToCheckIn: Int!, $shortID: Int) {\n  checkIn(order: $order, orderShortID: $shortID, amountToCheckIn: $amountToCheckIn) {\n    __typename\n    buyer\n    checkIns\n    completelyCheckedIn\n    qrCode\n    quantity\n    status\n  }\n}"

  public var order: GraphQLID?
  public var amountToCheckIn: Int
  public var shortID: Int?

  public init(order: GraphQLID? = nil, amountToCheckIn: Int, shortID: Int? = nil) {
    self.order = order
    self.amountToCheckIn = amountToCheckIn
    self.shortID = shortID
  }

  public var variables: GraphQLMap? {
    return ["order": order, "amountToCheckIn": amountToCheckIn, "shortID": shortID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("checkIn", arguments: ["order": GraphQLVariable("order"), "orderShortID": GraphQLVariable("shortID"), "amountToCheckIn": GraphQLVariable("amountToCheckIn")], type: .object(CheckIn.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(checkIn: CheckIn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "checkIn": checkIn.flatMap { (value: CheckIn) -> ResultMap in value.resultMap }])
    }

    public var checkIn: CheckIn? {
      get {
        return (resultMap["checkIn"] as? ResultMap).flatMap { CheckIn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "checkIn")
      }
    }

    public struct CheckIn: GraphQLSelectionSet {
      public static let possibleTypes = ["Order"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("buyer", type: .scalar(String.self)),
        GraphQLField("checkIns", type: .nonNull(.scalar(Int.self))),
        GraphQLField("completelyCheckedIn", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("qrCode", type: .scalar(String.self)),
        GraphQLField("quantity", type: .nonNull(.scalar(Int.self))),
        GraphQLField("status", type: .nonNull(.scalar(OrderStatus.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(buyer: String? = nil, checkIns: Int, completelyCheckedIn: Bool, qrCode: String? = nil, quantity: Int, status: OrderStatus) {
        self.init(unsafeResultMap: ["__typename": "Order", "buyer": buyer, "checkIns": checkIns, "completelyCheckedIn": completelyCheckedIn, "qrCode": qrCode, "quantity": quantity, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var buyer: String? {
        get {
          return resultMap["buyer"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "buyer")
        }
      }

      public var checkIns: Int {
        get {
          return resultMap["checkIns"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "checkIns")
        }
      }

      public var completelyCheckedIn: Bool {
        get {
          return resultMap["completelyCheckedIn"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "completelyCheckedIn")
        }
      }

      public var qrCode: String? {
        get {
          return resultMap["qrCode"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "qrCode")
        }
      }

      public var quantity: Int {
        get {
          return resultMap["quantity"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "quantity")
        }
      }

      public var status: OrderStatus {
        get {
          return resultMap["status"]! as! OrderStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }
    }
  }
}

public final class GetEventsQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetEvents {\n  currentUser {\n    __typename\n    events(last: 30) {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          title\n          startDate\n          endDate\n          id\n        }\n      }\n    }\n  }\n}"

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
              GraphQLField("endDate", type: .nonNull(.scalar(Int.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String? = nil, startDate: Int, endDate: Int, id: GraphQLID) {
              self.init(unsafeResultMap: ["__typename": "Event", "title": title, "startDate": startDate, "endDate": endDate, "id": id])
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

            public var endDate: Int {
              get {
                return resultMap["endDate"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endDate")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }
          }
        }
      }
    }
  }
}