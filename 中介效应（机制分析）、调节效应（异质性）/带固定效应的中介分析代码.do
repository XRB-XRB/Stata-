//参考：https://zhuanlan.zhihu.com/p/99435552
//带固定效应的中介分析
cd "/Users/xrb/Desktop/Stata学习/Stata 操作代码示范/中介效应（机制分析）、调节效应（异质性）"
use "http://www.stata-press.com/data/r15/gsem_multmed",clear

// 数据介绍：
// 这是一组有关大型百货公司销售人员的数据，我们用来讨论经理的激励与员工工作表现之间的关系，
// 基本假设是：经理的激励 (perceived support from managers) 可能通过影响员工的工作满意度 (job satisfaction) 而影响员工的工作表现 (job performance)。
// 其中所需使用的变量为：

// support：经理的激励，自变量，连续变量
// perform：员工的工作表现，因变量，连续变量
// satis：员工的工作满意度，中介变量，连续变量

//查看中介效应
reg perform support
eststo s1
reg satis support
eststo s2
reg perform support satis
eststo s3
outreg2 [s1 s2 s3] using 查看中介效应.doc

//sobel test
sgmediation perform ,mv(satis) iv(support)
// 此时我们想要控制时间固定效应，直接在参数cv()中加入i.time，sgmediation命令是无法实现的，可查看改进的sobel do文档进行相关操作

