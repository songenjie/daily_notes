# coding规范(参照[google c++ code style](https://zh-google-styleguide.readthedocs.io/en/latest/))

1. 请注意配合IDE运用项目内的格式化文件：BE：.clang-format；FE待添加。
2. 关键逻辑注意写必要的单测。
3. 新feature开发或者已有代码逻辑的更改，适当加入开关控制，以便上线和控制影响范围。
4. 关于自定义的参数，建议整体风格与社区一致，注意大小写，定义一个新的参数时，先看看类似社区已有的参数风格。
5. 注意及时删除项目里的临时/测试/开发分支。
6. 新功能尽量以周边工具的方式提供，内核上进行开发需要谨慎。
7. 新功能如果能提供给社区，尽量提交到社区；如果基于某些原因不便提交到社区，需要做好patch工作。

# issue规范

1. 详细描述要解决的问题，线上的情况，问题如何复现，问题的原因分析，和解决问题的思路，如果是一个比较复杂的问题，请附上设计文档，并cc上相关人员。
2. 合理利用gitlab的issue关联功能，通过issue创建branch和MR，然后再写代码到branch里。
3. 问题/方案讨论等其他类型issue，有结论之后，issue发起人需要将相关内容统一整理写到wiki里，并close issue，wiki里可附上issue链接方便复盘。

# commits规范

1. commits需保持功能独立性，一个commit只设计一个功能点改动。
2. 对于已有功能的bug fix，不要新增commits，版本定下来之后，做一次rebase操作，把fix的commits合并到开发该功能的commits里，可以保持功能commits的独立性，整个flow比较清晰，日后升级也比较方便，但这样做会导致已提交的mr commits发生变化，但是pull之后重新push也用不了几分钟。
3. 关于commit标题，全部改成统一格式，且commit message内容的首字母大写：[JDOLAP][Module Name]Commit message，例如[JDOLAP][EXPR]Support string to bitmap...
4. 做cherry-pick的commit标题，使用格式：[JDOLAP][BACKPORT From Version]original commit message，例如[JDOLAP][BACKPORT From v2.4.3][JDOLAP-23333]xxxxx，只在master分支里，还没有版本的，可以用[BACKPORT From master]
5. 对于社区的半成品，pr已经提了但是没有合入master分支，建议使用格式：[JDOLAP][SEMI-BACKPORT]original commit message。需注意，对于这类pr，我们要持续跟踪社区动态。cherry-pick的时候，如果有自己的修改，提成2个commits，一个是社区本身的，另一个是自己修改的地方。
6. commits标题不要太长，力求简洁明了，细节写到commits描述里

# mr规范

```
## 这个MR解决了什么问题？为什么需要这个MR？

## 怎么解决这个问题的？
(请填写相关设计文档链接，或实现方案)

## 需要 reviewer 特别注意的事项

## 相关的 issue

## 相关的 MR

## 这个 MR 需要如何被测试？

/cc @related-reviewer
/assign @main-reviewer
```

# review规范

请关注一下代码review和回复代码review的速度。review是一项权利，也是一项业务；MR reviewer和author要及时互动起来，才能形成良好的代码review循环。我现在经常看到有的代码放在那里要求review好几天，reviewer也没有开始review回复意见；有的是reviewer给出了意见，但是author又迟迟不回答解决reviewer提出的意见。这些都是不可接受的。继续强调一项基本要求：不管是reviewer和author，在需要进行响应的时候，请在24小时之内作出响应；如果这段时间内没有办法完成review或者回复review的意见，也请在MR中作一下说明，让人知道你还是在跟进这个问题。 另外，review的基本流程要达成一致。

1. reviewer提出的每条意见，author处理完毕，不管有没有按照reviewer的意见修改，都需要回复”Done”；如果需要进一步解释的，也另一一行写上详细的解释；如果没有按照reviewer提出的意见修改，一定需要进行解释。
2. 每一轮，author在集中处理完各个reviewer的意见后，可以开始下一轮的review时，请”[@reviewer]()，PTAL”
3. reviewer在觉得MR没有问题，Good to go后，请点一下”👍🏻”的图标，并回复LGTM

# MR的一个基本过程:

