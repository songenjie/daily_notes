页:操作系统必须以页为单位管理内存.

块:文件系统最小寻址单元,又称为文件块和io块

扇区:块设备中最小寻址单元是扇区,扇区这一术语在内核中重要是因为所有设备的io必须以扇区为单位操作


其中,一个页可以有多个块,一个块有多个扇区

缓冲区:磁盘块在内存中的表示




可以看到几个名词：heads/sectors/cylinders，分别就是磁头/扇区/柱面，每个扇区512byte（现在新的硬盘每个扇区有4K）了

硬盘容量就是heads*sectors*cylinders*512=255*63*17844*512=146771896320b=146.7G

注意：硬盘的最小存储单位就是扇区了，而且硬盘本身并没有block的概念。

```
struct buffer_head {

         unsigned long b_state;
         struct buffer_head *b_this_page;
         struct page *b_page;
         atomic_t b_count;
         u32 b_size;
         sector_t b_blocknr;
         char *b_data;
         struct block_device *b_bdev;
         bh_end_io_t *b_end_io;
         void *b_private;
         struct list_head b_assoc_buffers;
}
```

b_state：对块缓冲区状态的描述。
b_this_page：在一个页框中，可能包含多个块缓冲区。一个页框内的所有缓冲区形成循环链表，该字段指向下一个块缓冲区。
b_page：指向缓冲区所在页框的描述符。
b_size：块缓冲区大小。
b_data：当前块在作为缓冲的页框内的位置。
b_bdev：指向块设备的指针
