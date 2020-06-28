package main

/*
宋恩杰

(1). 跳跃表的每一层都是一条有序的链表.

(2). 跳跃表的查找次数近似于层数，时间复杂度为O(logn)，插入、删除也为 O(logn)。

(3). 最底层的链表包含所有元素。

(4). 跳跃表是一种随机化的数据结构(通过抛硬币来决定层数)。

(5). 跳跃表的空间复杂度为 O(n)。

有人可能会说，也可以采用二叉查找树啊，因为查找查找树的插入、删除、查找也是近似 O(logn) 的时间复杂度。

不过，二叉查找树是有可能出现一种极端的情况的，就是如果插入的数据刚好一直有序，

*/
import (
	"log"
	"math/rand"
	"strconv"
)

type Node struct {
	Value int
	Level int
	// 有 Level 个 Next Node 节点
	Next []*Node
}

var (
	maxLevel   = 10
	head       = &Node{}
	size       = 0
	levelCount = 1
)

func main() {
	head = NewNode(-1, maxLevel)

	for i := 0; i < 10; i++ {
		head.Insert(i)
	}
	head.PrintlnAll()
	for i := 0; i < 10; i++ {
		head.Search(i)
	}
	head.Delete(4)
	head.PrintlnAll()
	head.Search(3)
	head.Delete(4)
	head.Search(4)
	log.Println("size :" + strconv.Itoa(levelCount))
}

func NewNode(Value int, Level int) *Node {
	var temp = new(Node)
	temp.Init(Value, Level)
	return temp
}

func (this *Node) Init(Value int, Level int) {
	this.Value = Value
	this.Level = Level
	this.Next = make([]*Node, Level)
	/*for i := Level - 1; i >= 0; i-- {
		this.Next[i] = nil
	}*/
}

func (*Node) PrintlnAll() {
	log.Println("PrintlnAll")
	var temp = head

	for i := levelCount - 1; i >= 0; i-- {
		log.Println("Level :" + strconv.Itoa(i))
		for temp.Next[i] != nil {
			//fmt.Fprintf("%s ", strconv.Itoa(temp.Next[i].Value))
			log.Printf(" %d ", temp.Next[i].Value)
			temp = temp.Next[i]
		}
		temp = head
	}

	log.Println(" PrintlnAll end ")
}

func (*Node) Insert(Value int) {
	log.Println("Insert")
	if head.Search(Value) {
		log.Println(" value: " + strconv.Itoa(Value) + " alread exist! int list !")
		return
	}

	var tempNode = head
	var InertNode = NewNode(Value, GetLevel())
	log.Println("insert level :" + strconv.Itoa(InertNode.Level))

	// PreNode
	//var PreNode []*Node
	var PreNode = make([]*Node, InertNode.Level)

	for currentLevel := InertNode.Level - 1; currentLevel >= 0; currentLevel-- {
		for ; tempNode.Next[currentLevel] != nil && tempNode.Next[currentLevel].Value < Value; {
			tempNode = tempNode.Next[currentLevel]
		}
		// 这里是否需要初始化
		PreNode[currentLevel] = tempNode
	}

	//各个Level 插入
	for currentLevel := InertNode.Level - 1; currentLevel >= 0; currentLevel-- {
		InertNode.Next[currentLevel] = PreNode[currentLevel].Next[currentLevel]
		PreNode[currentLevel].Next[currentLevel] = InertNode
	}

	//当前链表最大Level
	if InertNode.Level > levelCount {
		levelCount = InertNode.Level
	}

	size++;
	log.Println("Insert end ")
}

func (*Node) Delete(Value int) {
	log.Println("delete " + strconv.Itoa(Value))

	var tempNode = head
	// PreNode

	//var PreNode []*Node
	var PreNode = make([]*Node, levelCount)
	for currentLevel := levelCount - 1; currentLevel >= 0; currentLevel-- {
		for ; tempNode.Next[currentLevel] != nil && tempNode.Next[currentLevel].Value < Value; {
			tempNode = tempNode.Next[currentLevel]
		}
		// 这里是否需要初始化
		PreNode[currentLevel] = tempNode
	}
	if tempNode.Next[0] != nil && tempNode.Next[0].Value == Value {
		size--
		log.Println("find " + strconv.Itoa(Value) + "success when delete it !")
		for currentLevel := levelCount - 1; currentLevel >= 0; currentLevel-- {
			//delete every level Next
			log.Println("curennt Level :" + strconv.Itoa(currentLevel))
			log.Println("current Node :" + strconv.Itoa(PreNode[currentLevel].Value))

			if PreNode[currentLevel].Next[currentLevel] != nil && PreNode[currentLevel].Next[currentLevel].Value == Value {
				PreNode[currentLevel].Next[currentLevel] = PreNode[currentLevel].Next[currentLevel].Next[currentLevel]
			}
		}
	} else {
		log.Println("not find " + strconv.Itoa(Value))
	}

	log.Println("delete end ")

}

func (*Node) Search(Value int) bool {
	log.Println("search")
	var tempNode = head
	for currentLevel := levelCount - 1; currentLevel >= 0; currentLevel-- {
		for ; tempNode.Next[currentLevel] != nil && tempNode.Next[currentLevel].Value < Value; {
			tempNode = tempNode.Next[currentLevel]
		}
	}
	if tempNode.Next[0] != nil && tempNode.Next[0].Value == Value {
		log.Println("find " + strconv.Itoa(Value) + " success !")
		return true
	}
	log.Println("find " + strconv.Itoa(Value) + " false !")
	log.Println("search end")
	return false
}

func GetLevel() int {
	return rand.Intn(maxLevel-1) + 1
}
