```

package main
 
import (
    "fmt"
    "strings"
)
 
func main() {
    fmt.Println(strings.EqualFold("HELLO", "hello"))
    fmt.Println(strings.EqualFold("ÑOÑO", "ñoño"))
}
```
