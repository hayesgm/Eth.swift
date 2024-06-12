import BigInt
@testable import Geno
import SwiftSyntax
import XCTest

final class GenoTests: XCTestCase {
    func testParsingStructAbiTypes() {
        guard let jsonData = jsonString().data(using: .utf8) else {
            XCTFail("Failed to convert jsonString to Data")
            return
        }
        let contract = try! JSONDecoder().decode(Contract.self, from: jsonData)

        var abiTypes: [String] = []
        for f in contract.abi {
            let schemas = f.outputs.map { parameterToValueType($0) }
            abiTypes.append(contentsOf: schemas)
        }
        let desired = [".int256", ".tuple([.uint96, .uint160, .array(Cat.schema), .string])"]
        for (i, _) in desired.enumerated() {
            XCTAssertEqual(abiTypes[i], desired[i])
        }
    }

    func testParsingStructMatchableAbiTypes() {
        guard let jsonData = jsonString().data(using: .utf8) else {
            XCTFail("Failed to convert jsonString to Data")
            return
        }
        let contract = try! JSONDecoder().decode(Contract.self, from: jsonData)

        var abiTypes: [String] = []
        for f in contract.abi {
            let schemas = f.outputs.enumerated().map { i, p in parameterToMatchableValueType(p: p, index: i) }
            abiTypes.append(contentsOf: schemas)
        }
        let desired = [".int256(var0)", ".tuple4(.uint96(a),\n .uint160(b),\n .array(Cat.schema, c),\n .string(d))"]
        for (i, _) in desired.enumerated() {
            XCTAssertEqual(abiTypes[i], desired[i])
        }
    }

    func testBuildStructDefs() {
        guard let jsonData = jsonString().data(using: .utf8) else {
            XCTFail("Failed to convert jsonString to Data")
            return
        }
        let contract = try! JSONDecoder().decode(Contract.self, from: jsonData)

        let structDefs = generateStructs(c: contract)

        // smoke test that is building somethign sane
        let regex = try! NSRegularExpression(pattern: "struct Bat: Equatable\\{static let schema: ABI\\.Schema = ABI.Schema\\.tuple")

        // Perform the matching
        let testString = structDefs[0].description
        let range = NSRange(location: 0, length: testString.description.utf16.count)
        let match = regex.firstMatch(in: testString, options: [], range: range)

        // Assert that a match was found
        XCTAssertNotNil(match, "The string does not match the regex")
    }

    func testConstructorForStruct() {
        guard let jsonData = jsonString().data(using: .utf8) else {
            XCTFail("Failed to convert jsonString to Data")
            return
        }
        let contract = try! JSONDecoder().decode(Contract.self, from: jsonData)

        var intializers: [String] = []
        for f in contract.abi {
            let schemas = f.outputs.enumerated().map { _, p in structInitializer(parameter: p, structName: "Bat") }
            intializers.append(contentsOf: schemas)
        }

        let desired = ["", "try Bat(a: a, b: b, c: c.map { try Cat.decodeValue($0) }, d: d)"]
        for (i, _) in desired.enumerated() {
            XCTAssertEqual(intializers[i], desired[i])
        }
    }

