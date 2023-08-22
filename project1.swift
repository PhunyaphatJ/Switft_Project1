import Foundation

var items:[(id:Int,name:String,quantity:Int,price:Double)] = []
var sellList: [(orderID: Int, items: [(id: Int, name: String, quantity: Int, price: Double)], total: Double,memberID:Int?)] = []
typealias AnotherInt = Int
var order:AnotherInt = 0
// var totalSell:CalTotal = .price(0.0)
var totalSell:[()->Double] = []
//for test
items.append((id:0,name:"items1",quantity:30,price:20.0))
items.append((id:1,name:"items2",quantity:15,price:50))
items.append((id:2,name:"items3",quantity:10,price:100))
items.append((id:3,name:"items4",quantity:60,price:15))
items.append((id:4,name:"items5",quantity:35,price:33.3))
var id = items.count - 1
//

// var id:Int = 0

//-----------------function add-on------------
//check array index
func checkArray(index:Int)->Bool{
    return index >= items.count ? false : true
}

//checkID
func checkID(thisItems:[(id:Int,name:String,quantity:Int,price:Double)],id:Int)->Int?{
    var i = 0
    for item in thisItems{
        if item.id == id {
            return i
        }
        i = i + 1
    }
    return nil
}

func checkName(thisItems:[(id:Int,name:String,quantity:Int,price:Double)],name:String)->Int?{
      for i in 0..<thisItems.count{
            if(thisItems[i].name == name){
                return  i
            }
        }
    return nil
}

enum CalTotal{
    case price(Double)
    indirect case plus(CalTotal,CalTotal)

    func calculate() -> Double {
        switch self {
        case .price(let price):
            return price
        case .plus(let left, let right):
            return left.calculate() + right.calculate()
        }
    }
}

//total price in bill
func total(thisItems:[(id:Int,name:String,quantity:Int,price:Double)])->Double{
   var totalCalculator: CalTotal = .price(0.0)
    
    for item in thisItems {
        totalCalculator = .plus(totalCalculator, .price(item.price))
    }
    
    let total = totalCalculator.calculate()
     let space = "".padding(toLength: 23, withPad: " ", startingAt: 0)
     let stringSum = "\(total)".padding(toLength: 8, withPad: " ", startingAt: 0)
     print("|\(space)total : \(stringSum) |")
     print("------------------------------------------")
     return total
}

func totalSellEscaping(function:@autoclosure @escaping()->Double){
    totalSell.append(function)
}

func excuteTotalSell()->Double{
    var sum:CalTotal = .price(0.0)

    for total in totalSell{
        sum = .plus(sum, .price(total()))
    }
    return sum.calculate()
}

//------------------------------------------

//Create and Remove function
func createAndRemove(){
    while true{
    system("clear")
    print("+-----------------+")
    print("| Select Option   |")
    print("| 1.Create Item   |")
    print("| 2.Remove Item   |")
    print("| 3.Exit          |")
    print("+-----------------+")
    if let input = readLine(){
        switch input{
            case "1":
                add()
            case "2":
                remove()
            case "3":
                return
            default:
                print("invalide input")
        }
    }
    }
}

//---------------------add------------------------
func add(){
        while true{
    system("clear")
    print("+-----------------+")
    print("| Select Option   |")
    print("| 1.Add Item      |")
    print("| 2.Add By ID     |")
    print("| 3.Exit          |")
    print("+-----------------+")
    if let input = readLine(){
        switch input{
            case "1":
                addItem()
            case "2":
                addByID()
            case "3":
                return
            default:
                print("invalide input")
        }
    }
    }
}

//add function
func addItem(){
    system("clear")
    print("+------------+")
    print("|   addItem  |")
    print("+------------+")
    print("Enter item details:")
    print("Name: ",terminator:"")
    let name = readLine()!
    
    var quantity:Int?
    //check input quantity if not Int ,loop until input is int
    while(quantity == nil){
        print("Quantity: ",terminator:"")
        if let input = Int(readLine()!){
                if input < 0{ //check input < 0
                    print("Quantity must more than 0")
                }else{
                    quantity = input
                }
        }else{
            print("quantity must be Int")
        }
    }
    
    var price:Double?
    //check input price
    while(price == nil){
        print("Price each: ",terminator:"")
        if let input = Double(readLine()!){
            if input <= 0{
                print("pirce must more than 0")
            }else{
            price = input
            }
        }else{
            print("price must be Double")
        }
    }
    while true{
       if checkID(thisItems: items, id: id) != nil{ //check id if exist
            id += 1
        }else{
            break
        }
    }


    let newItem = (id:id,name:name,quantity:quantity!,price:price!)
    print("add item:\(newItem)")
    pauseFunc()
    items.append(newItem)
    items.sort(by: {$0.id < $1.id})
    id += 1//every create item id + 1
}

