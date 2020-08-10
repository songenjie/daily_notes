package main

/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}


func inorderTraversal(root *TreeNode) []int {
	return inorderRecursive(root)
}

func inorderRecursive(root *TreeNode) []int {
	if root == nil {
		return []int{}
	}
	rest := append(inorderRecursive(root.Left), root.Val)
	rest = append(rest, inorderRecursive(root.Right)...)
	return rest
}
