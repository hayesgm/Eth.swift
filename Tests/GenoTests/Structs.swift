// Generated from swift run Geno ./Tests/Solidity/out/Structs.sol/Structs.json --outDir Tests/GenoTests
@preconcurrency import BigInt
@preconcurrency import Eth
import Foundation

public enum Structs {
    public struct Bat: Equatable {
        public static let schema: ABI.Schema = .tuple([.uint96, .uint160, .array(Cat.schema), .string, .array(.uint256), Cat.schema])

        public let a: BigUInt
        public let b: BigUInt
        public let c: [Cat]
        public let d: String
        public let e: [BigUInt]
        public let f: Cat

        public init(a: BigUInt, b: BigUInt, c: [Cat], d: String, e: [BigUInt], f: Cat) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
            self.f = f
        }

        public var encoded: Hex {
            asValue.encoded
        }

        public var asValue: ABI.Value {
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

        public static func decode(hex: Hex) throws -> Bat {
            if let value = try? schema.decode(hex) {
                return try decodeValue(value)
            }
            // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
            if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
                return try decodeValue(wrappedValue)
            }
            // retry original to throw the error
            return try decodeValue(schema.decode(hex))
        }

        public static func decodeValue(_ value: ABI.Value) throws -> Bat {
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

    public struct Cat: Equatable {
        public static let schema: ABI.Schema = .tuple([.int256, .bytes, .bytes32])

        public let ca: BigInt
        public let cb: Hex
        public let cc: Hex

        public init(ca: BigInt, cb: Hex, cc: Hex) {
            self.ca = ca
            self.cb = cb
            self.cc = cc
        }

        public var encoded: Hex {
            asValue.encoded
        }

        public var asValue: ABI.Value {
            .tuple3(.int256(ca),
                    .bytes(cb),
                    .bytes32(cc))
        }

        public static func decode(hex: Hex) throws -> Cat {
            if let value = try? schema.decode(hex) {
                return try decodeValue(value)
            }
            // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
            if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
                return try decodeValue(wrappedValue)
            }
            // retry original to throw the error
            return try decodeValue(schema.decode(hex))
        }

        public static func decodeValue(_ value: ABI.Value) throws -> Cat {
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

    public enum Animal {
        public struct Goose: Equatable {
            public static let schema: ABI.Schema = .tuple([.uint256, .string])

            public let b: BigUInt
            public let c: String

            public init(b: BigUInt, c: String) {
                self.b = b
                self.c = c
            }

            public var encoded: Hex {
                asValue.encoded
            }

            public var asValue: ABI.Value {
                .tuple2(.uint256(b),
                        .string(c))
            }

            public static func decode(hex: Hex) throws -> Animal.Goose {
                if let value = try? schema.decode(hex) {
                    return try decodeValue(value)
                }
                // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
                if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
                    return try decodeValue(wrappedValue)
                }
                // retry original to throw the error
                return try decodeValue(schema.decode(hex))
            }

            public static func decodeValue(_ value: ABI.Value) throws -> Animal.Goose {
                switch value {
                case let .tuple2(.uint256(b),
                                 .string(c)):
                    return Animal.Goose(b: b, c: c)
                default:
                    throw ABI.DecodeError.mismatchedType(value.schema, schema)
                }
            }
        }

        public struct Moose: Equatable {
            public static let schema: ABI.Schema = .tuple([.uint256])

            public let b: BigUInt

            public init(b: BigUInt) {
                self.b = b
            }

            public var encoded: Hex {
                asValue.encoded
            }

            public var asValue: ABI.Value {
                .tuple1(.uint256(b))
            }

            public static func decode(hex: Hex) throws -> Animal.Moose {
                if let value = try? schema.decode(hex) {
                    return try decodeValue(value)
                }
                // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
                if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
                    return try decodeValue(wrappedValue)
                }
                // retry original to throw the error
                return try decodeValue(schema.decode(hex))
            }

            public static func decodeValue(_ value: ABI.Value) throws -> Animal.Moose {
                switch value {
                case let .tuple1(.uint256(b)):
                    return Animal.Moose(b: b)
                default:
                    throw ABI.DecodeError.mismatchedType(value.schema, schema)
                }
            }
        }

        public struct Rat: Equatable {
            public static let schema: ABI.Schema = .tuple([.address])

            public let a: EthAddress

            public init(a: EthAddress) {
                self.a = a
            }

            public var encoded: Hex {
                asValue.encoded
            }

            public var asValue: ABI.Value {
                .tuple1(.address(a))
            }

            public static func decode(hex: Hex) throws -> Animal.Rat {
                if let value = try? schema.decode(hex) {
                    return try decodeValue(value)
                }
                // both versions are valid encodings of tuples with dynamic fields ( bytes or string ), so try both decodings
                if case let .tuple1(wrappedValue) = try? ABI.Schema.tuple([schema]).decode(hex) {
                    return try decodeValue(wrappedValue)
                }
                // retry original to throw the error
                return try decodeValue(schema.decode(hex))
            }

            public static func decodeValue(_ value: ABI.Value) throws -> Animal.Rat {
                switch value {
                case let .tuple1(.address(a)):
                    return Animal.Rat(a: a)
                default:
                    throw ABI.DecodeError.mismatchedType(value.schema, schema)
                }
            }
        }
    }

