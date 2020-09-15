```go
package main

import (
    "fmt"
)

type struct NodeList{
    Value int 
    Next  *NodeList
}


func main() {
    Head NodeList;
    //a := 0
    //fmt.Scan(&a)
    
    fmt.Printf("Hello World!\n");
}


func ReversetList(Head *Nodelist, K int) *NodeList {
    if Head == nil || Head->Next == nil {
        return Head
    }
    var Cur = Head;
    
    for i:=1;Cur != nil && i<K;i++ ;{
        Cur = Cur.Next;
    }
    
    if Cur == nil {
        return Head;
    }
    
    var temp = Cur.Next
    Cur.Next = nil
    
    
    newNodeHead := Reverse(Head)
    
    NewTempHead := ReversetList(temp, K)
    
    Cur->Next = NewTempHead
    
    return newNodeHead 
 
}

func Reverse(Head *NodeList)*NodeList {
    if Head == nil || Head->Next == nil {
        return Head;
    }
    
    newNodeHead := Reverse(Head->Next)
    Head->Next->Next = Head
    Head->Next = nil
    return newNodeHead
    
}
```

