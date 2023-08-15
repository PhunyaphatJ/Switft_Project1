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
            print(pri)
            price = pri
        }else{
            print("price must be Double")
        }
    }
    
    id += 1//every create item id + 1
    let newItem = (id:id,name:name,quantity:quantity!,price:price!)
    items.append(newItem)
}

//check array index
func checkArray(index:Int)->Bool{
    return index >= items.count ? false : true
}


//romove Item
func remove(){
    var check = false
    repeat{
        print("Select remove")
        print("1.remove by text")
        print("2.remove by ID")
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
            print("error")
        }
    }while(check == false)
    
    
    
}

func removeByText(){
    print("1")
}


//remove array by ID
func removeByID(){
    var check = true
    print("romoveByID")
    remove:while check{
        if let input = Int(readLine()!){
            if checkArray(index:input){//if found remove this index if not continue loop
                let remove = items.remove(at:input)
                print("remove Id:\(input) :",remove)
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
    print("+------------------------------+")
    print("| ID |   Name   |   Quantity   |")
    print("--------------------------------")
    for item in items{
        print("|\(item.id)|\(item.name)| \(item.quantity)|")
        print("---------------------------")
    }
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
        case "2":
            remove()
        case "3":
            showDetail()
        case "4":
            main = false
        default:
            print("Invalid input.")
        }
    }
}








