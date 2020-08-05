package main

import "log"

func main() {
	var arr1 = []int{1, 2, 3, 4, 5, 7, 8, 9, 10, 201, 400}

	var arr2 = []int{1, 2, 3, 5, 7, 89, 100, 201, 202, 203}

	for i := 1; i <= len(arr1)+len(arr2); i++ {
		log.Println(findk(arr1, arr2, i))
	}
}

func findk(arr1 []int, arr2 []int, k int) int {
	if k > (len(arr1)+len(arr2)) || k <= 0 {
		return 0
	}
	return (find(arr1, 0, len(arr1)-1, arr2, 0, len(arr2)-1, k))
}

func find(arr1 []int, l1 int, r1 int, arr2 []int, l2 int, r2 int, k int) int {

	//k-(mid2-l2+1) 的越界
	if l1 > r1 {
		return arr2[l2+k-1]
	}
	if l2 > r2 {
		return arr1[l1+k-1]
	}

	//输出
	if k <= 1 {
		return Min(arr1[l1], arr2[l2])
	}
	// 越界
	mid1 := Min(l1+k/2-1, r1)
	mid2 := Min(l2+k/2-1, r2)

	if arr1[mid1] < arr2[mid2] {
		return find(arr1, mid1+1, r1, arr2, l2, mid2, k-(mid1-l1+1))
	} else if arr1[mid1] > arr2[mid2] {
		return find(arr1, l1, mid1, arr2, mid2+1, r2, k-(mid2-l2+1))
	}
	//很多没有测试过debug 都出现在了这
	if mid1+mid2+2 == k {
		return arr1[mid1]
	}
	//比如 测试中第三个数字 mid+mid2+2<k 没有结束 前面的都可以去掉
	return find(arr1, mid1+1, r1, arr2, mid2+1, r2, k-(mid2-l2+1)-(mid1-l1+1))
}

func Min(x, y int) int {
	if x < y {
		return x
	}
	return y
}