func addByID(){
    system("clear")
    print("+-------------+")
    print("| addItemByID |")
    print("+-------------+")
    print("Enter item details:")
    add:while true{
        print("ID: ",terminator:"")
        if let inputID = Int(readLine()!){
            if checkID(thisItems: items, id: inputID) != nil{//check id exist
                print("This ID already exists ")
                continue add
            }else{
                let thisID = inputID
                print("Name: ",terminator:"")
                let name = readLine()!

                var quantity:Int?
                while(quantity == nil){
                    print("Quantity: ",terminator:"")
                    if let inputQuantity = Int(readLine()!){
                        if inputQuantity < 0{ //check input < 0
                            print("Quantity must more than 0")
                        }else{
                        quantity = inputQuantity
                    }
                     }else{
                        print("quantity must be Int")
                    }
                }
                var price:Double?
                while(price == nil){
                    print("Price each: ",terminator:"")
                    if let inputPrice = Double(readLine()!){
                        if inputPrice <= 0{
                            print("pirce must more than 0")
                        }else{
                        price = inputPrice
                        }
                    }else{
                        print("price must be Double")
                    }
                }
                let newItem = (id:thisID,name:name,quantity:quantity!,price:price!)
                print("add item:\(newItem)")
                pauseFunc()
                items.append(newItem)
                items.sort(by: {$0.id < $1.id})
                return
            }
        }else{
            print("Id must be Int")
        }
    }
}
//------------------end add--------------------


//--------------remove-----------------------
//romove Item
func remove(){
    if(items.isEmpty){
        print("items is empty cannot remove")
        pauseFunc()
        return
    }
    var check = false
    repeat{
        system("clear")
        print("+--------------------+")
        print("| Select remove      |")
        print("| 1.remove by Name   |")
        print("| 2.remove by ID     |")
        print("| 3.exit             |")
        print("+--------------------+")
        if let input = readLine(){
            switch input{
                case "1":
                    removeByName()
                case "2":
                    removeByID()
                    pauseFunc()
                case "3":
                    check = true
                default:
                    print("invalid input")
            }
        }else{
            print("invalide input ")
        }
    }while(check == false)
}


//removeByName
func removeByName(){
    system("clear")
    print("+------------+")
    print("|removeByName|")
    print("+------------+")
    print("Input Name: ",terminator: "")
    if let input = readLine(){
        if let index = checkName(thisItems: items, name: input){
            let remove = items.remove(at:index)
            print("remove Id:\(index) name:\(input) ",remove)
            // decreaseID(index:index)
        }else{
            print("items dont have item name \(input)")
        }
        pauseFunc()
    }
}


//removeBy ID
func removeByID(){
    system("clear")
    var check = true
    print("+------------+")
    print("| removeByID |")
    print("+------------+")
    remove:while check{
        print("Input Index:",terminator:"")
        if let input = Int(readLine()!){
            if checkArray(index:input){//if found remove this index if not continue loop
                let remove = items.remove(at:input)
                print("remove Id:\(input) :",remove)
                // decreaseID(index:input)
                check = false
            }else{
                print("not found this index")
            }
        }else{
            print("input must be Int")
        }
    }
}
//------------------------end remove------------------------

//-------------------------show-----------------------------
func show(){
    system("clear")
    var check = true
    while check{
        system("clear")
        print("+-----------------+")
        print("| Select Show     |")
        print("| 1.ShowAllItem   |")
        print("| 2.ShowByID      |")
        print("| 3.ShowByName    |")
        print("| 4.CheckStock    |")
        print("| 5.exit          |")
        print("+-----------------+")
        if let input = readLine(){
            switch input{
                case "1":
                    showDetail()
                    pauseFunc()
                case "2":
                    showByID()
                case "3":
                    showByName()
                    pauseFunc()
                case "4":
                    checkStock()
                    pauseFunc()
                case "5":
                    check = false
                default:
                    print("invalid input")
                    pauseFunc()
            }
        }
    }
}

