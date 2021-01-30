class Solution {

   public ListNode mergeKLists(ListNode[] lists) {
        if (lists == null || lists.length == 0) return null;
        return merge(lists, 0, lists.length - 1);
    }

    private ListNode merge(ListNode[] lists, int left, int right) {
        if (left == right) return lists[left];
        int mid = left + (right - left) / 2;
        ListNode l1 = merge(lists, left, mid);
        ListNode l2 = merge(lists, mid + 1, right);
        return mergeTwoLists(l1, l2);
    }

        public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        if(l1==null||l2==null){
            return l1==null?l2:l1;
        }
        ListNode head = null;
        if(l1.val<l2.val){
        head=l1;
        l1=l1.next;}else {
            head=l2;
            l2=l2.next;
        }
        ListNode tmp=head;
        while (true){
            if(l1==null){
                tmp.next=l2;
                return head;
            }
            if(l2==null){
                tmp.next=l1;
                return head;
            }
            if(l1.val<l2.val){
                tmp.next=l1;
                l1=l1.next;
            }else {
                tmp.next=l2;
                l2=l2.next;
            }
            tmp=tmp.next;
        }
    }
}