    func jsonString() -> String {
        """
        {
            "abi": [
                {
                    "type": "function",
                    "name": "acceptBat",
                    "inputs": [
                        {
                            "name": "bat",
                            "type": "tuple",
                            "internalType": "struct Bat",
                            "components": [
                                {
                                    "name": "a",
                                    "type": "uint96",
                                    "internalType": "uint96"
                                },
                                {
                                    "name": "b",
                                    "type": "uint160",
                                    "internalType": "uint160"
                                },
                                {
                                    "name": "c",
                                    "type": "tuple[]",
                                    "internalType": "struct Cat[]",
                                    "components": [
                                        {
                                            "name": "ca",
                                            "type": "int256",
                                            "internalType": "int256"
                                        },
                                        {
                                            "name": "cb",
                                            "type": "bytes",
                                            "internalType": "bytes"
                                        },
                                        {
                                            "name": "cc",
                                            "type": "bytes32",
                                            "internalType": "bytes32"
                                        }
                                    ]
                                },
                                {
                                    "name": "d",
                                    "type": "string",
                                    "internalType": "string"
                                }
                            ]
                        }
                    ],
                    "outputs": [
                        {
                            "name": "",
                            "type": "int256",
                            "internalType": "int256"
                        }
                    ],
                    "stateMutability": "pure"
                },
                {
                    "type": "function",
                    "name": "buildBat",
                    "inputs": [
                        {
                            "name": "x",
                            "type": "uint256",
                            "internalType": "uint256"
                        },
                        {
                            "name": "y",
                            "type": "uint256",
                            "internalType": "uint256"
                        }
                    ],
                    "outputs": [
                        {
                            "name": "",
                            "type": "tuple",
                            "internalType": "struct Bat",
                            "components": [
                                {
                                    "name": "a",
                                    "type": "uint96",
                                    "internalType": "uint96"
                                },
                                {
                                    "name": "b",
                                    "type": "uint160",
                                    "internalType": "uint160"
                                },
                                {
                                    "name": "c",
                                    "type": "tuple[]",
                                    "internalType": "struct Cat[]",
                                    "components": [
                                        {
                                            "name": "ca",
                                            "type": "int256",
                                            "internalType": "int256"
                                        },
                                        {
                                            "name": "cb",
                                            "type": "bytes",
                                            "internalType": "bytes"
                                        },
                                        {
                                            "name": "cc",
                                            "type": "bytes32",
                                            "internalType": "bytes32"
                                        }
                                    ]
                                },
                                {
                                    "name": "d",
                                    "type": "string",
                                    "internalType": "string"
                                }
                            ]
                        }
                    ],
                    "stateMutability": "pure"
                }
            ],
            "bytecode": {
                "object": "0x608060405234801561001057600080fd5b50610852806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80634a86b4f51461003b5780636fe03f9914610061575b600080fd5b61004e6100493660046104f2565b610081565b6040519081526020015b60405180910390f35b61007461006f3660046105c1565b61012d565b6040516100589190610629565b600080826020015183600001516001600160601b03166100a19190610711565b60130b905060005b83604001515181101561011957836040015181815181106100cc576100cc610743565b602002602001015160000151846040015182815181106100ee576100ee610743565b602002602001015160200151516101059190610759565b61010f9083610789565b91506001016100a9565b50610126600119826107b1565b9392505050565b604080516080810182526000808252602082015260609181018290528181019190915260008267ffffffffffffffff81111561016b5761016b6102ed565b6040519080825280602002602001820160405280156101c357816020015b6101b060405180606001604052806000815260200160608152602001600080191681525090565b8152602001906001900390816101895790505b50905060005b8381101561027d576040518060600160405280826101e6906107ed565b81526020018267ffffffffffffffff811115610204576102046102ed565b6040519080825280601f01601f19166020018201604052801561022e576020820181803683370190505b5081526020017f112233445566778899112233445566778899112233445566778899112233445581525082828151811061026a5761026a610743565b60209081029190910101526001016101c9565b506040518060800160405280856001600160601b031681526020016001866102a59190610809565b6001600160601b03166001600160a01b031681526020018281526020016040518060400160405280600581526020016468656c6c6f60d81b8152508152509150505b92915050565b634e487b7160e01b600052604160045260246000fd5b6040516060810167ffffffffffffffff81118282101715610326576103266102ed565b60405290565b6040516080810167ffffffffffffffff81118282101715610326576103266102ed565b604051601f8201601f1916810167ffffffffffffffff81118282101715610378576103786102ed565b604052919050565b600067ffffffffffffffff83111561039a5761039a6102ed565b6103ad601f8401601f191660200161034f565b90508281528383830111156103c157600080fd5b828260208301376000602084830101529392505050565b600082601f8301126103e957600080fd5b8135602067ffffffffffffffff80831115610406576104066102ed565b8260051b61041583820161034f565b938452858101830193838101908886111561042f57600080fd5b84880192505b858310156104c65782358481111561044d5760008081fd5b88016060818b03601f19018113156104655760008081fd5b61046d610303565b878301358152604080840135888111156104875760008081fd5b8401603f81018e136104995760008081fd5b6104a98e8b830135848401610380565b8a8401525091909201359082015282529184019190840190610435565b98975050505050505050565b600082601f8301126104e357600080fd5b61012683833560208501610380565b60006020828403121561050457600080fd5b813567ffffffffffffffff8082111561051c57600080fd5b908301906080828603121561053057600080fd5b61053861032c565b82356001600160601b038116811461054f57600080fd5b815260208301356001600160a01b038116811461056b57600080fd5b602082015260408301358281111561058257600080fd5b61058e878286016103d8565b6040830152506060830135828111156105a657600080fd5b6105b2878286016104d2565b60608301525095945050505050565b600080604083850312156105d457600080fd5b50508035926020909101359150565b6000815180845260005b81811015610609576020818501810151868301820152016105ed565b506000602082860101526020601f19601f83011685010191505092915050565b6000602080835260a083016001600160601b038551168285015281850151604060018060a01b03821660408701526040870151915060606080606088015283835180865260c08901915060c08160051b8a01019550868501945060005b818110156106cf5760bf198a880301835285518051885288810151858a8a01526106b2868a01826105e3565b918701519887019890985296509487019491870191600101610686565b50505050505060608501519150601f198482030160808501526106f281836105e3565b95945050505050565b634e487b7160e01b600052601160045260246000fd5b6001600160a01b0382811682821681810283169291811582850482141761073a5761073a6106fb565b50505092915050565b634e487b7160e01b600052603260045260246000fd5b80820260008212600160ff1b84141615610775576107756106fb565b81810583148215176102e7576102e76106fb565b80820182811260008312801582168215821617156107a9576107a96106fb565b505092915050565b6000826107ce57634e487b7160e01b600052601260045260246000fd5b600160ff1b8214600019841416156107e8576107e86106fb565b500590565b6000600160ff1b8201610802576108026106fb565b5060000390565b818103818111156102e7576102e76106fb56fea2646970667358221220a6cad43169da40e6dffec20ec8a6d455f3e44152fd863b44f299109942fac7b564736f6c63430008180033",
                "sourceMap": "198:813:28:-:0;;;;;;;;;;;;;;;;;;;",
                "linkReferences": {}
            },
            "deployedBytecode": {
                "object": "0x608060405234801561001057600080fd5b50600436106100365760003560e01c80634a86b4f51461003b5780636fe03f9914610061575b600080fd5b61004e6100493660046104f2565b610081565b6040519081526020015b60405180910390f35b61007461006f3660046105c1565b61012d565b6040516100589190610629565b600080826020015183600001516001600160601b03166100a19190610711565b60130b905060005b83604001515181101561011957836040015181815181106100cc576100cc610743565b602002602001015160000151846040015182815181106100ee576100ee610743565b602002602001015160200151516101059190610759565b61010f9083610789565b91506001016100a9565b50610126600119826107b1565b9392505050565b604080516080810182526000808252602082015260609181018290528181019190915260008267ffffffffffffffff81111561016b5761016b6102ed565b6040519080825280602002602001820160405280156101c357816020015b6101b060405180606001604052806000815260200160608152602001600080191681525090565b8152602001906001900390816101895790505b50905060005b8381101561027d576040518060600160405280826101e6906107ed565b81526020018267ffffffffffffffff811115610204576102046102ed565b6040519080825280601f01601f19166020018201604052801561022e576020820181803683370190505b5081526020017f112233445566778899112233445566778899112233445566778899112233445581525082828151811061026a5761026a610743565b60209081029190910101526001016101c9565b506040518060800160405280856001600160601b031681526020016001866102a59190610809565b6001600160601b03166001600160a01b031681526020018281526020016040518060400160405280600581526020016468656c6c6f60d81b8152508152509150505b92915050565b634e487b7160e01b600052604160045260246000fd5b6040516060810167ffffffffffffffff81118282101715610326576103266102ed565b60405290565b6040516080810167ffffffffffffffff81118282101715610326576103266102ed565b604051601f8201601f1916810167ffffffffffffffff81118282101715610378576103786102ed565b604052919050565b600067ffffffffffffffff83111561039a5761039a6102ed565b6103ad601f8401601f191660200161034f565b90508281528383830111156103c157600080fd5b828260208301376000602084830101529392505050565b600082601f8301126103e957600080fd5b8135602067ffffffffffffffff80831115610406576104066102ed565b8260051b61041583820161034f565b938452858101830193838101908886111561042f57600080fd5b84880192505b858310156104c65782358481111561044d5760008081fd5b88016060818b03601f19018113156104655760008081fd5b61046d610303565b878301358152604080840135888111156104875760008081fd5b8401603f81018e136104995760008081fd5b6104a98e8b830135848401610380565b8a8401525091909201359082015282529184019190840190610435565b98975050505050505050565b600082601f8301126104e357600080fd5b61012683833560208501610380565b60006020828403121561050457600080fd5b813567ffffffffffffffff8082111561051c57600080fd5b908301906080828603121561053057600080fd5b61053861032c565b82356001600160601b038116811461054f57600080fd5b815260208301356001600160a01b038116811461056b57600080fd5b602082015260408301358281111561058257600080fd5b61058e878286016103d8565b6040830152506060830135828111156105a657600080fd5b6105b2878286016104d2565b60608301525095945050505050565b600080604083850312156105d457600080fd5b50508035926020909101359150565b6000815180845260005b81811015610609576020818501810151868301820152016105ed565b506000602082860101526020601f19601f83011685010191505092915050565b6000602080835260a083016001600160601b038551168285015281850151604060018060a01b03821660408701526040870151915060606080606088015283835180865260c08901915060c08160051b8a01019550868501945060005b818110156106cf5760bf198a880301835285518051885288810151858a8a01526106b2868a01826105e3565b918701519887019890985296509487019491870191600101610686565b50505050505060608501519150601f198482030160808501526106f281836105e3565b95945050505050565b634e487b7160e01b600052601160045260246000fd5b6001600160a01b0382811682821681810283169291811582850482141761073a5761073a6106fb565b50505092915050565b634e487b7160e01b600052603260045260246000fd5b80820260008212600160ff1b84141615610775576107756106fb565b81810583148215176102e7576102e76106fb565b80820182811260008312801582168215821617156107a9576107a96106fb565b505092915050565b6000826107ce57634e487b7160e01b600052601260045260246000fd5b600160ff1b8214600019841416156107e8576107e86106fb565b500590565b6000600160ff1b8201610802576108026106fb565b5060000390565b818103818111156102e7576102e76106fb56fea2646970667358221220a6cad43169da40e6dffec20ec8a6d455f3e44152fd863b44f299109942fac7b564736f6c63430008180033",
                "sourceMap": "198:813:28:-:0;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;737:272;;;;;;:::i;:::-;;:::i;:::-;;;4642:25:35;;;4630:2;4615:18;737:272:28;;;;;;;;221:510;;;;;;:::i;:::-;;:::i;:::-;;;;;;;:::i;737:272::-;795:6;813:12;843:3;:5;;;835:3;:5;;;-1:-1:-1;;;;;835:13:28;;;;;:::i;:::-;813:36;;;;864:9;859:117;883:3;:5;;;:12;879:1;:16;859:117;;;954:3;:5;;;960:1;954:8;;;;;;;;:::i;:::-;;;;;;;:11;;;932:3;:5;;;938:1;932:8;;;;;;;;:::i;:::-;;;;;;;:11;;;:18;925:40;;;;:::i;:::-;916:49;;;;:::i;:::-;;-1:-1:-1;897:3:28;;859:117;;;-1:-1:-1;992:10:28;-1:-1:-1;;992:5:28;:10;:::i;:::-;985:17;737:272;-1:-1:-1;;;737:272:28:o;221:510::-;-1:-1:-1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;306:17:28;336:1;326:12;;;;;;;;:::i;:::-;;;;;;;;;;;;;;;;;;;;;;;;;-1:-1:-1;;;;;;;;;;;;;;;;;;;;;;;;;;;326:12:28;;;;;;;;;;;;;;;;;306:32;;353:9;348:243;372:1;368;:5;348:243;;;404:176;;;;;;;;438:1;430:10;;;:::i;:::-;404:176;;;;472:1;462:12;;;;;;;;:::i;:::-;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-1:-1:-1;462:12:28;;404:176;;;;;;;;394:4;399:1;394:7;;;;;;;;:::i;:::-;;;;;;;;;;:186;375:3;;348:243;;;;608:116;;;;;;;;636:1;-1:-1:-1;;;;;608:116:28;;;;;666:1;662;:5;;;;:::i;:::-;-1:-1:-1;;;;;608:116:28;-1:-1:-1;;;;;608:116:28;;;;;685:4;608:116;;;;;;;;;;;;;;;;;-1:-1:-1;;;608:116:28;;;;;;601:123;;;221:510;;;;;:::o;14:127:35:-;75:10;70:3;66:20;63:1;56:31;106:4;103:1;96:15;130:4;127:1;120:15;146:253;218:2;212:9;260:4;248:17;;295:18;280:34;;316:22;;;277:62;274:88;;;342:18;;:::i;:::-;378:2;371:22;146:253;:::o;404:::-;476:2;470:9;518:4;506:17;;553:18;538:34;;574:22;;;535:62;532:88;;;600:18;;:::i;662:275::-;733:2;727:9;798:2;779:13;;-1:-1:-1;;775:27:35;763:40;;833:18;818:34;;854:22;;;815:62;812:88;;;880:18;;:::i;:::-;916:2;909:22;662:275;;-1:-1:-1;662:275:35:o;942:406::-;1006:5;1040:18;1032:6;1029:30;1026:56;;;1062:18;;:::i;:::-;1100:57;1145:2;1124:15;;-1:-1:-1;;1120:29:35;1151:4;1116:40;1100:57;:::i;:::-;1091:66;;1180:6;1173:5;1166:21;1220:3;1211:6;1206:3;1202:16;1199:25;1196:45;;;1237:1;1234;1227:12;1196:45;1286:6;1281:3;1274:4;1267:5;1263:16;1250:43;1340:1;1333:4;1324:6;1317:5;1313:18;1309:29;1302:40;942:406;;;;;:::o;1353:1765::-;1410:5;1463:3;1456:4;1448:6;1444:17;1440:27;1430:55;;1481:1;1478;1471:12;1430:55;1517:6;1504:20;1543:4;1566:18;1603:2;1599;1596:10;1593:36;;;1609:18;;:::i;:::-;1655:2;1652:1;1648:10;1678:28;1702:2;1698;1694:11;1678:28;:::i;:::-;1740:15;;;1810;;;1806:24;;;1771:12;;;;1842:15;;;1839:35;;;1870:1;1867;1860:12;1839:35;1906:2;1898:6;1894:15;1883:26;;1918:1171;1934:6;1929:3;1926:15;1918:1171;;;2020:3;2007:17;2056:2;2043:11;2040:19;2037:109;;;2100:1;2129:2;2125;2118:14;2037:109;2169:24;;2216:4;2244:12;;;-1:-1:-1;;2240:26:35;2236:35;-1:-1:-1;2233:125:35;;;2312:1;2341:2;2337;2330:14;2233:125;2384:22;;:::i;:::-;2454:2;2450;2446:11;2433:25;2426:5;2419:40;2482:2;2534;2530;2526:11;2513:25;2567:2;2557:8;2554:16;2551:109;;;2612:1;2642:3;2637;2630:16;2551:109;2684:17;;2737:2;2728:12;;2724:22;-1:-1:-1;2714:123:35;;2789:1;2819:3;2814;2807:16;2714:123;2873:80;2949:3;2943:2;2938:3;2934:12;2921:26;2916:2;2911:3;2907:12;2873:80;:::i;:::-;2857:14;;;2850:104;-1:-1:-1;3003:11:35;;;;2990:25;2974:14;;;2967:49;3029:18;;1951:12;;;;3067;;;;1918:1171;;;3107:5;1353:1765;-1:-1:-1;;;;;;;;1353:1765:35:o;3123:221::-;3166:5;3219:3;3212:4;3204:6;3200:17;3196:27;3186:55;;3237:1;3234;3227:12;3186:55;3259:79;3334:3;3325:6;3312:20;3305:4;3297:6;3293:17;3259:79;:::i;3349:1144::-;3430:6;3483:2;3471:9;3462:7;3458:23;3454:32;3451:52;;;3499:1;3496;3489:12;3451:52;3539:9;3526:23;3568:18;3609:2;3601:6;3598:14;3595:34;;;3625:1;3622;3615:12;3595:34;3648:22;;;;3704:4;3686:16;;;3682:27;3679:47;;;3722:1;3719;3712:12;3679:47;3748:22;;:::i;:::-;3807:2;3794:16;-1:-1:-1;;;;;3845:7:35;3841:40;3832:7;3829:53;3819:81;;3896:1;3893;3886:12;3819:81;3909:22;;3976:2;3968:11;;3955:25;-1:-1:-1;;;;;4011:33:35;;3999:46;;3989:74;;4059:1;4056;4049:12;3989:74;4090:2;4079:14;;4072:31;4149:2;4141:11;;4128:25;4165:16;;;4162:36;;;4194:1;4191;4184:12;4162:36;4230:59;4281:7;4270:8;4266:2;4262:17;4230:59;:::i;:::-;4225:2;4218:5;4214:14;4207:83;;4336:2;4332;4328:11;4315:25;4365:2;4355:8;4352:16;4349:36;;;4381:1;4378;4371:12;4349:36;4417:45;4454:7;4443:8;4439:2;4435:17;4417:45;:::i;:::-;4412:2;4401:14;;4394:69;-1:-1:-1;4405:5:35;3349:1144;-1:-1:-1;;;;;3349:1144:35:o;4678:248::-;4746:6;4754;4807:2;4795:9;4786:7;4782:23;4778:32;4775:52;;;4823:1;4820;4813:12;4775:52;-1:-1:-1;;4846:23:35;;;4916:2;4901:18;;;4888:32;;-1:-1:-1;4678:248:35:o;4931:422::-;4972:3;5010:5;5004:12;5037:6;5032:3;5025:19;5062:1;5072:162;5086:6;5083:1;5080:13;5072:162;;;5148:4;5204:13;;;5200:22;;5194:29;5176:11;;;5172:20;;5165:59;5101:12;5072:162;;;5076:3;5279:1;5272:4;5263:6;5258:3;5254:16;5250:27;5243:38;5342:4;5335:2;5331:7;5326:2;5318:6;5314:15;5310:29;5305:3;5301:39;5297:50;5290:57;;;4931:422;;;;:::o;5358:1569::-;5494:4;5523:2;5552;5541:9;5534:21;5593:3;5582:9;5578:19;-1:-1:-1;;;;;5643:6:35;5637:13;5633:46;5628:2;5617:9;5613:18;5606:74;5727:2;5719:6;5715:15;5709:22;5750:2;5823:1;5819;5814:3;5810:11;5806:19;5792:12;5788:38;5783:2;5772:9;5768:18;5761:66;5876:2;5868:6;5864:15;5858:22;5836:44;;5899:2;5937:4;5932:2;5921:9;5917:18;5910:32;5962:6;5997:14;5991:21;6036:6;6028;6021:22;6074:3;6063:9;6059:19;6052:26;;6137:3;6127:6;6124:1;6120:14;6109:9;6105:30;6101:40;6087:54;;6184:2;6168:14;6164:23;6150:37;;6205:1;6215:521;6229:6;6226:1;6223:13;6215:521;;;6322:3;6318:8;6306:9;6298:6;6294:22;6290:37;6285:3;6278:50;6357:6;6351:13;6398:2;6392:9;6384:6;6377:25;6451:2;6447;6443:11;6437:18;6492:2;6487;6479:6;6475:15;6468:27;6522:49;6567:2;6559:6;6555:15;6539:14;6522:49;:::i;:::-;6614:11;;;6608:18;6591:15;;;6584:43;;;;6508:63;-1:-1:-1;6679:15:35;;;;6714:12;;;;6251:1;6244:9;6215:521;;;6219:3;;;;;;6785:2;6777:6;6773:15;6767:22;6745:44;;6859:2;6855:7;6843:9;6835:6;6831:22;6827:36;6820:4;6809:9;6805:20;6798:66;6881:40;6914:6;6898:14;6881:40;:::i;:::-;6873:48;5358:1569;-1:-1:-1;;;;;5358:1569:35:o;6932:127::-;6993:10;6988:3;6984:20;6981:1;6974:31;7024:4;7021:1;7014:15;7048:4;7045:1;7038:15;7064:285;-1:-1:-1;;;;;7205:10:35;;;7175;;;7239:13;;;7235:22;;;7136:19;7279:11;;7300:17;;;7292:26;;7276:43;7266:77;;7323:18;;:::i;:::-;7266:77;;;7064:285;;;;:::o;7354:127::-;7415:10;7410:3;7406:20;7403:1;7396:31;7446:4;7443:1;7436:15;7470:4;7467:1;7460:15;7486:237;7558:9;;;7525:7;7583:9;;-1:-1:-1;;;7594:18:35;;7579:34;7576:60;;;7616:18;;:::i;:::-;7689:1;7680:7;7675:16;7672:1;7669:23;7665:1;7658:9;7655:38;7645:72;;7697:18;;:::i;7728:216::-;7792:9;;;7820:11;;;7767:3;7850:9;;7878:10;;7874:19;;7903:10;;7895:19;;7871:44;7868:70;;;7918:18;;:::i;:::-;7868:70;;7728:216;;;;:::o;7949:290::-;7988:1;8014;8004:132;;8058:10;8053:3;8049:20;8046:1;8039:31;8093:4;8090:1;8083:15;8121:4;8118:1;8111:15;8004:132;-1:-1:-1;;;8152:18:35;;-1:-1:-1;;8172:13:35;;8148:38;8145:64;;;8189:18;;:::i;:::-;-1:-1:-1;8223:10:35;;7949:290::o;8244:136::-;8279:3;-1:-1:-1;;;8300:22:35;;8297:48;;8325:18;;:::i;:::-;-1:-1:-1;8365:1:35;8361:13;;8244:136::o;8385:128::-;8452:9;;;8473:11;;;8470:37;;;8487:18;;:::i",
                "linkReferences": {}
            },
            "id": 28
        }
        """
    }
}
