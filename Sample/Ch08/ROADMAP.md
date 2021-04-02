
# 第八章 SQL 高级处理

## 窗口函数（OLAP 函数）

### 含义： 窗口函数是为了实现 OLAP 而添加的标准 SQL 功能

### 窗口函数类型

#### 能够作为窗口函数的聚合函数(SUM,AVG,COUNT,MAX,MIN)

##### 计算累计平均值

##### 计算移动平均

* 例如最近三行，前后三行，常用于追踪趋势

#### RANK, DENSE_RANK, ROW_NUMBER 等专用窗口函数

##### 使用 RANK 函数

* 窗口函数兼具分组和排序两种功能
* 通过 PARTITION BY 分组后的记录集合称为窗口，表示范围
* 不指定 PARTITION BY 也是可以使用窗口函数的

##### DENSE_RANK 函数

* 即使有相同位次的记录，也不会跳过位数，例如 1, 2, 2, 3

##### ROW_NUMBER 函数

* 赋予唯一的连续位次

##### 由于专用窗口函数无需参数，因此通常括号中都是空的

##### 原则上窗口函数只能在 SELECT 子句中使用

##### 将聚合函数作为窗口函数使用时，会以当前记录为基准来决定汇总对象的记录

#### 窗口函数的 OVER 里面确保了按照什么顺序来计算，但是并没有对结果进行排序处理

## GROUPING 运算符

### ROLLUP 同时得出合计和小计

#### 等同于

* GROUP BY()
* GROUP BY(product_type)
* GROUP BY(product_type, regist_date)

#### 超级分组记录默认使用 NULL 来作为聚合键

#### 使用 GROUPING 函数能够简单地分辨出原始数据中的 NULL 和超级分组记录中的 NULL

### CUBE 用数据来搭积木

#### 等同于

* GROUP BY()
* GROUP BY(product_type)
* GROUP BY(regist_date)
* GROUP BY(product_type, regist_date)

#### 可以把 CUBE 理解为将使用聚合键进行切割的模块堆积成一个立方体

### GROUPING SETS 取得期望的积木

#### 这种取出一部分数据的场景比较少，因此使用 GROUPING SETS 的机会也比较少