1. 每个MR要做到”实现一个独立的特性”，不能把各项不同的特性揉在一起，也不能太碎（会对后续的版本升级造成影响）；要想想数据库里面的transaction的ACID原则，每个MR都像一个transaction，功能是atomic的，要能够isolated，提交之后能够保持整个代码库的consistency，也就是说不能提交一个代码，把代码库变成一个broken的状态，此外每个MR还需要随时可回滚。
2. Unittest：每个MR新加的逻辑要有充分的测试覆盖，这是一再强调的。我们现在不要求100%的测试覆盖，但是关键逻辑，可能出问题的地方，你自己写程序时候”心虚，不确定”的地方，一定要通过单元测试来确保逻辑正确；而*不是*手动测试通过就觉得可以了。
3. 创建MR时候，要按照各个项目的要求加上相应的tag，同时写好MR描述，描述中要覆盖到”what” （解决什么问题)，”why” （为什么），”how” (怎么解决)，并且对于实现中比较复杂的，拿不定的，需要reviewer特别关注的地方要清楚描述出来。
4. MR请CC相关的人，但是切忌CC所有的人（这说明你根本不清楚是怎么一回事）；同时要指定清楚一个主reviewer。
5. author与主reviewer的交互流程和时效要求如上所述
6. 主reviewer在review完毕，或者过程中不确定的时候，可以根据实际需要要求另一个reviewer（通常有相关经验）加入一起review。
7. 原则上一个MR需要在所有引入的reviewer都点赞并LGTM后才可以合并。每个MR视实际情况需要1个到3个reviewer同意，但是不超过3个。
8. Review过程中原则上每一轮由一个reviewer主导，其他人尽量避免发表不相关或不关键的意见干扰review的过程，除非觉得当前的author和reviewer进入了一个错误的方向，或者有重大bug、缺陷当前的reviewer和author都没有意识到，如果现在不提出来会拖累整个MR的进度。
9. 代码经过reviewer同意可以合并后，author的责任是安排在*合适的时间点*在相关的测试通过后*尽快*的合入代码；并跟进相关特性的测试，验证和上线。

# MR过程中的一些好的实践：

1. MR是由author提交，也是由author驱动的；author*有义务*推动reviewer完成review，使高质量代码能够被尽快合并。如果author发现reviewer没有动静，或者延时很大，author需要通过各种线上线下的方式提醒催促reviewer开展代码review。
2. 很多时候一些review的意见包含比较复杂的代码逻辑，设计思路，修改意见，相应的回复修改也比较复杂；这时候尽量通过其它更有效的方式进行沟通，比如线下面对面讨论，即时通信互动，而不是拘泥于git的文字来回的形式。author需要主动推动线下的沟通，沟通的最终结论可以更新到git的review意见的回复上。
3. 每一轮的review都会引入延时，author和reviewer应该尽可能减少review轮数，reviewer尽量一次性把问题都提出来；author每次尽量将review的问题都解决好再通过PTAL发起下一轮review。*对于一些不清楚或者不一致的地方，尽量通过更高效的互动方式进行沟通；对于不关键的点避免陷入无意义的争执*。总之，review的过程需要尽快收敛，author和reviewer要确保review过程尽快收敛；避免收敛很慢甚至发散。如果一个review经过三轮互动没法收敛，*author和reviewer都需要反思在哪里出了问题*。
4. Author有义务让每个MR都处于比较完善，*可review*的状态，也就是一个MR最基本的要求：符合编码风格，有相应的测试，符合要求的MR描述和tag，代码可编译运行，没有明显的缺陷和bug。这是一个合格程序员的基本要求。
5. Reviewer在review过程中也要站在author的角度：核心目的是帮助author尽快高效的提交高质量的代码，而不是给author设置障碍；如果一个不是必须的修改却要让author对MR进行改动比较大，那就是不合理的review。author也需要充分发挥自己的主观能动性，跟reviewer形成良好的互动，在接受reviewer评审意见的同时也要对不合理的评审意见展开进一步的讨论。
6. 创建MR request时候请选择"合并commits"和删除"source branch"，准备好MR提交时的清理工作。

最后，所有人都应该在课外认真阅读学习相关代码库相关语言的编码风格，同时相关语言的自学和不断提升也是每个人在业余需要去自我驱动的事情。