func showAll(thisItems:[(id:Int,name:String,quantity:Int,price:Double)]){
    print("+----------------------------------------+")
    print("| ID |   Name   |   Quantity   |  Price  |")
    print("------------------------------------------")
    for item in thisItems{
       let pID = "\(item.id)".padding(toLength: 4, withPad: " ", startingAt: 0)
       let pName = item.name.padding(toLength: 10, withPad: " ", startingAt: 0)
       let pQuantity = "\(item.quantity)".padding(toLength: 14, withPad: " ", startingAt: 0)
       let pPrice = "\(item.price)".padding(toLength: 9, withPad: " ", startingAt: 0)
       print("|\(pID)|\(pName)|\(pQuantity)|\(pPrice)|")
       print("------------------------------------------")
    }
}

//show item
func showDetail(){
    system("clear")
    showAll(thisItems:items)
}

//ShowByID
func showByID(){
    system("clear")
    print("+------------+")
    print("| showByID   |")
    print("+------------+")
    print("Input item ID: ",terminator: "")
    if let input = Int(readLine()!){
        if checkArray(index: input){
          print("\nID: \(items[input].id) Name: \(items[input].name) Quantity: \(items[input].quantity) price: \(items[input].price)\n")
        }else{
            print("not found this index")
        }
    }
    pauseFunc()
}

//ShowByName
func showByName(){
    system("clear")
    print("+------------+")
    print("| showByName |")
    print("+------------+")
    print("Input Name: ",terminator: "")
    if let input = readLine(){
        if let index = checkName(thisItems: items, name: input){
            print("\nID: \(items[index].id) Name: \(items[index].name) Quantity: \(items[index].quantity) price: \(items[index].price)\n")
        }else{
            print("not found")
        }
    }
}

//chekcstock sorted by items.quantity min
func checkStock(){
    system("clear")
    print("+------------+")
    print("| CheckStock |")
    print("+------------+")
    let quantitySort = items.sorted(by: {$0.quantity < $1.quantity})
    showAll(thisItems: quantitySort)
}

//------------------end Show---------------------------

//pasuse fucntion
func pauseFunc(){
    print("Enter someThing....",terminator:"")
    _ = readLine()
}


//-----------------seller------------------------------
//seller function
func seller(){
    while true{
        system("clear")
        print("+---------------+")
        print("| Select Option   |")
        print("| 1.sell Item     |")
        print("| 2.Re Stock      |")
        print("| 3.Sell List     |")
        print("| 4.Member        |")
        print("| 5.Exit          |")
        print("+-----------------+")
        if let input = readLine(){
            switch input{
                case "1":
                    sellItem()
                case "2":
                    reStock()
                case "3":
                    showSellList(thisSell: sellList)
                case "4":
                    memberFunc()
                case "5":
                    return
                default:
                    print("error")
            }
        }
    }
}

func bill(){

}

