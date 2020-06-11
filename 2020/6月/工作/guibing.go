package main

import (
	"log"
)

var arr = []int{1, 2, 3, 4, 7, 3, 4, 5, 6, 7, 2, 1, 3, 45, 1, 2, 3, 4, 5}

var copy_arr = make([]int ,len(arr))

func main() {

	mergeSort(0, len(arr)-1)

	for k, i := range arr {
		log.Println(k,i)
	}
}

func mergeSort(left int, right int) {

	if left < right {

		// 内存越界问题
		var mid = left + (right-left)/2

		mergeSort(left, mid)

		mergeSort(mid+1, right)

		merge(left, mid, right)
	}
}

func merge(left int, mid int, right int) {

	var i = left
	var j = mid + 1
	var k = left

	for ; i <= mid && j <= right; k++ {
		if arr[i] < arr[j] {
			copy_arr[k] = arr[i]
			i++
		} else {
			copy_arr[k] = arr[j]
			j++
		}
	}


	// 下面for 只会走一个
	for ; i <= mid; i++ {
		copy_arr[k] = arr[i]
		k++
	}

	for ; j <= right; j++ {
		copy_arr[k] = arr[j]
		k++
	}

	//arr【left,right] 赋值
	for i = left; i < k; i++ {
		arr[i] = copy_arr[i]
	}
}
