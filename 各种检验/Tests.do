
cd "/Users/xrb/Desktop/Stata学习/Stata 操作代码示范/Stata 基础操作代码/各种检验"
use "/Users/xrb/Desktop/数据收集/国泰安常用控制变量by拿铁/ControlVarsDetail.dta",clear

//F检验
xtset STKID YEAR
xtreg ROA SIZE GROWTH,fe

//Hausman 默认不存在异方差
xtreg ROA SIZE GROWTH,fe
eststo fe

xtreg ROA SIZE GROWTH ,re
eststo re

hausman fe re //P值趋于0，fe优于re

//若chi方为负，可加入常数项再次检验
hausman fe re, cons sigmamore

//考虑异方差的hausman

xtoverid
