# 多元线性回归(MLR)
多元回归模型： 
>y_real=b0+b1*x1+b2*x2+……+bp*xp+e

多元回归估计模型： 
>y_pre=b0+b1*x1+b2*x2+……+bp*xp

采用的是最小二乘估计
>e_i = y_real_i - y_pre_i
>
>op_min(sum((e_i)^2))
>
>B = (X'*X)\ *X'*Y

# 逐步回归
1. 自变量逐个加入建立MLR模型
2. F检验值判断新增变量是否提高模型效果
3. 同时逐个剔除贡献小的变量
4. 最终选定k个变量使得模型最优


# F检验、t检验
- F显著性检验模型整体的有效性

- t检验各个自变量对模型的贡献程度

