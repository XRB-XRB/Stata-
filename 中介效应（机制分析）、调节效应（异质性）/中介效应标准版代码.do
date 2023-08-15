cd /Users/xrb/Desktop/Stata学习/中介效应（机制分析）、调节效应（异质性）

//分析管理者支持（indvar）对员工工作表现（depvar）的影响（以工作满意度（mv）为影响机制）
use "http://www.stata-press.com/data/r15/gsem_multmed",clear

//中介效应检验：

//方法一： Sobel-Goodman mediation tests :
//    sgmediation depvar [if exp] [in range] , mv:(mediatorvar) iv(indvar) [ cv(covarlist) quietly ]

sgmediation perform ,mv(satis) iv(support)


//方法二： bootstrap test：
dis r(ind_eff) //汇报间接效应
dis r(dir_eff)

set seed 1
bootstrap r(ind_eff) r(dir_eff),reps(1000) bca:  sgmediation perform ,mv(satis) iv(support)
estat bootstrap,all //报告所有方法构造的置信区间

//方法三： resboot_mediation：残差自助法
set seed 1
resboot_mediation , dv(perform) mv(satis) iv(support)  reps(1000) 

//加入协变量的中介效应检验：
//控制branch固定效应
tab branch,gen (branch) //生成虚拟变量
//1.
sgmediation perform ,mv(satis) iv(support) cv(branch2-branch75) quietly
//2.
bootstrap r(ind_eff) r(dir_eff),reps(1000) bca:  sgmediation perform ,mv(satis) iv(support) cv(branch2-branch75)
estat bootstrap,all

************************************************************************************************************
************************************************************************************************************
//实证表格制作与输出：以本人小论文为例
//中介效应-sobel检验
global ctrls = "Fin_pro urban_rate phone indus area logGDP" //	控制变量暂元
glo opt1  = "addtext(Controls, YES, Year,YES,Province,YES,Sobel Z,-)" //表格后添加的报告内容
glo opt2  = "keep(logindex_aggregate logAgri_loan Fin_pro) sortvar(logindex_aggregate logAgri_loan Fin_pro)"  //报告主要关心的变量系数

//输出表格的框架搭建
xtreg logrural_perincome logindex_aggregate  i.year $ctrls ,fe vce(robust) //分析x对y的影响（直接效应）
est store s1
xtreg logAgri_loan logindex_aggregate i.year $ctrls ,fe vce(robust) //分析x对m的影响
est store s2
xtreg logrural_perincome logAgri_loan logindex_aggregate i.year $ctrls ,fe vce(robust)  //加入m，分析m，x对y的影响
est store s3
outreg2 [s1 s2 s3] using 中介效应检验.doc, $opt1 $opt2 

//sobel检验
tab year,gen (d_year) //生成虚拟变量,在sobel检验时对固定效应进行控制
tab code,gen (d_code)
glo cv1 = "Fin_pro urban_rate indus area phone d_year2-d_year11  d_code2-d_code31"
sgmediation logrural_perincome ,mv(logAgri_loan) iv(logindex_aggregate) cv($cv1)

//最后用检验结果吧中介效应回归一列中的z统计量的值替换掉即可
