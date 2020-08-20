package main

import (
	"log"
	"strings"
)

/*
. 属性字符串解析

连续的K=V的字符串，每个K=V之间用”,”分隔，V中可嵌套K=V的连续字符串结构，例如“
key1=value1,key2=value2,key3=[key4=value4,key5=value5,key6=[key7=value7]],key8=value8
请编写如下函数，给定字符串，输出嵌套结构的HashMap

HashMap<String, Object> parse(String input) {
…
}

要求：不可使用递归


作者: 宋恩杰

方案一
k v 入栈

方案二
通过右括号原子性解析

*/

var LeftQuota []int
var RightQuota []int

func main() {
	var hashstring = "key1=value1,key2=value2,key3=[key4=value4,key5=value5,key6=[key7=value7],key8=value8],key10=[key11=value11,key12=[key13=value13],key14=value14]"
	//var hashstring = "key1=value1,key2=value2,key3=[key4=value4,key5=value5,key6=[key7=value7],key8=value8],key10=[key11=value11]"
	Hashmap := parser(hashstring)

	for k, v := range Hashmap {
		log.Printf("k: %v   v: %v ", k, v)
	}
}

func parser(hashstring string) map[string]interface{} {

	QuotaInit(hashstring)

	var QuotaCount = len(LeftQuota)
	var LeftIndex = QuotaCount - 1
	var RightIndex = QuotaCount - LeftIndex - 1

	var key, keylength = FindLastKeyBerforLeftQuota(hashstring[0:LeftQuota[LeftIndex]])
	var HashMap = make(map[string]interface{}, 100)
	var CurrentHashMap = make(map[string]interface{}, 100)
	var RightIndexAdd = 0
	var binner = false



	for {

		var ReturnHashMap = make(map[string]interface{}, 100)
		for k, v := range CurrentHashMap {
			ReturnHashMap[k] = v
		}
		CurrentHashMap = make(map[string]interface{}, 100)

		if LeftIndex < 0 {
			CurrentHashMap = ParserSimpleHashString(hashstring)
			for k, v := range ReturnHashMap {
				HashMap[k] = v
			}
			for k, v := range CurrentHashMap {
				HashMap[k] = v
			}
			break
		}

		key, keylength = FindLastKeyBerforLeftQuota(hashstring[0:LeftQuota[LeftIndex]])

		for i := 0; i < len(RightQuota); i++ {
			if RightQuota[i] > LeftQuota[LeftIndex] {
				RightIndex = i
				break
			}
		}

		if LeftIndex > 0 {
			for i := 0; i < len(RightQuota); i++ {
				if RightQuota[i] > LeftQuota[LeftIndex-1] {
					RightIndexAdd = i
					if RightIndexAdd == RightIndex {
						RightIndexAdd++
					}
					break
				}
			}
		} else {
			RightIndexAdd = RightIndex + 1
		}

		mapvalue := ParserSimpleHashString(hashstring[LeftQuota[LeftIndex]+1 : RightQuota[RightIndex]])

		if binner {
			for k, v := range ReturnHashMap {
				mapvalue[k] = v
			}
			CurrentHashMap[key] = mapvalue
		} else {
			for k, v := range ReturnHashMap {
				CurrentHashMap[k] = v
			}
			CurrentHashMap[key] = mapvalue
		}

		//潜逃类型
		if LeftIndex > 0 && LeftQuota[LeftIndex-1] < LeftQuota[LeftIndex] && LeftQuota[LeftIndex] < RightQuota[RightIndex] && RightQuota[RightIndex] < RightQuota[RightIndexAdd] {
			//最外层结构
			binner = true
		} else {
			binner = false
			HashMap[key] = mapvalue
			CurrentHashMap = nil
		}

		//clear

		sourcelength := len(hashstring)
		hashstring = hashstring[0:LeftQuota[LeftIndex]-keylength-2] + hashstring[RightQuota[RightIndex]+1:]
		distlength := len(hashstring)
		for i := RightIndex; i < len(RightQuota); i++ {
			RightQuota[i] = RightQuota[i] - sourcelength + distlength
		}
		LeftQuota = append(LeftQuota[0:LeftIndex], LeftQuota[LeftIndex+1:]...)
		RightQuota = append(RightQuota[0:RightIndex], RightQuota[RightIndex+1:]...)

		//index
		LeftIndex--
		//RightIndex++
	}

	return HashMap
}

//查找可以
func FindLastKeyBerforLeftQuota(s string) (string, int) {
	//去掉等于号
	s = s[:len(s)-1]
	stringarray := strings.Split(s, ",")
	//返回最后一个key
	return stringarray[len(stringarray)-1], len(stringarray[len(stringarray)-1])

}

//k1=v1,k2=v2
func ParserSimpleHashString(simpehastring string) map[string]interface{} {
	if strings.LastIndex(simpehastring, "=") == len(simpehastring)-1 {
		simpehastring = simpehastring[0:strings.LastIndex(simpehastring, ",")]
	}
	ArraykvString := strings.Split(simpehastring, ",")

	var ReturnKeMap = make(map[string]interface{}, 10)
	for i := 0; i < len(ArraykvString); i++ {
		k, v := ParserkvString(ArraykvString[i])
		ReturnKeMap[k] = v
	}
	return ReturnKeMap
}

// kv 解析
func ParserkvString(kvstring string) (string, string) {
	kv := strings.Split(kvstring, "=")
	return kv[0], kv[1]
}

//合法校验
func QuotaCheck(s string) bool {
	if strings.Count(s, "[") == strings.Count(s, "]") {
		return true
	}
	return false
}

//入栈
func QuotaInit(s string) {

	for i := 0; i < len(s); i++ {
		switch s[i] {
		case '[':
			LeftQuota = append(LeftQuota, i)
		case ']':
			RightQuota = append(RightQuota, i)
		default:

		}
	}
}
