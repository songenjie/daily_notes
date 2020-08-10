package main

import (
	"log"
	"strconv"
)

const SEG_COUNT = 4

var (
	ans      []string
	segments []int
)

func main() {
	restoreIpAddresses("1111")
	for i := 0; i < len(ans); i++ {
		log.Println(ans[i])
	}
}

func restoreIpAddresses(s string) []string {
	segments = make([]int, SEG_COUNT)
	ans = []string{}
	ipsdfs(s, SEG_COUNT)
	return ans
}

func ipsdfs(s string, segmentcount int) {
	if len(s) > 12 {
		return
	} else if len(s) > 9 && segmentcount < 3 {
		return
	} else if len(s) > 6 && segmentcount < 2 {
		return
	} else if len(s) > 3 && segmentcount < 1 {
		return
	}

	if segmentcount == 0 && len(s) == 0 {
		ipAddr := ""
		for i := 0; i < SEG_COUNT; i++ {
			ipAddr += strconv.Itoa(segments[i])
			if i != SEG_COUNT-1 {
				ipAddr += "."
			}
		}
		ans = append(ans, ipAddr)
		return
	}

	if segmentcount == 0 || len(s) == 0 {
		return
	}

	if s[0] == '0' {
		segments[4-segmentcount] = 0
		ipsdfs(s[1:], segmentcount-1)
		return
	}

	address := 0
	for i := 0; i < len(s) && i < 3; i++ {
		address = address*10 + int(s[i]-'0')
		if address > 0 && address <= 0xFF {
			segments[4-segmentcount] = address
			ipsdfs(s[i+1:], segmentcount-1)
		} else {
			break
		}
	}
}
