//相关性分析操作
//具体细节请自行 help 对应命令查看帮助文件
cd "/Users/xrb/Desktop/Stata学习/Stata 操作代码示范/相关性分析"
use "/Users/xrb/Desktop/数据收集/国泰安常用控制变量by拿铁/ControlVarsDetail.dta",clear

//1.pwcorr
pwcorr SIZE LEV ROA ROE TobinQ1

pwcorr SIZE LEV ROA ROE TobinQ1,sig //报告显著性水平

//2.pwcorr_a 可标出不同显著性的*号

pwcorr_a SIZE LEV ROA ROE TobinQ1

pwcorr_a SIZE LEV ROA ROE TobinQ1,sig

//3.结果导出
logout,save(相关性分析) word replace : pwcorr_a SIZE LEV ROA ROE TobinQ1
//这个导出结果第一行串行，需要手动调整一下
