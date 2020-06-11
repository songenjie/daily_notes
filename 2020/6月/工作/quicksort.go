package main

import "log"

var arr = []int{1, 2, 3, 4, 7, 3, 4, 5, 6, 7, 2, 1, 3, 45, 1, 2, 3, 4, 5}


var icount = 0

func main() {

	log.Println(arr)

	quickSort(0, len(arr)-1)

	log.Println(arr)

}

func quickSort(left int, right int) {
	if (left < right) {

		// mid 就是 a[left] 数值
		mid := segment(left, right)

		log.Println(left, mid, right)

		// 切记 mid 是你已经比较过的数据 不要再比较，死循环

		quickSort(left, mid-1)

		quickSort(mid+1, right)

	}
	return
}

func segment(left int, right int) int {

	var temp = arr[left]

	var j = right
	var i = left + 1

	// 这里主要是把 temp 为比较值
	// 将小于 temp 和 大于temp 的两个值做替换
	for i < j {

		for i <= j && arr[i] <= temp {
			i++
		}

		for i <= j && arr[j] >= temp {
			j--
		}

		// 终止
		if i >= j {
			break
		}

		var current = arr[i]
		arr[i] = arr[j]
		arr[j] = current
	}

	// 这里就是 与第一句 left 和 j 做替换 ,将比较的值放到对应的中间为止
	arr[left] = arr[j]
	arr[j] = temp

	log.Println(arr)

	return j;
}