func sellItem(){
    var check = true
    var bill:[(id: Int, name: String, quantity: Int, price: Double)] = []
    var totalPrice:Double = 0
    sell:repeat {
        system("clear")
        print("+------------+")
        print("|  SellItem  |")
        print("+------------+")
        showAll(thisItems: items)
        bill.sort(by: {$0.id < $1.id})//sorted id 
        showAll(thisItems: bill)
        totalPrice = total(thisItems: bill)
        print("Do You want to sell (Y|N): ",terminator: "")
        if let input = readLine(){
            switch input{//case y/n 
                case "Y","y":
                    print("sell Item ID: ",terminator: "")
                    if let inputID = Int(readLine()!){//check input Int
                        if let indexA = checkID(thisItems: items, id: inputID){//check index out of bounds
                            if items[indexA].quantity == 0{//quantity check
                                print("items is empty")
                                pauseFunc()
                            }else{
                                    quantityLoop:while true{
                                        print("Quantity: ",terminator: "")
                                        if let inputQuantity = Int(readLine()!){//check input Int
                                            if items[indexA].quantity >=  inputQuantity{//check inputQuantity > item quantity
                                                if bill.contains(where: {$0.id == inputID}){//check if bill have item before
                                                    let indexB:Int! = checkID(thisItems: bill, id: inputID)
                                                    bill[indexB].quantity += inputQuantity
                                                }else{
                                                    let price = Double(inputQuantity) * items[indexA].price
                                                    bill.append((id:inputID,name:items[indexA].name,quantity:inputQuantity,price))
                                                } 
                                                items[indexA].quantity -= inputQuantity
                                                break quantityLoop
                                            }else{
                                                print("input Quantity > Quantity")
                                                continue quantityLoop
                                            }
                                        }else{
                                            print("quantity must be Int")
                                            continue quantityLoop
                                        }
                                    }
                                }
                        }else{
                            print("dont have this id")
                        }
                    }else{
                        print("Id must be Int")
                    }
                case "N","n":
                    check = false
                default:
                    print("error")
            }
        }        
    }while check
    var totalWithDiscount:Double = 0
    var memberID:Int?
    calPrice:while true{
        var selectMember:Member?
        memberLoop:while true{
            print("Do your have Member[Y|N]: ",terminator: "")
            if let input = readLine(){
                switch input{
                    case "Y","y":
                        print("Enter member ID: ",terminator: "")
                        if let inputID = Int(readLine()!){
                            if let thisID = member[inputID]{
                                selectMember = thisID
                                memberID = inputID
                                print("ID: \(memberID!) Name: \(userMember[inputID - 1].name) Member Type: \(selectMember!)")
                                break
                            }else{
                                print("no member ID")
                                continue memberLoop
                            }
                        }else{
                            print("ID must be Int")
                        }
                    case "N","n":
                         break
                    default:
                        print("wrong input")
                        continue memberLoop
                }
                break
            }
        }

        while true{
            totalWithDiscount = totalPrice * (1 - (selectMember?.discount ?? 0))
            print(selectMember != nil ? "Price Before discount : \(totalPrice) after : \(totalWithDiscount)" : "Price :\(totalWithDiscount)")
            print("Enter Money : ",terminator: "")
            if let input = Double(readLine()!){
                if input < totalWithDiscount{
                    print("Enter correct money")
                }else{
                    let change = input - totalWithDiscount
                    print(change == 0 ? "No change" : "\(change)")
                    break calPrice
                }
            }else{
                print("Input must be Double")
            }

        }
    }
    
    let thisBill = (order,bill,totalWithDiscount,memberID)
    if !bill.isEmpty{
        sellList.append(thisBill)//add bill in sellList
        order += 1
        // totalSell = .plus(totalSell, .price(totalWithDiscount))
        totalSellEscaping(function: totalWithDiscount)

    }
    // showSellList(thisSell: sellList)
    // print(sellList)
    pauseFunc()
}

func reStock(){
    repeat{
        system("claer")
        checkStock()
        print("Input Item ID: ",terminator: "")
        if let inputID = Int(readLine()!){
            if let index = checkID(thisItems: items, id: inputID){
                print("Input Quantity: ",terminator: "")
                if let inputQuantity = Int(readLine()!){
                    items[index].quantity += inputQuantity
                }else{
                    print("Quantity must be Int")
                }
            }else{
                print("not found this id")
            }
        }else{
            print("ID Must be Int")
        }
        print("Do you want to continue [Y|N]: ",terminator: "")
        if let conti = readLine(){
            switch conti{
                case "N","n":
                    return
                default:
                    continue
            }
        }
    }while true
}

func showSellList(thisSell: [(orderID: Int, items: [(id: Int, name: String, quantity: Int, price: Double)], total: Double,memberID:Int?)]) {
    print("+----------------------------------------------------------------------+")
    print("| Order ID |                  Items                  |      Total      |")
    print("+----------+-----------------------------------------+-----------------+")
    print("|          | ID |   Name   |   Quantity   |  Price   |                 |")
    print("-----------------------------------------------------------------------")

    for sell in thisSell {//main loop
        let paddingOrderID = String(sell.orderID).padding(toLength: 10, withPad: " ", startingAt: 0)
        let paddingTotal = String(format: "%.2f", sell.total).padding(toLength: 11, withPad: " ", startingAt: 0)
        let paddingMember:String
        if let member = sell.memberID{
            paddingMember = "\(member)".padding(toLength: 6, withPad: " ", startingAt: 0)

        }else{
            paddingMember = "nil   "
        }
        print("|   \(paddingOrderID) \(String(repeating: " ", count: 40))MemberID: \(paddingMember)|")
        print("-----------------------------------------------------------------------")

        for item in sell.items {//loop item
            let space = " ".padding(toLength: 10, withPad: " ", startingAt: 0)
            let paddingID = "\(item.id)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let paddingName = item.name.padding(toLength: 8, withPad: " ", startingAt: 0)
            let paddingQuantity = "\(item.quantity)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let paddingPrice = "\(item.price)".padding(toLength: 8, withPad: " ", startingAt: 0)
            print("|\(space)| \(paddingID)|  \(paddingName)|      \(paddingQuantity)|  \(paddingPrice)|\(String(repeating: " ", count: 17))|")
        }

        let total = "| \(String(repeating: " ", count: 51))|     \(paddingTotal) |"
        print("|----------------------------------------------------------------------|")
        print(total)
        print("+----------------------------------------------------------------------+")
    }
    let totalPrice = "\(excuteTotalSell())".padding(toLength: 12, withPad: " ", startingAt: 0)
    print("|\(String(repeating: " ", count: 25))TOTAL SELL\(String(repeating: " ", count: 18))     \(totalPrice)|")
    print("+----------------------------------------------------------------------+")
    pauseFunc()
}

