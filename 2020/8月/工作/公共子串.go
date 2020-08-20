package main

import "log"

/*
2. 有序int数组的多路归并

给定N（N<=1024）个int数组，每个int[]的值都是有序的
这些数组的长度不一定相同（在0到1000000随机）

请用尽可能最高效的方式来归并有序输出每个数组中都包含的元素（各数组中AND条件归并）
int[] andMerge(intN) {
…
}
*/
var IntArray = [][]int{{1, 2, 3, 4, 5, 6, 7, 8}, {1, 2, 3, 4}, {3, 4, 5, 6}, {3, 4, 5, 6, 7, 8, 9, 10}, {2, 3, 4, 5, 6}, {3}, {3, 6}, {3, 4, 5, 6}}

func main() {

	array := andMerge()
	log.Println(array)

}

func andMerge() []int {
	var SmallArrayLength = 65535
	var SmallArray = make([]int, 1)
	var allcount = len(IntArray)
	var RetrunArray = []int{}

	for _, array := range IntArray {
		if len(array) < SmallArrayLength {
			SmallArrayLength = len(array)
			SmallArray = array
		}
	}

	var MapKeyCount = make(map[int]int, len(SmallArray))

	for _, member := range SmallArray {
		for _, array := range IntArray {
			if FindMember(array, 0, len(array)-1, member) {
				MapKeyCount[member]++
			}
		}
	}
	for k, v := range MapKeyCount {
		if v == allcount {
			RetrunArray = append(RetrunArray, k)
		}
	}
	return RetrunArray
}

func FindMember(Array []int, Left, Right, member int) bool {
	if Left >= Right {
		if Array[Left] == member {
			return true
		}
		return false
	}
	mid := Left + (Right-Left)/2

	if Array[mid] > member {
		return FindMember(Array, Left, mid-1, member)
	} else if Array[mid] < member {
		return FindMember(Array, mid+1, Right, member)
	} else {
		return true
	}

}
