import BigInt
import Eth
import Foundation

enum Structs {
    struct Bat: Equatable {
        static let schema: ABI.Schema = .tuple([.uint96, .uint160, .array(Cat.schema), .string, .array(.uint256), Cat.schema])

        let a: BigUInt
        let b: BigUInt
        let c: [Cat]
        let d: String
        let e: [BigUInt]
        let f: Cat

        var encoded: Hex {
            asValue.encoded
        }

        var asValue: ABI.Value {
            .tuple6(.uint96(a),
                    .uint160(b),
                    .array(Cat.schema, c.map {
                        $0.asValue
                    }),
                    .string(d),
                    .array(.uint256, e.map {
                        .uint256($0)
                    }),
                    f.asValue)
        }

        static func decode(hex: Hex) throws -> Bat {
            try decodeValue(schema.decode(hex))
        }

        static func decodeValue(_ value: ABI.Value) throws -> Bat {
            switch value {
            case let .tuple6(.uint96(a),
                             .uint160(b),
                             .array(Cat.schema, c),
                             .string(d),
                             .array(.uint256, e),
                             f):
                return try Bat(a: a, b: b, c: c.map {
                    try Cat.decodeValue($0)
                }, d: d, e: e.map {
                    $0.asBigUInt!
                }, f: Cat.decodeValue(f))
            default:
                throw ABI.DecodeError.mismatchedType(value.schema, schema)
            }
        }
    }

    struct Cat: Equatable {
        static let schema: ABI.Schema = .tuple([.int256, .bytes, .bytes32])

        let ca: BigInt
        let cb: Hex
        let cc: Hex

        var encoded: Hex {
            asValue.encoded
        }

        var asValue: ABI.Value {
            .tuple3(.int256(ca),
                    .bytes(cb),
                    .bytes32(cc))
        }

        static func decode(hex: Hex) throws -> Cat {
            try decodeValue(schema.decode(hex))
        }

        static func decodeValue(_ value: ABI.Value) throws -> Cat {
            switch value {
            case let .tuple3(.int256(ca),
                             .bytes(cb),
                             .bytes32(cc)):
                return Cat(ca: ca, cb: cb, cc: cc)
            default:
                throw ABI.DecodeError.mismatchedType(value.schema, schema)
            }
        }
    }

    enum Animal {
        struct Moose: Equatable {
            static let schema: ABI.Schema = .tuple([.uint256])

            let b: BigUInt

            var encoded: Hex {
                asValue.encoded
            }

            var asValue: ABI.Value {
                .tuple1(.uint256(b))
            }

            static func decode(hex: Hex) throws -> Animal.Moose {
                try decodeValue(schema.decode(hex))
            }

            static func decodeValue(_ value: ABI.Value) throws -> Animal.Moose {
                switch value {
                case let .tuple1(.uint256(b)):
                    return Animal.Moose(b: b)
                default:
                    throw ABI.DecodeError.mismatchedType(value.schema, schema)
                }
            }
        }

        struct Rat: Equatable {
            static let schema: ABI.Schema = .tuple([.address])

            let a: EthAddress

            var encoded: Hex {
                asValue.encoded
            }

            var asValue: ABI.Value {
                .tuple1(.address(a))
            }

            static func decode(hex: Hex) throws -> Animal.Rat {
                try decodeValue(schema.decode(hex))
            }

            static func decodeValue(_ value: ABI.Value) throws -> Animal.Rat {
                switch value {
                case let .tuple1(.address(a)):
                    return Animal.Rat(a: a)
                default:
                    throw ABI.DecodeError.mismatchedType(value.schema, schema)
                }
            }
        }
    }

