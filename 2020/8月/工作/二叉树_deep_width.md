# 1.二叉树的深度

**题目：**
输入一个二叉树的根结点，求该树的深度。从根结点到叶子结点依次经过的结点（含根、叶结点）形成树的一条路径，最长路径的长度包含的结点数为树的深度，即二叉树结点的层数。

**二叉树结点定义：**

```
struct BinaryTreeNode {
	int m_value;
	BinaryTreeNode* m_pLeft;
	BinaryTreeNode* m_pRight;
};
12345
```

**二叉树示例：**
以图深度为四的二叉树为例，其先先根遍历序列为：{1,2,4,5,7,3,6}，中根遍历序列为：{4,2,7,5,1,3,6}，根据先根序列和中根序列即可构造唯一的二叉树，构造的具体实现可参见：[二叉树构建](https://dablelv.blog.csdn.net/article/details/106332304)。很显然，该二叉树有 4 层结点，所以其高度是 ４。

![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTYwNDA2MTYzMDU3NzQ4?x-oss-process=image/format,png)

**求解思路：**
根据题目的定义，我们可以用先根次序来遍历二叉树中所有根结点到叶结点的路径，得到最长的路径就是二叉树的高度。但是这样的代码量较为冗长，我们可以采用递归的方式解决。

我们可以从根结点即左右子树来理解二叉树的深度。对于任意一棵非空二叉树，有如下四种情况：
（1）如果一颗树只有一个结点，它的深度是 1；
（2）如果根结点只有左子树而没有右子树，那么二叉树的深度应该是其左子树的深度加 1；
（3）如果根结点只有右子树而没有左子树，那么二叉树的深度应该是其右树的深度加 1；
（4）如果根结点既有左子树又有右子树，那么二叉树的深度应该是其左右子树的深度较大值加 1。

**实现代码：**

```
int treeDepth(BinaryTreeNode* root) {
	if(root==NULL) {
		return 0;
	}
	int nLeft=treeDepth(root->m_pLeft);
	int nRight=treeDepth(root->m_pRight);
	return nLeft>nRight?nLeft+1:nRight+1;
}
12345678
```

# 2.二叉树的宽度

**题目：**
给定一颗二叉树，求二叉树的宽度。

**宽度的定义：**
二叉树的宽度定义为具有最多结点数的层中包含的结点数。

![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTYwNDA2MTcxODI3NDg1?x-oss-process=image/format,png)

比如上图中，第 1 层有 1 个结点， 第 2 层有 2 个结点， 第 3 层有 4 个结点， 第 4 层有 1 个结点。可知，第 3 层的结点数最多，所以这棵二叉树的宽度是 4。

**求解思路：**
这里需要用到二叉树的层次遍历，即广度优先周游。在层次遍历的过程中，通过读取队列中保留的上一层的结点数来记录每层的结点数，以获取所有层中最大的结点数。关于二叉树广度优先周游，参考：[二叉树的遍历](https://dablelv.blog.csdn.net/article/details/106277346)。

**具体实现：**

```
//求二叉树的宽度  
int treeWidth(BinaryTreeNode *pRoot) {
    if (pRoot == NULL) return 0;
    
    queue<BinaryTreeNode*> myQueue;  
    myQueue.push(pRoot);		// 将根结点入队列
	int nWidth = 1;				// 二叉树的宽度
    int nCurLevelWidth = 1;		// 记录当前层的宽度
    BinaryTreeNode *pCur = NULL;
  
	// 队列不为空
    while (!myQueue.empty()) {
        while (nCurLevelWidth != 0) {
            pCur = myQueue.front();	// 取出队首元素
            myQueue.pop();			// 队首元素出队列
  
            if (pCur->m_pLeft != NULL) myQueue.push(pCur->m_pLeft);
            if (pCur->m_pRight != NULL) myQueue.push(pCur->m_pRight);
            nCurLevelWidth--;
        }
  
        nCurLevelWidth = myQueue.size();
        nWidth = nCurLevelWidth > nWidth ? nCurLevelWidth : nWidth;
    }
    return nWidth;  
}
1234567891011121314151617181920212223242526
```

------

# 参考文献

[1] 何海涛.剑指Offer[M].电子工业出版社.
[2] [CSDN.求二叉树的深度和宽度](http://blog.csdn.net/htyurencaotang/article/details/12406223#comments)