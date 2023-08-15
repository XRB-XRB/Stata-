cd "/Users/xrb/Desktop/Stata学习/Dofiles of stata/描述性统计分析（批量剔除异常值、收尾处理、导出结果）"
use "/Users/xrb/Desktop/数据收集/国泰安常用控制变量by拿铁/ControlVarsDetail.dta",clear

sum LEV ROA ROE SIZE SOE CFO1 //可直接在结果窗口复制粘贴表格

//使用命令导出
logout,save(1) word replace : sum LEV ROA ROE SIZE SOE CFO1

//剔除缺失值
drop if ROA ==.

//foreach循环剔除
foreach i in LEV ROA ROE SIZE SOE CFO1{
	drop if `i' ==.
}

//对异常值缩尾处理，以ROE为标杆
winsor2 LEV ROA ROE SIZE SOE CFO1 ,cut(1,99) replace by(YEAR)