//--------------------------Member-------------------------------------------------
var member:[Int:Member] = [:]
var userMember:[(id:Int,name:String)] = []
var memberID = 1

enum Member{
    case member,VIP

    var discount:Double{
        switch self{
            case .VIP:
                return 0.05
            case .member:
                return 0.02
        }
    }

}

func memberFunc(){
        while true{
            system("clear")
            print("+-----------------------+")
            print("| Select Option         |")
            print("| 1.Register Member     |")
            print("| 2.Re-Name             |")
            print("| 3.Show Member         |")
            print("| 4.Exit                |")
            print("+-----------------------+")
            if let input = readLine(){
                switch input{
                    case "1":
                        registerMember()
                    case "2":
                        reNameMember()
                    case "3":
                        showMember()
                    case "4":
                        return 
                    default:
                        print("worng input")
                        pauseFunc()
                }
            }

        }
}

func registerMember(){
    print("Register Member")
    while true{
        print("Enter Name: ",terminator: "")
        if let inputName = readLine(){
            print("choose Membership 1.member 2.VIP : ",terminator: "")
            var chooseMember:Member = .member
            check:while true{
                if let inputMember = readLine(){
                    switch inputMember{
                        case "1":
                            chooseMember = .member
                        case "2":
                            chooseMember = .VIP
                        default:
                            print("Wrong Input")
                            continue check
                    }
                    break
                }
            }
            let newMemberID = memberID
            member[newMemberID] = chooseMember
            userMember.append((id: newMemberID, name: inputName))
            
            print("Member registered: ID \(newMemberID), Name \(inputName), Membership \(chooseMember)")
            memberID += 1 // Increment memberID for the next member
            pauseFunc()

            return
        }
    }
}

func reName(name:inout String){
    while true{
        print("Enter your new Name: ",terminator: "")
        if let inputName = readLine(){

            print("Do your ok with this Name: \(inputName) [Y:N] : ",terminator: "")
            if let input = readLine(){
                switch input{
                    case "Y","y":
                        name = inputName
                        return
                    case "N","n":
                        continue
                    default:
                        print("wrong input")
                }
            }
        }
    }
}

func reNameMember(){
    mainRE:while true{
        print("Do you want to re Name [Y:N]: ")
        if let input = readLine(){
            switch input{
                case "Y","y":
                    ID:while true{
                        print("input Member ID : ",terminator: "")
                        if let inputID = Int(readLine()!){
                            if userMember.contains(where: {$0.id == inputID}){
                                print("Member Name: \(userMember[inputID - 1].name)")
                                reName(name: &userMember[inputID - 1].name)
                                return
                            }else{
                                print("Dont have this ID")
                                continue mainRE
                            }
                        }else{
                            print("ID Must be Int")
                        }
                    }

                case "N","n":
                    return
                default:
                    print("wrong input")     
            }
        }
    }
}

func showMember(){
    for member in userMember{
        print(member)
    }
    pauseFunc()
}
//--------------------------end Seller---------------------------------------------

//main
var main = true
while main {
    system("clear")
    print("+-----------------+")
    print("| Select Option:  |")
    print("+-----------------+")
    print("| 1.Create /Remove|")
    print("| 2.Show Items    |")
    print("| 3.Sell          |")
    print("| 4.Exit          |")
    print("+-----------------+")

    if let input = readLine() {
        switch input {
        case "1":
            createAndRemove()
        case "2":
            show()
        case "3":
            seller()
        case "4":
            main = false
        default:
            print("Invalid input.")
            pauseFunc()
        }
    }
}
