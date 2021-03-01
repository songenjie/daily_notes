今天写一篇文章涉及到LFU的原理，所以想给出代码实现，这样细节才更加清楚，下面是leetcode上的代码，我觉得挺好的，但是leetcode没有给出解释，我在这里先给出代码原理，感兴趣的同学可以看下代码。

首先和LRU类似，是由一个list加hashtable构成，只不过list包含了2层如下图，list第一层是访问频率，第二层是相同频率下的LRU链表，最新被访问的放在LRU链表的头。

```text
1<-->2<-->3<-->4
|    |
kv   kv
|    |
kv   kv
```

hashtable是一个unordered_map，key是LFU元素key,value对里的key，value是一个结构体，里面包含了该元素在list中第一层的位置和第二层的位置

```text
struct mapNode {
    int val; 
    list<pair<int, list<int>>>::iterator level_it; 
    list<int>::iterator sub_level_it; 

    mapNode(int v) {
        val = v;
    }
};
```

核心的idea是：如果某个元素被访问了，就把该元素移动到更大频率对应的LRU的头部，如果这个频率不存在，就创建一个新的LRU。

整体代码：

```text
class LFUCache {
    
struct mapNode {
    int val; 
    list<pair<int, list<int>>>::iterator level_it; 
    list<int>::iterator sub_level_it; 
    
    mapNode() {
        
    }

    mapNode(int v) {
        val = v;
    }
};
    
    
    
    void printDeck() {
        for (auto it : lfreq) {
            cout << it.first << ": ";
            for (auto it2 : it.second) {
                cout << it2 << ' '; 
            }cout << endl; 
        }
    }
public:
    LFUCache(int capacity) {
        n = capacity; 
    }
    
    int get(int key) {
        if (n == 0) {
            return -1; 
        }
        // cout << "GET: " << key << endl; 
        auto it = lmap.find(key); 
        if (it == lmap.end()) {
            // cout << -1 << endl; 
            return -1; 
        }
        
        auto cur_lvl_it = (it -> second).second.level_it; 
        // cout << cur_lvl_it -> first << ' '; 
        auto cur_sub_lvl_it = (it -> second).second.sub_level_it; 
        // cout << (*cur_sub_lvl_it) << ' '; 
        (cur_lvl_it -> second).erase(cur_sub_lvl_it); 
        if (cur_lvl_it == lfreq.begin() || prev(cur_lvl_it) -> first > cur_lvl_it -> first + 1) {
            lfreq.insert(cur_lvl_it, make_pair(cur_lvl_it -> first + 1, list<int>{key})); 
        } else {
            (prev(cur_lvl_it) -> second).push_front(key); 
        }
        
        
        lmap[key].second.level_it = prev(cur_lvl_it); 
        lmap[key].second.sub_level_it = (prev(cur_lvl_it) -> second).begin(); 
        // cout << lmap[key].second.level_it -> first << ' '; 
        // cout << (*lmap[key].second.sub_level_it) << ' '; 

        if ((cur_lvl_it -> second).size() == 0) {
            lfreq.erase(cur_lvl_it); 
        }
        
        // printDeck(); 
        // cout << lmap[key].first << endl; 
        return lmap[key].first; 
        
        
    }
    
    void put(int key, int value) {
        // cout <<"PUT: " << key << ' ' << value << endl; 
        if (n == 0) {
            return; 
        }
        if (lmap.find(key) == lmap.end()) {
            if (lmap.size() >= n) {
            
                int del = lfreq.back().second.back(); 
                // cout << "DELETED: " << del << endl; 
                lfreq.back().second.pop_back(); 

                if (lfreq.back().second.size() == 0) {
                    lfreq.pop_back(); 
                }

                lmap.erase(del); 
            }
            
            if (lfreq.back().first != 1) {
                lfreq.push_back(make_pair(1, list<int>())); 
            }

            lfreq.back().second.push_front(key);
            
            mapNode tmp(key); 
            tmp.level_it = prev(lfreq.end());
            tmp.sub_level_it = lfreq.back().second.begin(); 
            lmap[key] = make_pair(value, tmp); 
        } else {
            lmap[key].first = value; 
            get(key); 
        }
        
        
        // printDeck(); 
    }
private:
    int n; 
    list<pair<int, list<int>>> lfreq; 
    unordered_map<int, pair<int, mapNode>> lmap; 
};
```