//，面试官，您好，我写了一下注释，然后又写了一个还原字符串方法，我的代码没问题，能够正确的解析与还原。
#include <iostream>
#include<unordered_map>
#include<stack>
using namespace std;
/*songenjie.jd.com
连续的K = V的字符串，每个K = V之间用”, ”分隔，V中可嵌套K = V的连续字符串结构，例如“
key1 = value1, key2 = value2, key3 = [key4 = value4, key5 = value5, key6 = [key7 = value7]], key8 = value8
请编写如下函数，给定字符串，输出嵌套结构*/
struct node {
    //unordered_map<string, string>stringMap;//存字符串
    unordered_map<string, node*>nodeMap;//存节点
};
node*fun(string s) {
    s += ',';
    int n = s.size();
    stack<string>keys;//存放key
    node* root = new node();
    stack<node*>nodes;//使用栈保存当前处理的节点
    nodes.push(root);
    string key;//放当前保存的key
    for(int i=0;i<n;++i) {
        if (s[i] == '=') {//如果是等号，把当前key进栈
            keys.push(move(key));//把当前字符串入栈，并且清空
        }
        else if (s[i] == ',') {//说明已经执行完一个表达式
            if (!key.empty()) {//判断当前key是否为空，不为空，说明当前key中保留着一个value字符串
                node* child = new node();//新建一个孩子结点
                child->nodeMap[key]= nullptr;//孩子结点的值为一对key value，key为当前字符串，value 为nullptr
                nodes.top()->nodeMap[keys.top()] = child;//把将当前叶子节点添加到结点栈头的map中，key为前面入栈的
                keys.pop();//用过了，所以出栈
                key.clear();//把当前字符串清空
            }
        }
        else if (s[i] == '[') {//每个'['对应着入栈
            node* child = new node();//孩子节点
            nodes.top()->nodeMap[keys.top()]=child;//选择keys栈顶的元素与当前孩子结点组成键值对，并加入nodes栈顶的map中
            nodes.push(child);//把孩子结点压栈
            keys.pop();//把key栈顶元素出栈
        }
        else if (s[i] == ']') {//每个']'对应着出栈
            if (!key.empty()) {//判断当前key是否为空，不为空，说明当前key中保留着一个value字符串，执行和前面逗号一样的逻辑
                node* child = new node();
                child->nodeMap[key] = nullptr;
                nodes.top()->nodeMap[keys.top()] = child;
                keys.pop();
                key.clear();
            }
            nodes.pop();//对应着栈顶元素的出栈
        }
        else if (s[i] != ' ') {//如果不是前面特殊符号也不是空格，保存在key中
            key += s[i];
        }
    }
return root;
}
string print(node* root) {
    if (root == nullptr) return "";
    if (root->nodeMap.size() == 1 && root->nodeMap.begin()->second == nullptr) {
        return root->nodeMap.begin()->first;
    }
    string s;
    for (auto temp : root->nodeMap) {
        s += temp.first;
        s += " = ";
        if (temp.second->nodeMap.size() == 1 && temp.second->nodeMap.begin()->second == nullptr) {//判断子结点是不是一个单独的string
            s+=temp.second->nodeMap.begin()->first;
        }
        else {//不是单独的string递归调用print方法
            s += '[';
            s += print(temp.second);
            s += ']';
        }
        s += ", ";
    }
    s.pop_back();
    s.pop_back();
    return s ;
}
int main()
{
    node* result = fun("key1 = value1, key2 = value2, key3 = [key4 = value4, key5 = value5, key6 = [key7 = value7]], key8 = value8");
    string s=print(result);//还原字符串
    cout << s << endl;//打印字符串
}
