import Foundation

var items:[(id:Int,name:String,quantity:Int,price:Double)] = []
//for test
items.append((id:0,name:"items1",quantity:30,price:20.0))
items.append((id:1,name:"items2",quantity:15,price:50))
items.append((id:2,name:"items3",quantity:5,price:5))
items.append((id:3,name:"items4",quantity:60,price:15))
items.append((id:4,name:"items5",quantity:35,price:33.3))
//

var id:Int = 0

//add function
func addItem(){
    print("Enter item[\(id)] details:")
    print("Name: ",terminator:"")
    let name = readLine()!
    
    var quantity:Int?
    //check input quantity if not Int ,loop until input correct value
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
    items.append(newItem)
    id += 1//every create item id + 1
}

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
        print("+------------------+")
        print("| Select remove    |")
        print("| 1.remove by Name |")
        print("| 2.remove by ID   |")
        print("| 3.exit           |")
        print("+------------------+")
        if let input = readLine(){
            switch input{
                case "1":
                    removeByName()
                    pauseFunc()
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
    print("| removeByID |")
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


// func show(){
//     system("clear")
//     var check = true
//     while check{
//         print("+---------------------------+")
//         print("1.ShowDetail")
//         print("2.ShowByID")
//         print("3.ShowByName")
//         if let input = readLine(){
//             switch input{
//                 case "1":
//                     print()
//             }
//         }
//     }
// }


//show item
func showDetail(){
    system("clear")
    print("+----------------------------------------+")
    print("| ID |   Name   |   Quantity   |  Price  |")
    print("------------------------------------------")
    for item in items{
       let pID = "\(item.id)".padding(toLength: 4, withPad: " ", startingAt: 0)
       let pName = item.name.padding(toLength: 10, withPad: " ", startingAt: 0)
       let pQuantity = "\(item.quantity)".padding(toLength: 14, withPad: " ", startingAt: 0)
       let pPrice = "\(item.price)".padding(toLength: 9, withPad: " ", startingAt: 0)
       print("|\(pID)|\(pName)|\(pQuantity)|\(pPrice)|")
       print("------------------------------------------")
    }
}


func pauseFunc(){
    print("Enter someThing....",terminator:"")
    _ = readLine()
}


var main = true
while main {
    system("clear")
    print("+-----------------+")
    print("| Select Option:  |")
    print("+-----------------+")
    print("| 1.Create Item   |")
    print("| 2.remove Item   |")
    print("| 3.Add Item      |")
    print("| 3.show Detail   |")
    print("+-----------------+")
    if let input = readLine() {
        switch input {
        case "1":
            addItem()
            pauseFunc()
        case "2":
            remove()
        case "3":
            showDetail()
            pauseFunc()
        case "4":
            main = false
        default:
            print("Invalid input.")
            pauseFunc()
        }
    }
}