    public static let creationCode: Hex = "0x6080604052348015600f57600080fd5b506110068061001f6000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c8063314ded701461006757806358b15a54146100855780636fe03f99146100a8578063ac8dd3a4146100c8578063d7a69d4f146100dd578063eedfb21e14610108575b600080fd5b61006f610129565b60405161007c9190610685565b60405180910390f35b61009861009336600461074b565b6101ae565b604051901515815260200161007c565b6100bb6100b6366004610807565b6101fd565b60405161007c9190610898565b6100d0610489565b60405161007c9190610987565b6100f06100eb3660046109cc565b61053f565b6040516001600160a01b03909116815260200161007c565b61011b610116366004610cb3565b610593565b60405190815260200161007c565b60408051600180825281830190925260609160009190816020015b6040805180820190915260008152606060208201528152602001906001900390816101445790505090508060008151811061018157610181610dc5565b60200260200101516040516020016101999190610987565b60405160208183030381529060405291505090565b6000805b83518110156101f157828482815181106101ce576101ce610dc5565b602002602001015160000151036101e95760019150506101f7565b6001016101b2565b50600090505b92915050565b6102476040805160c081018252600080825260208083018290526060838501819052808401819052608084018190528451808201865283815291820152928301529060a082015290565b6000826001600160401b0381111561026157610261610698565b6040519080825280602002602001820160405280156102b957816020015b6102a660405180606001604052806000815260200160608152602001600080191681525090565b81526020019060019003908161027f5790505b50905060005b83811015610372576040518060600160405280826102dc90610df1565b8152602001826001600160401b038111156102f9576102f9610698565b6040519080825280601f01601f191660200182016040528015610323576020820181803683370190505b5081526020017f112233445566778899112233445566778899112233445566778899112233445581525082828151811061035f5761035f610dc5565b60209081029190910101526001016102bf565b506000836001600160401b0381111561038d5761038d610698565b6040519080825280602002602001820160405280156103b6578160200160208202803683370190505b50905060005b848110156103f3576103ce8180610ef4565b8282815181106103e0576103e0610dc5565b60209081029190910101526001016103bc565b506040518060c00160405280866001600160601b0316815260200160018761041b9190610f00565b6001600160601b03166001600160a01b031681526020018381526020016040518060400160405280600581526020016468656c6c6f60d81b81525081526020018281526020018360008151811061047457610474610dc5565b60200260200101518152509250505092915050565b604080518082018252600080825260606020830152825160018082528185019094529192909190816020015b6040805180820190915260008152606060208201528152602001906001900390816104b5579050509050604051806040016040528060048152602001635553444360e01b8152508160008151811061050f5761050f610dc5565b6020026020010151602001819052508060008151811061053157610531610dc5565b602002602001015191505090565b6000805b82518110156101f15783600001516001600160a01b031683828151811061056c5761056c610dc5565b60200260200101516001600160a01b03160361058b57505081516101f7565b600101610543565b600080826020015183600001516001600160601b03166105b39190610f13565b60130b905060005b83604001515181101561062b57836040015181815181106105de576105de610dc5565b6020026020010151600001518460400151828151811061060057610600610dc5565b602002602001015160200151516106179190610f44565b6106219083610f74565b91506001016105bb565b5061063860011982610f94565b9392505050565b6000815180845260005b8181101561066557602081850181015186830182015201610649565b506000602082860101526020601f19601f83011685010191505092915050565b602081526000610638602083018461063f565b634e487b7160e01b600052604160045260246000fd5b604051602081016001600160401b03811182821017156106d0576106d0610698565b60405290565b60405160c081016001600160401b03811182821017156106d0576106d0610698565b604051601f8201601f191681016001600160401b038111828210171561072057610720610698565b604052919050565b60006001600160401b0382111561074157610741610698565b5060051b60200190565b6000806040838503121561075e57600080fd5b82356001600160401b0381111561077457600080fd5b8301601f8101851361078557600080fd5b803561079861079382610728565b6106f8565b8082825260208201915060208360051b8501019250878311156107ba57600080fd5b6020840193505b828410156107f657602084890312156107d957600080fd5b6107e16106ae565b843581528252602093840193909101906107c1565b976020969096013596505050505050565b6000806040838503121561081a57600080fd5b50508035926020909101359150565b805182526000602082015160606020850152610848606085018261063f565b604093840151949093019390935250919050565b600081518084526020840193506020830160005b8281101561088e578151865260209586019590910190600101610870565b5093949350505050565b60208152600060e082016001600160601b03845116602084015260018060a01b036020850151166040840152604084015160c06060850152818151808452610100860191506101008160051b870101935060208301925060005b818110156109235760ff1987860301835261090e858551610829565b945060209384019392909201916001016108f2565b505050506060840151838203601f19016080850152610942828261063f565b9150506080840151601f198483030160a0850152610960828261085c565b91505060a0840151601f198483030160c085015261097e8282610829565b95945050505050565b6020815281516020820152600060208301516040808401526109ac606084018261063f565b949350505050565b6001600160a01b03811681146109c957600080fd5b50565b60008082840360408112156109e057600080fd5b60208112156109ee57600080fd5b506109f76106ae565b8335610a02816109b4565b8152915060208301356001600160401b03811115610a1f57600080fd5b8301601f81018513610a3057600080fd5b8035610a3e61079382610728565b8082825260208201915060208360051b850101925087831115610a6057600080fd5b6020840193505b82841015610a8b578335610a7a816109b4565b825260209384019390910190610a67565b809450505050509250929050565b80356001600160601b0381168114610ab057600080fd5b919050565b8035610ab0816109b4565b6000806001600160401b03841115610ada57610ada610698565b50601f8301601f1916602001610aef816106f8565b915050828152838383011115610b0457600080fd5b828260208301376000602084830101529392505050565b600060608284031215610b2d57600080fd5b604051606081016001600160401b0381118282101715610b4f57610b4f610698565b6040528235815290508060208301356001600160401b03811115610b7257600080fd5b8301601f81018513610b8357600080fd5b610b9285823560208401610ac0565b602083015250604083013560408201525092915050565b600082601f830112610bba57600080fd5b8135610bc861079382610728565b8082825260208201915060208360051b860101925085831115610bea57600080fd5b602085015b83811015610c2b5780356001600160401b03811115610c0d57600080fd5b610c1c886020838a0101610b1b565b84525060209283019201610bef565b5095945050505050565b600082601f830112610c4657600080fd5b61063883833560208501610ac0565b600082601f830112610c6657600080fd5b8135610c7461079382610728565b8082825260208201915060208360051b860101925085831115610c9657600080fd5b602085015b83811015610c2b578035835260209283019201610c9b565b600060208284031215610cc557600080fd5b81356001600160401b03811115610cdb57600080fd5b820160c08185031215610ced57600080fd5b610cf56106d6565b610cfe82610a99565b8152610d0c60208301610ab5565b602082015260408201356001600160401b03811115610d2a57600080fd5b610d3686828501610ba9565b60408301525060608201356001600160401b03811115610d5557600080fd5b610d6186828501610c35565b60608301525060808201356001600160401b03811115610d8057600080fd5b610d8c86828501610c55565b60808301525060a08201356001600160401b03811115610dab57600080fd5b610db786828501610b1b565b60a083015250949350505050565b634e487b7160e01b600052603260045260246000fd5b634e487b7160e01b600052601160045260246000fd5b6000600160ff1b8201610e0657610e06610ddb565b5060000390565b6001815b6001841115610e4857808504811115610e2c57610e2c610ddb565b6001841615610e3a57908102905b60019390931c928002610e11565b935093915050565b600082610e5f575060016101f7565b81610e6c575060006101f7565b8160018114610e825760028114610e8c57610ea8565b60019150506101f7565b60ff841115610e9d57610e9d610ddb565b50506001821b6101f7565b5060208310610133831016604e8410600b8410161715610ecb575081810a6101f7565b610ed86000198484610e0d565b8060001904821115610eec57610eec610ddb565b029392505050565b60006106388383610e50565b818103818111156101f7576101f7610ddb565b6001600160a01b03818116838216818102909216918183048114821517610f3c57610f3c610ddb565b505092915050565b80820260008212600160ff1b84141615610f6057610f60610ddb565b81810583148215176101f7576101f7610ddb565b8082018281126000831280158216821582161715610f3c57610f3c610ddb565b600082610fb157634e487b7160e01b600052601260045260246000fd5b600160ff1b821460001984141615610fcb57610fcb610ddb565b50059056fea26469706673582212203f43b323a7ff47fc2e7baaa27f78f7ab223f6c9f87e66fff4a0adbcab0d42c4664736f6c634300081b0033"
    public static let runtimeCode: Hex = "0x608060405234801561001057600080fd5b50600436106100625760003560e01c8063314ded701461006757806358b15a54146100855780636fe03f99146100a8578063ac8dd3a4146100c8578063d7a69d4f146100dd578063eedfb21e14610108575b600080fd5b61006f610129565b60405161007c9190610685565b60405180910390f35b61009861009336600461074b565b6101ae565b604051901515815260200161007c565b6100bb6100b6366004610807565b6101fd565b60405161007c9190610898565b6100d0610489565b60405161007c9190610987565b6100f06100eb3660046109cc565b61053f565b6040516001600160a01b03909116815260200161007c565b61011b610116366004610cb3565b610593565b60405190815260200161007c565b60408051600180825281830190925260609160009190816020015b6040805180820190915260008152606060208201528152602001906001900390816101445790505090508060008151811061018157610181610dc5565b60200260200101516040516020016101999190610987565b60405160208183030381529060405291505090565b6000805b83518110156101f157828482815181106101ce576101ce610dc5565b602002602001015160000151036101e95760019150506101f7565b6001016101b2565b50600090505b92915050565b6102476040805160c081018252600080825260208083018290526060838501819052808401819052608084018190528451808201865283815291820152928301529060a082015290565b6000826001600160401b0381111561026157610261610698565b6040519080825280602002602001820160405280156102b957816020015b6102a660405180606001604052806000815260200160608152602001600080191681525090565b81526020019060019003908161027f5790505b50905060005b83811015610372576040518060600160405280826102dc90610df1565b8152602001826001600160401b038111156102f9576102f9610698565b6040519080825280601f01601f191660200182016040528015610323576020820181803683370190505b5081526020017f112233445566778899112233445566778899112233445566778899112233445581525082828151811061035f5761035f610dc5565b60209081029190910101526001016102bf565b506000836001600160401b0381111561038d5761038d610698565b6040519080825280602002602001820160405280156103b6578160200160208202803683370190505b50905060005b848110156103f3576103ce8180610ef4565b8282815181106103e0576103e0610dc5565b60209081029190910101526001016103bc565b506040518060c00160405280866001600160601b0316815260200160018761041b9190610f00565b6001600160601b03166001600160a01b031681526020018381526020016040518060400160405280600581526020016468656c6c6f60d81b81525081526020018281526020018360008151811061047457610474610dc5565b60200260200101518152509250505092915050565b604080518082018252600080825260606020830152825160018082528185019094529192909190816020015b6040805180820190915260008152606060208201528152602001906001900390816104b5579050509050604051806040016040528060048152602001635553444360e01b8152508160008151811061050f5761050f610dc5565b6020026020010151602001819052508060008151811061053157610531610dc5565b602002602001015191505090565b6000805b82518110156101f15783600001516001600160a01b031683828151811061056c5761056c610dc5565b60200260200101516001600160a01b03160361058b57505081516101f7565b600101610543565b600080826020015183600001516001600160601b03166105b39190610f13565b60130b905060005b83604001515181101561062b57836040015181815181106105de576105de610dc5565b6020026020010151600001518460400151828151811061060057610600610dc5565b602002602001015160200151516106179190610f44565b6106219083610f74565b91506001016105bb565b5061063860011982610f94565b9392505050565b6000815180845260005b8181101561066557602081850181015186830182015201610649565b506000602082860101526020601f19601f83011685010191505092915050565b602081526000610638602083018461063f565b634e487b7160e01b600052604160045260246000fd5b604051602081016001600160401b03811182821017156106d0576106d0610698565b60405290565b60405160c081016001600160401b03811182821017156106d0576106d0610698565b604051601f8201601f191681016001600160401b038111828210171561072057610720610698565b604052919050565b60006001600160401b0382111561074157610741610698565b5060051b60200190565b6000806040838503121561075e57600080fd5b82356001600160401b0381111561077457600080fd5b8301601f8101851361078557600080fd5b803561079861079382610728565b6106f8565b8082825260208201915060208360051b8501019250878311156107ba57600080fd5b6020840193505b828410156107f657602084890312156107d957600080fd5b6107e16106ae565b843581528252602093840193909101906107c1565b976020969096013596505050505050565b6000806040838503121561081a57600080fd5b50508035926020909101359150565b805182526000602082015160606020850152610848606085018261063f565b604093840151949093019390935250919050565b600081518084526020840193506020830160005b8281101561088e578151865260209586019590910190600101610870565b5093949350505050565b60208152600060e082016001600160601b03845116602084015260018060a01b036020850151166040840152604084015160c06060850152818151808452610100860191506101008160051b870101935060208301925060005b818110156109235760ff1987860301835261090e858551610829565b945060209384019392909201916001016108f2565b505050506060840151838203601f19016080850152610942828261063f565b9150506080840151601f198483030160a0850152610960828261085c565b91505060a0840151601f198483030160c085015261097e8282610829565b95945050505050565b6020815281516020820152600060208301516040808401526109ac606084018261063f565b949350505050565b6001600160a01b03811681146109c957600080fd5b50565b60008082840360408112156109e057600080fd5b60208112156109ee57600080fd5b506109f76106ae565b8335610a02816109b4565b8152915060208301356001600160401b03811115610a1f57600080fd5b8301601f81018513610a3057600080fd5b8035610a3e61079382610728565b8082825260208201915060208360051b850101925087831115610a6057600080fd5b6020840193505b82841015610a8b578335610a7a816109b4565b825260209384019390910190610a67565b809450505050509250929050565b80356001600160601b0381168114610ab057600080fd5b919050565b8035610ab0816109b4565b6000806001600160401b03841115610ada57610ada610698565b50601f8301601f1916602001610aef816106f8565b915050828152838383011115610b0457600080fd5b828260208301376000602084830101529392505050565b600060608284031215610b2d57600080fd5b604051606081016001600160401b0381118282101715610b4f57610b4f610698565b6040528235815290508060208301356001600160401b03811115610b7257600080fd5b8301601f81018513610b8357600080fd5b610b9285823560208401610ac0565b602083015250604083013560408201525092915050565b600082601f830112610bba57600080fd5b8135610bc861079382610728565b8082825260208201915060208360051b860101925085831115610bea57600080fd5b602085015b83811015610c2b5780356001600160401b03811115610c0d57600080fd5b610c1c886020838a0101610b1b565b84525060209283019201610bef565b5095945050505050565b600082601f830112610c4657600080fd5b61063883833560208501610ac0565b600082601f830112610c6657600080fd5b8135610c7461079382610728565b8082825260208201915060208360051b860101925085831115610c9657600080fd5b602085015b83811015610c2b578035835260209283019201610c9b565b600060208284031215610cc557600080fd5b81356001600160401b03811115610cdb57600080fd5b820160c08185031215610ced57600080fd5b610cf56106d6565b610cfe82610a99565b8152610d0c60208301610ab5565b602082015260408201356001600160401b03811115610d2a57600080fd5b610d3686828501610ba9565b60408301525060608201356001600160401b03811115610d5557600080fd5b610d6186828501610c35565b60608301525060808201356001600160401b03811115610d8057600080fd5b610d8c86828501610c55565b60808301525060a08201356001600160401b03811115610dab57600080fd5b610db786828501610b1b565b60a083015250949350505050565b634e487b7160e01b600052603260045260246000fd5b634e487b7160e01b600052601160045260246000fd5b6000600160ff1b8201610e0657610e06610ddb565b5060000390565b6001815b6001841115610e4857808504811115610e2c57610e2c610ddb565b6001841615610e3a57908102905b60019390931c928002610e11565b935093915050565b600082610e5f575060016101f7565b81610e6c575060006101f7565b8160018114610e825760028114610e8c57610ea8565b60019150506101f7565b60ff841115610e9d57610e9d610ddb565b50506001821b6101f7565b5060208310610133831016604e8410600b8410161715610ecb575081810a6101f7565b610ed86000198484610e0d565b8060001904821115610eec57610eec610ddb565b029392505050565b60006106388383610e50565b818103818111156101f7576101f7610ddb565b6001600160a01b03818116838216818102909216918183048114821517610f3c57610f3c610ddb565b505092915050565b80820260008212600160ff1b84141615610f6057610f60610ddb565b81810583148215176101f7576101f7610ddb565b8082018281126000831280158216821582161715610f3c57610f3c610ddb565b600082610fb157634e487b7160e01b600052601260045260246000fd5b600160ff1b821460001984141615610fcb57610fcb610ddb565b50059056fea26469706673582212203f43b323a7ff47fc2e7baaa27f78f7ab223f6c9f87e66fff4a0adbcab0d42c4664736f6c634300081b0033"

