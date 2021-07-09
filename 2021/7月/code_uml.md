https://www.ibm.com/docs/zh/rational-soft-arch/9.7.0?topic=diagrams-relationships-in-class

# 类图中的关系

在 UML 中，关系是模型元素之间的连接。UML 关系是这样一种模型元素：它通过定义模型元素的结构和模型元素之间的行为来对模型添加语义。

UML 关系分为以下类别：

| 类别     | 功能                                             |
| :------- | :----------------------------------------------- |
| 活动边   | 表示活动之间的流                                 |
| 关联     | 表示一个模型元素的实例连接至另一个模型元素的实例 |
| 依赖关系 | 表示更改一个模型元素就会影响另一个模型元素       |
| 泛化关系 | 表示一个模型元素是另一个模型元素的特例化         |
| 实现     | 表示一个模型元素提供另一个模型元素实现的规范     |
| 转换     | 表示状态发生更改                                 |

可以通过设置属性和使用关键字来创建这些关系的变化形式。

类图中的关系显示类与类元之间的交互。这些关系表示互相关联的类元、作为泛化关系和实现的类元以及依赖于其他类和类元的那些类元。

下列主题描述了可以在类图中使用的关系：

- **[抽象关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cabstract.html)**
  抽象关系就是在不同抽象级别或者从不同视点来表示同一概念的模型元素之间的依赖关系。可以在多个图（包括用例图、类图和组件图）中对模型添加抽象关系。
- **[聚集关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/caggreg.html)**
  在 UML 模型中，聚集关系显示一个类元是另一个类元的一部分或者从属于另一个类元。
- **[关联关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cassn.html)**
  在 UML 模型中，关联是指两个类元（例如，类或用例）之间的关系，这两个类元用来描述该关系的原因及其管理规则。
- **[关联类](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cassnclss.html)**
  在 UML 图中，关联类是一个作为其他两个类之间的关联关系一部分的类。
- **[绑定关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cbind.html)**
  在 UML 模型中，绑定关系是一种为模板参数指定值并从模板生成新的模型元素的关系。
- **[组合关联关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/ccompasn.html)**
  组合关联关系表示整体与部分的关系，并且是一种聚集形式。组合关联关系指定部分类元的生存期取决于完整类元的生存期。
- **[依赖关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cdepend.html)**
  在 UML 中，如果一个元素（客户）使用或者依赖于另一个元素（供应者），那么这两个元素之间就存在依赖关系。在类图、组件图、部署图和用例图中，可以使用依赖关系来指示更改供应者就可能需要更改客户。
- **[有向关联关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cdirasn.html)**
  在 UML 模型中，有向关联关系就是只能朝一个方向导航的关联。
- **[元素导入关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/celeimport.html)**
  在 UML 图中，元素导入关系表示一个模型元素位于另一个包中，并且对于另一个包中的元素，允许使用元素的名称而不使用限定符来引用该元素。
- **[泛化关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cgeneral.html)**
  在 UML 建模中，如果一个模型元素（子代）基于另一个模型元素（父代），那么这两个元素之间就存在泛化关系。在类图、组件图、部署图和用例图中，泛化关系用来指示子代将接收父代中定义的所有属性、操作和关系。
- **[接口实现关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cimplement.html)**
  在 UML 图中，接口实现关系是类元与所提供接口之间的私有类型的实现关系。接口实现关系指定在实现类元时必须遵守提供的接口指定的合同。
- **[实例化关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cinstantiate.html)**
  在 UML 图中，实例化关系是类元之间的一种使用依赖关系，它指示一个类元中的操作将创建另一个类元的实例。
- **[包导入关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cpkgimport.html)**
  在 UML 图中，包导入关系允许其他名称空间使用非限定名称来表示包成员。
- **[实现关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/creal.html)**
  在 UML 建模中，如果一个模型元素（客户）实现另一个模型元素（供应者）指定的行为，那么这两个元素之间就存在实现关系。多个客户可以实现单个供应者的行为。可以在类图和组件图中使用实现关系。
- **[使用关系](https://www.ibm.com/docs/zh/SS8PJ7_9.7.0/com.ibm.xtools.modeler.doc/topics/cusage.html)**
  在 UML 建模中，使用关系是一种依赖关系。如果一个模型元素（客户）需要另一个模型元素（供应者）才能完全实现或操作，那么这两个模型元素之间就存在使用关系。