    static let creationCode: Hex = "0x608060405234801561001057600080fd5b50610e24806100206000396000f3fe608060405234801561001057600080fd5b506004361061004c5760003560e01c806358b15a54146100515780636fe03f9914610079578063d7a69d4f14610099578063eedfb21e146100c4575b600080fd5b61006461005f366004610573565b6100e5565b60405190151581526020015b60405180910390f35b61008c610087366004610628565b610134565b60405161007091906106ff565b6100ac6100a7366004610803565b6103c0565b6040516001600160a01b039091168152602001610070565b6100d76100d2366004610ae3565b610414565b604051908152602001610070565b6000805b8351811015610128578284828151811061010557610105610bdd565b6020026020010151600001510361012057600191505061012e565b6001016100e9565b50600090505b92915050565b61017e6040805160c081018252600080825260208083018290526060838501819052808401819052608084018190528451808201865283815291820152928301529060a082015290565b6000826001600160401b03811115610198576101986104c0565b6040519080825280602002602001820160405280156101f057816020015b6101dd60405180606001604052806000815260200160608152602001600080191681525090565b8152602001906001900390816101b65790505b50905060005b838110156102a95760405180606001604052808261021390610c09565b8152602001826001600160401b03811115610230576102306104c0565b6040519080825280601f01601f19166020018201604052801561025a576020820181803683370190505b5081526020017f112233445566778899112233445566778899112233445566778899112233445581525082828151811061029657610296610bdd565b60209081029190910101526001016101f6565b506000836001600160401b038111156102c4576102c46104c0565b6040519080825280602002602001820160405280156102ed578160200160208202803683370190505b50905060005b8481101561032a576103058180610d09565b82828151811061031757610317610bdd565b60209081029190910101526001016102f3565b506040518060c00160405280866001600160601b031681526020016001876103529190610d15565b6001600160601b03166001600160a01b031681526020018381526020016040518060400160405280600581526020016468656c6c6f60d81b8152508152602001828152602001836000815181106103ab576103ab610bdd565b60200260200101518152509250505092915050565b6000805b82518110156101285783600001516001600160a01b03168382815181106103ed576103ed610bdd565b60200260200101516001600160a01b03160361040c575050815161012e565b6001016103c4565b600080826020015183600001516001600160601b03166104349190610d28565b60130b905060005b8360400151518110156104ac578360400151818151811061045f5761045f610bdd565b6020026020010151600001518460400151828151811061048157610481610bdd565b602002602001015160200151516104989190610d5a565b6104a29083610d8a565b915060010161043c565b506104b960011982610db2565b9392505050565b634e487b7160e01b600052604160045260246000fd5b604051602081016001600160401b03811182821017156104f8576104f86104c0565b60405290565b60405160c081016001600160401b03811182821017156104f8576104f86104c0565b604051601f8201601f191681016001600160401b0381118282101715610548576105486104c0565b604052919050565b60006001600160401b03821115610569576105696104c0565b5060051b60200190565b6000806040838503121561058657600080fd5b82356001600160401b0381111561059c57600080fd5b8301601f810185136105ad57600080fd5b803560206105c26105bd83610550565b610520565b82815260059290921b830181019181810190888411156105e157600080fd5b938201935b838510156106195782858a0312156105fe5760008081fd5b6106066104d6565b85358152825293820193908201906105e6565b98969091013596505050505050565b6000806040838503121561063b57600080fd5b50508035926020909101359150565b6000815180845260005b8181101561067057602081850181015186830182015201610654565b506000602082860101526020601f19601f83011685010191505092915050565b8051825260006020820151606060208501526106af606085018261064a565b604093840151949093019390935250919050565b60008151808452602080850194506020840160005b838110156106f4578151875295820195908201906001016106d8565b509495945050505050565b602080825282516001600160601b031682820152828101516001600160a01b031660408084019190915283015160c06060840152805160e0840181905260009291610100600583901b86018101929184019190860190855b818110156107855760ff19888603018352610773858551610690565b94509285019291850191600101610757565b5050505060608501519150601f19808583030160808601526107a7828461064a565b925060808601519150808584030160a08601526107c483836106c3565b925060a08601519150808584030160c0860152506107e28282610690565b95945050505050565b6001600160a01b038116811461080057600080fd5b50565b600080828403604081121561081757600080fd5b60208082121561082657600080fd5b61082e6104d6565b9150843561083b816107eb565b825290925083810135906001600160401b0382111561085957600080fd5b818501915085601f83011261086d57600080fd5b813561087b6105bd82610550565b81815260059190911b8301820190828101908883111561089a57600080fd5b938301935b828510156108c15784356108b2816107eb565b8252938301939083019061089f565b80955050505050509250929050565b80356001600160601b03811681146108e757600080fd5b919050565b80356108e7816107eb565b60006001600160401b03831115610910576109106104c0565b610923601f8401601f1916602001610520565b905082815283838301111561093757600080fd5b828260208301376000602084830101529392505050565b60006060828403121561096057600080fd5b604051606081016001600160401b038282108183111715610983576109836104c0565b816040528293508435835260208501359150808211156109a257600080fd5b508301601f810185136109b457600080fd5b6109c3858235602084016108f7565b602083015250604083013560408201525092915050565b600082601f8301126109eb57600080fd5b813560206109fb6105bd83610550565b82815260059290921b84018101918181019086841115610a1a57600080fd5b8286015b84811015610a595780356001600160401b03811115610a3d5760008081fd5b610a4b8986838b010161094e565b845250918301918301610a1e565b509695505050505050565b600082601f830112610a7557600080fd5b6104b9838335602085016108f7565b600082601f830112610a9557600080fd5b81356020610aa56105bd83610550565b8083825260208201915060208460051b870101935086841115610ac757600080fd5b602086015b84811015610a595780358352918301918301610acc565b600060208284031215610af557600080fd5b81356001600160401b0380821115610b0c57600080fd5b9083019060c08286031215610b2057600080fd5b610b286104fe565b610b31836108d0565b8152610b3f602084016108ec565b6020820152604083013582811115610b5657600080fd5b610b62878286016109da565b604083015250606083013582811115610b7a57600080fd5b610b8687828601610a64565b606083015250608083013582811115610b9e57600080fd5b610baa87828601610a84565b60808301525060a083013582811115610bc257600080fd5b610bce8782860161094e565b60a08301525095945050505050565b634e487b7160e01b600052603260045260246000fd5b634e487b7160e01b600052601160045260246000fd5b6000600160ff1b8201610c1e57610c1e610bf3565b5060000390565b600181815b80851115610c60578160001904821115610c4657610c46610bf3565b80851615610c5357918102915b93841c9390800290610c2a565b509250929050565b600082610c775750600161012e565b81610c845750600061012e565b8160018114610c9a5760028114610ca457610cc0565b600191505061012e565b60ff841115610cb557610cb5610bf3565b50506001821b61012e565b5060208310610133831016604e8410600b8410161715610ce3575081810a61012e565b610ced8383610c25565b8060001904821115610d0157610d01610bf3565b029392505050565b60006104b98383610c68565b8181038181111561012e5761012e610bf3565b6001600160a01b03828116828216818102831692918115828504821417610d5157610d51610bf3565b50505092915050565b80820260008212600160ff1b84141615610d7657610d76610bf3565b818105831482151761012e5761012e610bf3565b8082018281126000831280158216821582161715610daa57610daa610bf3565b505092915050565b600082610dcf57634e487b7160e01b600052601260045260246000fd5b600160ff1b821460001984141615610de957610de9610bf3565b50059056fea264697066735822122093bfa566695c0fc73bd00ecc2d7dcdad59c6a737c51c9158e47dbcb2934478f764736f6c63430008180033"
    static let runtimeCode: Hex = "0x608060405234801561001057600080fd5b506004361061004c5760003560e01c806358b15a54146100515780636fe03f9914610079578063d7a69d4f14610099578063eedfb21e146100c4575b600080fd5b61006461005f366004610573565b6100e5565b60405190151581526020015b60405180910390f35b61008c610087366004610628565b610134565b60405161007091906106ff565b6100ac6100a7366004610803565b6103c0565b6040516001600160a01b039091168152602001610070565b6100d76100d2366004610ae3565b610414565b604051908152602001610070565b6000805b8351811015610128578284828151811061010557610105610bdd565b6020026020010151600001510361012057600191505061012e565b6001016100e9565b50600090505b92915050565b61017e6040805160c081018252600080825260208083018290526060838501819052808401819052608084018190528451808201865283815291820152928301529060a082015290565b6000826001600160401b03811115610198576101986104c0565b6040519080825280602002602001820160405280156101f057816020015b6101dd60405180606001604052806000815260200160608152602001600080191681525090565b8152602001906001900390816101b65790505b50905060005b838110156102a95760405180606001604052808261021390610c09565b8152602001826001600160401b03811115610230576102306104c0565b6040519080825280601f01601f19166020018201604052801561025a576020820181803683370190505b5081526020017f112233445566778899112233445566778899112233445566778899112233445581525082828151811061029657610296610bdd565b60209081029190910101526001016101f6565b506000836001600160401b038111156102c4576102c46104c0565b6040519080825280602002602001820160405280156102ed578160200160208202803683370190505b50905060005b8481101561032a576103058180610d09565b82828151811061031757610317610bdd565b60209081029190910101526001016102f3565b506040518060c00160405280866001600160601b031681526020016001876103529190610d15565b6001600160601b03166001600160a01b031681526020018381526020016040518060400160405280600581526020016468656c6c6f60d81b8152508152602001828152602001836000815181106103ab576103ab610bdd565b60200260200101518152509250505092915050565b6000805b82518110156101285783600001516001600160a01b03168382815181106103ed576103ed610bdd565b60200260200101516001600160a01b03160361040c575050815161012e565b6001016103c4565b600080826020015183600001516001600160601b03166104349190610d28565b60130b905060005b8360400151518110156104ac578360400151818151811061045f5761045f610bdd565b6020026020010151600001518460400151828151811061048157610481610bdd565b602002602001015160200151516104989190610d5a565b6104a29083610d8a565b915060010161043c565b506104b960011982610db2565b9392505050565b634e487b7160e01b600052604160045260246000fd5b604051602081016001600160401b03811182821017156104f8576104f86104c0565b60405290565b60405160c081016001600160401b03811182821017156104f8576104f86104c0565b604051601f8201601f191681016001600160401b0381118282101715610548576105486104c0565b604052919050565b60006001600160401b03821115610569576105696104c0565b5060051b60200190565b6000806040838503121561058657600080fd5b82356001600160401b0381111561059c57600080fd5b8301601f810185136105ad57600080fd5b803560206105c26105bd83610550565b610520565b82815260059290921b830181019181810190888411156105e157600080fd5b938201935b838510156106195782858a0312156105fe5760008081fd5b6106066104d6565b85358152825293820193908201906105e6565b98969091013596505050505050565b6000806040838503121561063b57600080fd5b50508035926020909101359150565b6000815180845260005b8181101561067057602081850181015186830182015201610654565b506000602082860101526020601f19601f83011685010191505092915050565b8051825260006020820151606060208501526106af606085018261064a565b604093840151949093019390935250919050565b60008151808452602080850194506020840160005b838110156106f4578151875295820195908201906001016106d8565b509495945050505050565b602080825282516001600160601b031682820152828101516001600160a01b031660408084019190915283015160c06060840152805160e0840181905260009291610100600583901b86018101929184019190860190855b818110156107855760ff19888603018352610773858551610690565b94509285019291850191600101610757565b5050505060608501519150601f19808583030160808601526107a7828461064a565b925060808601519150808584030160a08601526107c483836106c3565b925060a08601519150808584030160c0860152506107e28282610690565b95945050505050565b6001600160a01b038116811461080057600080fd5b50565b600080828403604081121561081757600080fd5b60208082121561082657600080fd5b61082e6104d6565b9150843561083b816107eb565b825290925083810135906001600160401b0382111561085957600080fd5b818501915085601f83011261086d57600080fd5b813561087b6105bd82610550565b81815260059190911b8301820190828101908883111561089a57600080fd5b938301935b828510156108c15784356108b2816107eb565b8252938301939083019061089f565b80955050505050509250929050565b80356001600160601b03811681146108e757600080fd5b919050565b80356108e7816107eb565b60006001600160401b03831115610910576109106104c0565b610923601f8401601f1916602001610520565b905082815283838301111561093757600080fd5b828260208301376000602084830101529392505050565b60006060828403121561096057600080fd5b604051606081016001600160401b038282108183111715610983576109836104c0565b816040528293508435835260208501359150808211156109a257600080fd5b508301601f810185136109b457600080fd5b6109c3858235602084016108f7565b602083015250604083013560408201525092915050565b600082601f8301126109eb57600080fd5b813560206109fb6105bd83610550565b82815260059290921b84018101918181019086841115610a1a57600080fd5b8286015b84811015610a595780356001600160401b03811115610a3d5760008081fd5b610a4b8986838b010161094e565b845250918301918301610a1e565b509695505050505050565b600082601f830112610a7557600080fd5b6104b9838335602085016108f7565b600082601f830112610a9557600080fd5b81356020610aa56105bd83610550565b8083825260208201915060208460051b870101935086841115610ac757600080fd5b602086015b84811015610a595780358352918301918301610acc565b600060208284031215610af557600080fd5b81356001600160401b0380821115610b0c57600080fd5b9083019060c08286031215610b2057600080fd5b610b286104fe565b610b31836108d0565b8152610b3f602084016108ec565b6020820152604083013582811115610b5657600080fd5b610b62878286016109da565b604083015250606083013582811115610b7a57600080fd5b610b8687828601610a64565b606083015250608083013582811115610b9e57600080fd5b610baa87828601610a84565b60808301525060a083013582811115610bc257600080fd5b610bce8782860161094e565b60a08301525095945050505050565b634e487b7160e01b600052603260045260246000fd5b634e487b7160e01b600052601160045260246000fd5b6000600160ff1b8201610c1e57610c1e610bf3565b5060000390565b600181815b80851115610c60578160001904821115610c4657610c46610bf3565b80851615610c5357918102915b93841c9390800290610c2a565b509250929050565b600082610c775750600161012e565b81610c845750600061012e565b8160018114610c9a5760028114610ca457610cc0565b600191505061012e565b60ff841115610cb557610cb5610bf3565b50506001821b61012e565b5060208310610133831016604e8410600b8410161715610ce3575081810a61012e565b610ced8383610c25565b8060001904821115610d0157610d01610bf3565b029392505050565b60006104b98383610c68565b8181038181111561012e5761012e610bf3565b6001600160a01b03828116828216818102831692918115828504821417610d5157610d51610bf3565b50505092915050565b80820260008212600160ff1b84141615610d7657610d76610bf3565b818105831482151761012e5761012e610bf3565b8082018281126000831280158216821582161715610daa57610daa610bf3565b505092915050565b600082610dcf57634e487b7160e01b600052601260045260246000fd5b600160ff1b821460001984141615610de957610de9610bf3565b50059056fea264697066735822122093bfa566695c0fc73bd00ecc2d7dcdad59c6a737c51c9158e47dbcb2934478f764736f6c63430008180033"

