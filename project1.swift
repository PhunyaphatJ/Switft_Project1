import Foundation

var items:[(id:Int,name:String,quantity:Int,price:Double)] = []
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
        if let quanti = Int(readLine()!){
            quantity = quanti
        }else{
            print("quantity must be Int")
        }
    }
    
    var price:Double?
    //check input price
    while(price == nil){
        print("Price each: ",terminator:"")
        if let pri = Double(readLine()!){
            price = pri
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

func decreassId(index:Int){
    for i in index..<items.count{//id after element index - 1
        items[i].id -= 1
    }
    id -= 1
}

//romove Item
func remove(){
    if(items.isEmpty){
        print("items is empty cannot remove")
        pause()
        return
    }
    system("clear")
    var check = false
    repeat{
        print("Select remove")
        print("1.remove by text")
        print("2.remove by ID")
        print("3.exit")
        if let input = readLine(){
            switch input{
                case "1":
                    removeByText()
                case "2":
                    removeByID()
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

func removeByText(){
    system("clear")
    if let input = readLine(){
        for i in 0..<items.count{
            if(items[i].name == input){
                let remove = items.remove(at:i)
                print("remove Id:\(i) name:\(input) ",remove)
                decreassId(index:i)
                break
            }
        }
    }
}


//remove array by ID
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
                decreassId(index:input)
                check = false
            }else{
                print("not found this index")
            }
        }else{
            print("input must be Int")
        }
    }
}

//show item
func showDetail(){
    system("clear")
    print("+------------------------------+")
    print("| ID |   Name   |   Quantity   |")
    print("--------------------------------")
    for item in items{
        print("\(item.id)|\(item.name)| \(item.quantity)|")
        print("---------------------------")
    }
}


func pause(){
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
            pause()
        case "2":
            remove()
            pause()
        case "3":
            showDetail()
            pause()
        case "4":
            main = false
        default:
            print("Invalid input.")
            pause()
        }
    }
}