    public static let JustANameError = ABI.Function(
        name: "JustAName",
        inputs: []
    )

    public static let JustOneArgError = ABI.Function(
        name: "JustOneArg",
        inputs: [.bool]
    )

    public enum RevertReason: Equatable, Error {
        case justAName
        case justOneArg(Bool)
        case unknownRevert(String, String)
    }

    public static func rewrapError(_ error: ABI.Function, value: ABI.Value) -> RevertReason {
        switch (error, value) {
        case (JustANameError, _):
            return .justAName
        case (JustOneArgError, let .tuple1(.bool(var0))):
            return .justOneArg(var0)
        case let (e, v):
            return .unknownRevert(e.name, String(describing: v))
        }
    }

    public static let errors: [ABI.Function] = [JustANameError, JustOneArgError]
    public static let functions: [ABI.Function] = [acceptBatFn, anotherEmptyGooseFn, buildBatFn, emptyGooseFn, lookAtMooseFn, lookAtRatFn]
    public static let acceptBatFn = ABI.Function(
        name: "acceptBat",
        inputs: [.tuple([.uint96, .uint160, .array(Cat.schema), .string, .array(.uint256), Cat.schema])],
        outputs: [.int256]
    )

    public static func acceptBat(bat: Bat, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<BigInt, RevertReason> {
        do {
            let query = try acceptBatFn.encoded(with: [bat.asValue])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func acceptBatDecode(input: Hex) throws -> (Bat) {
        let decodedInput = try acceptBatFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple1(.tuple6(.uint96(a),
                                 .uint160(b),
                                 .array(Cat.schema, c),
                                 .string(d),
                                 .array(.uint256, e),
                                 f)):
            return try (Bat(a: a, b: b, c: c.map { try Cat.decodeValue($0) }, d: d, e: e.map { $0.asBigUInt! }, f: Cat.decodeValue(f)))
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, acceptBatFn.inputTuple)
        }
    }

    public static let anotherEmptyGooseFn = ABI.Function(
        name: "anotherEmptyGoose",
        inputs: [],
        outputs: [.bytes]
    )

    public static func anotherEmptyGoose(withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Hex, RevertReason> {
        do {
            let query = try anotherEmptyGooseFn.encoded(with: [])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try anotherEmptyGooseFn.decode(output: result)

            switch decoded {
            case let .tuple1(.bytes(var0)):
                return .success(var0)
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, anotherEmptyGooseFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func anotherEmptyGooseDecode(input: Hex) throws {
        let decodedInput = try anotherEmptyGooseFn.decodeInput(input: input)
        switch decodedInput {
        case .tuple0:
            return ()
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, anotherEmptyGooseFn.inputTuple)
        }
    }

    public static let buildBatFn = ABI.Function(
        name: "buildBat",
        inputs: [.uint256, .uint256],
        outputs: [.tuple([.uint96, .uint160, .array(Cat.schema), .string, .array(.uint256), Cat.schema])]
    )

    public static func buildBat(x: BigUInt, y: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Bat, RevertReason> {
        do {
            let query = try buildBatFn.encoded(with: [.uint256(x), .uint256(y)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func buildBatDecode(input: Hex) throws -> (BigUInt, BigUInt) {
        let decodedInput = try buildBatFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.uint256(x), .uint256(y)):
            return (x, y)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, buildBatFn.inputTuple)
        }
    }

    public static let emptyGooseFn = ABI.Function(
        name: "emptyGoose",
        inputs: [],
        outputs: [.tuple([.uint256, .string])]
    )

    public static func emptyGoose(withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Animal.Goose, RevertReason> {
        do {
            let query = try emptyGooseFn.encoded(with: [])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
            let decoded = try emptyGooseFn.decode(output: result)

            switch decoded {
            case let .tuple1(.tuple2(.uint256(b),
                                     .string(c))):
                return .success(Animal.Goose(b: b, c: c))
            default:
                throw ABI.DecodeError.mismatchedType(decoded.schema, emptyGooseFn.outputTuple)
            }
        } catch let EVM.QueryError.error(e, v) {
            return .failure(rewrapError(e, value: v))
        }
    }

    public static func emptyGooseDecode(input: Hex) throws {
        let decodedInput = try emptyGooseFn.decodeInput(input: input)
        switch decodedInput {
        case .tuple0:
            return ()
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, emptyGooseFn.inputTuple)
        }
    }

    public static let lookAtMooseFn = ABI.Function(
        name: "lookAtMoose",
        inputs: [.array(.tuple([.uint256])), .uint256],
        outputs: [.bool]
    )

    public static func lookAtMoose(moose: [Animal.Moose], m: BigUInt, withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<Bool, RevertReason> {
        do {
            let query = try lookAtMooseFn.encoded(with: [.array(Animal.Moose.schema, moose.map {
                $0.asValue
            }), .uint256(m)])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func lookAtMooseDecode(input: Hex) throws -> ([Animal.Moose], BigUInt) {
        let decodedInput = try lookAtMooseFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.array(Animal.Moose.schema, moose), .uint256(m)):
            return try (moose.map { try Animal.Moose.decodeValue($0) }, m)
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, lookAtMooseFn.inputTuple)
        }
    }

    public static let lookAtRatFn = ABI.Function(
        name: "lookAtRat",
        inputs: [.tuple([.address]), .array(.address)],
        outputs: [.address]
    )

    public static func lookAtRat(rat: Animal.Rat, holes: [EthAddress], withFunctions ffis: EVM.FFIMap = [:]) async throws -> Result<EthAddress, RevertReason> {
        do {
            let query = try lookAtRatFn.encoded(with: [rat.asValue, .array(.address, holes.map {
                .address($0)
            })])
            let result = try await EVM.runQuery(bytecode: runtimeCode, query: query, withErrors: errors, withFunctions: ffis)
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

    public static func lookAtRatDecode(input: Hex) throws -> (Animal.Rat, [EthAddress]) {
        let decodedInput = try lookAtRatFn.decodeInput(input: input)
        switch decodedInput {
        case let .tuple2(.tuple1(.address(a)), .array(.address, holes)):
            return try (Animal.Rat(a: a), holes.map { $0.asEthAddress! })
        default:
            throw ABI.DecodeError.mismatchedType(decodedInput.schema, lookAtRatFn.inputTuple)
        }
    }
}