    static let JustANameError = ABI.Function(
        name: "JustAName",
        inputs: []
    )

    static let JustOneArgError = ABI.Function(
        name: "JustOneArg",
        inputs: [.bool]
    )

    enum RevertReason: Equatable, Error {
        case justAName
        case justOneArg(Bool)
        case unknownRevert(String, String)
    }

    static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case (JustANameError, _):
            return .justAName
        case (JustOneArgError, let .tuple1(.bool(var0))):
            return .justOneArg(var0)
        case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
        }
    }

    static let errors: [ABI.Function] = [JustANameError, JustOneArgError]
    static let acceptBatFn = ABI.Function(
        name: "acceptBat",
        inputs: [.tuple([.uint96, .uint160, .array(Cat.schema), .string, .array(.uint256), Cat.schema])],
        outputs: [.int256]
    )

    static func acceptBat(bat: Bat) throws -> Result<BigInt, RevertReason> {
        do {
            let query = try acceptBatFn.encoded(with: [bat.asValue])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors)
            let decoded = try acceptBatFn.decode(output: result)

            switch decoded {
            case let .tuple1(.int256(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, acceptBatFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    static let buildBatFn = ABI.Function(
        name: "buildBat",
        inputs: [.uint256, .uint256],
        outputs: [.tuple([.uint96, .uint160, .array(Cat.schema), .string, .array(.uint256), Cat.schema])]
    )

    static func buildBat(x: BigUInt, y: BigUInt) throws -> Result<Bat, RevertReason> {
        do {
            let query = try buildBatFn.encoded(with: [.uint256(x), .uint256(y)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors)
            let decoded = try buildBatFn.decode(output: result)

            switch decoded {
            case let .tuple1(.tuple6(.uint96(a),
                                     .uint160(b),
                                     .array(Cat.schema, c),
                                     .string(d),
                                     .array(.uint256, e),
                                     f)):
                return try .success(Bat(a: a, b: b, c: c.map {
                    try Cat.decodeValue($0)
                }, d: d, e: e.map {
                    $0.asBigUInt!
                }, f: Cat.decodeValue(f)))
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, buildBatFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    static let lookAtMooseFn = ABI.Function(
        name: "lookAtMoose",
        inputs: [.array(.tuple([.uint256])), .uint256],
        outputs: [.bool]
    )

    static func lookAtMoose(moose: [Animal.Moose], m: BigUInt) throws -> Result<Bool, RevertReason> {
        do {
            let query = try lookAtMooseFn.encoded(with: [.array(Animal.Moose.schema, moose.map {
                $0.asValue
            }), .uint256(m)])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors)
            let decoded = try lookAtMooseFn.decode(output: result)

            switch decoded {
            case let .tuple1(.bool(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, lookAtMooseFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    static let lookAtRatFn = ABI.Function(
        name: "lookAtRat",
        inputs: [.tuple([.address]), .array(.address)],
        outputs: [.address]
    )

    static func lookAtRat(rat: Animal.Rat, holes: [EthAddress]) throws -> Result<EthAddress, RevertReason> {
        do {
            let query = try lookAtRatFn.encoded(with: [rat.asValue, .array(.address, holes.map {
                .address($0)
            })])
            let result = try EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors)
            let decoded = try lookAtRatFn.decode(output: result)

            switch decoded {
            case let .tuple1(.address(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, lookAtRatFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }
}
