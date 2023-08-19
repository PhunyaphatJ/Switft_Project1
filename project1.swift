import Foundation

var user:[(id:String,password:String)] = [(id:"Joe",password:"123")]
var items:[(id:Int,name:String,quantity:Int,price:Double)] = []
var sellList:[[(id:Int,name:String,quantity:Int,price:Double)]] = []
//for test
items.append((id:0,name:"items1",quantity:30,price:20.0))
items.append((id:1,name:"items2",quantity:15,price:50))
items.append((id:2,name:"items3",quantity:5,price:5))
items.append((id:3,name:"items4",quantity:60,price:15))
items.append((id:4,name:"items5",quantity:35,price:33.3))
//

var id:Int = 0

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
                addItem()
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
//add function
func addItem(){
    system("clear")
    print("+------------+")
    print("|   addItem  |")
    print("+------------+")
    print("Enter item[\(id)] details:")
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
    
    let newItem = (id:id,name:name,quantity:quantity!,price:price!)
    print("add item:\(newItem)")
    pauseFunc()
    items.append(newItem)
    id += 1//every create item id + 1
}
//------------------end add--------------------

//check array index
func checkArray(index:Int)->Bool{
    return index >= items.count ? false : true
}
//decrease
func decreaseID(index:Int){
    for i in index..<items.count{//id after element index - 1
        items[i].id -= 1
    }
    id -= 1
}

//checkID
func checkID(thisItems:[(id:Int,name:String,quantity:Int,price:Double)],id:Int)->Int{
    var i = 0
    for item in thisItems{
        if item.id == id {
            break
        }
        i = i + 1
    }
    return i
}

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
        for i in 0..<items.count{
            if(items[i].name == input){//check input if found remove 
                let remove = items.remove(at:i)
                print("remove Id:\(i) name:\(input) ",remove)
                decreaseID(index:i)
                return
            }
        }
        print("items dont have item name \(input)")
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
                decreaseID(index:input)
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
        for item in items{
            if item.name == input{
                print("\nID: \(item.id) Name: \(item.name) Quantity: \(item.quantity) price: \(item.price)\n")
                return
            }
        }
        print("not found")
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
        print("1.Sell Item")
        if let input = readLine(){
            switch input{
                case "1":
                    sellItem()
                case "3":
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
    var bill:[(id:Int,name:String,quantity:Int,price:Double)] = []
    // system("clear")
    print("+------------+")
    print("|  SellItem  |")
    print("+------------+")
    sell:repeat {
        showAll(thisItems: items)
        showAll(thisItems: bill)
        print("Do You want to sell (Y|N): ",terminator: "")
        if let input = readLine(){
            switch input{
                case "Y","y":
                    print("sell Item ID: ",terminator: "")
                    if let inputID = Int(readLine()!){
                        let indexA = checkID(thisItems: items, id: inputID)
                        if items[indexA].quantity == 0{
                            print("items is empty")
                            pauseFunc()
                        }else{
                            if items.contains(where: {$0.id == inputID}){
                                quantityLoop:while true{
                                    print("Quantity: ",terminator: "")
                                    if let inputQuantity = Int(readLine()!){
                                        if items[indexA].quantity >=  inputQuantity{
                                            if bill.contains(where: {$0.id == inputID}){
                                                let indexB = checkID(thisItems: bill, id: inputID)
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
                                        continue sell
                                    }else{
                                        print("quantity must be Int")
                                        continue quantityLoop
                                    }
                                }
                            }else{
                                print("no items id")
                            }
                        }
                    }else{
                        print("Id must be Int")
                    }
                case "3":
                    check = false
                default:
                    print("error")
            }
        }        
    }while check
    sellList.append(bill)
    print(sellList)
    pauseFunc()
}

//-------------------end seller------------------


//main
var main = true
while main {
    system("clear")
    print("+-----------------+")
    print("| Select Option:  |")
    print("+-----------------+")
    print("| 1.Create /Remove|")
    print("| 2.Show Items    |")
    print("| 3.Seller        |")
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
