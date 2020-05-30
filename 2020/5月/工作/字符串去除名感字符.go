package main
/*
* code by songenjie
*/
import "log"

type BTree_DeleteNode struct {
	Childs []*BTree_DeleteNode
	Data   string
	Bend   bool
}

var p1 int
var p2 int

var source = "135792465843790214365"

func main() {

	p1 = 0
	p2 = 0

	var deletesource []string;
	deletesource = append(deletesource, "79")
	deletesource = append(deletesource, "7924")
	deletesource = append(deletesource, "43")
	deletesource = append(deletesource, "5")

	//构建 btree
	var Root = &BTree_DeleteNode{}
	Root.Data = "/"
	var CurrentNode = Root
	for _, sourceone := range deletesource {
		log.Println(sourceone)
		for i := 0; i < len(sourceone); i++ {
			var existence = false
			for _, Child := range CurrentNode.Childs {
				if Child.Data == sourceone[i:i+1] {
					existence = true
					CurrentNode = Child
				}
			}
			// 自节点为空或者不存在的时候
			if !existence {
				var tempNode BTree_DeleteNode
				tempNode.Data = sourceone[i : i+1]
				CurrentNode.Childs = append(CurrentNode.Childs, &tempNode)
				CurrentNode = &tempNode
			}
		}
		CurrentNode.Bend = true
		CurrentNode = Root
	}

	PrintlnNode(Root)

	for p1 = 0; p1 < len(source); p1 = p2 {
		CurrentNode = Root
		Erase(CurrentNode)
	}

	log.Println(source)
}

func Erase(Node *BTree_DeleteNode) {
	if p2 >= len(source) {
		return
	}
	var bEnd = false
	for _, child := range Node.Childs {
		var distmem = source[p2 : p2+1]
		//是否 存在匹配节点
		if child.Data == distmem {
			if child.Bend {
				source = source[:p1] + bling() + source[p2+1:]
				log.Println(source)
				bEnd = true
			}
			//移动到下一个节点
			p2++
			Erase(child)
		}
	}
	// if not Bend
	if !bEnd {
		p2 = p1 + 1
	}
}

func bling() string {
	var bling = ""
	for ; p1 <= p2; p1++ {
		bling += "*"
	}
	p1--
	return bling
}

func PrintlnNode(Node *BTree_DeleteNode) {
	if len(Node.Childs) == 0 {
		return
	}
	for _, node := range Node.Childs {
		log.Println("data :" + node.Data)
		PrintlnNode(node)
	}
}

