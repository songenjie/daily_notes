public class MergeMultiSortedLists {

    /**
     * Definition for singly-linked list.
     * public class ListNode {
     *     int val;
     *     ListNode next;
     *     ListNode(int x) { val = x; }
     * }
     */
    public class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }

    public ListNode mergeKLists(ListNode[] lists) {
        if(lists == null) {
            return null;
        }
        int length = lists.length;

        ListNode head = new ListNode(0);
        ListNode sortedNode = head;
        // 保存已经完结的ListNode
        Set<Integer> endSet = new HashSet<>();
        // 当不是所有ListNode都已经完结时,一直遍历
        while(endSet.size() < length) {
            ListNode minNode = null;
            int min = Integer.MAX_VALUE;
            int minIndex = 0;
            boolean enter = false;
            for(int i = 0; i < length; i++) {
                // 如果当前ListNode已经遍历完
                if(lists[i] == null) {
                    // 如果是第一次遍历完,加入set
                    if(!endSet.contains(i)) {
                        endSet.add(i);
                    }
                    continue;
                }
                int val = lists[i].val;
                if(val < min) {
                    enter = true;
                    minIndex = i;
                    min = val;
                    minNode = lists[i];
                }
            }
            if(enter) {
                lists[minIndex] = lists[minIndex].next;
                sortedNode.next = minNode;
                sortedNode = sortedNode.next;
            }

        }
        return head.next;
    }

}
