#!/bin/env python
# coding:utf-8

import FlowCytometryTools as fct
from FlowCytometryTools import FCMeasurement
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
from statistics import stdev, variance, median
# import japanize_matplotlib

#FCSファイルを定義
#コントロールのデータのパスを入力
file_path1 = "data/facs/Open-033.FCS"
sample1 = FCMeasurement(ID='33', datafile=file_path1)

# テスト群のデータのパスを入力
file_path2 = "data/facs/Open-032.FCS"
sample2 = FCMeasurement(ID='32', datafile=file_path2)
out_figpath = "figure/fig_32-33.png"

# #FCSファイルを定義
# #コントロールのデータのパスを入力
# file_path1 = "data/facs/Open-046.FCS"
# sample1 = FCMeasurement(ID='46', datafile=file_path1)

# #テスト群のデータのパスを入力
# file_path2 = "data/facs/Open-045.FCS"
# sample2 = FCMeasurement(ID='45', datafile=file_path2)
# out_figpath = "figure/fig_45-46.png"

# #FCSファイルを定義
# #コントロールのデータのパスを入力
# file_path1 = "data/facs/Open-234.FCS" #@param {type:"string"}
# sample1 = FCMeasurement(ID='234',
#                        datafile=file_path1)

# # テスト群のデータのパスを入力
# file_path2 = "data/facs/Open-233.FCS" #@param {type:"string"}
# sample2 = FCMeasurement(ID='233',
#                        datafile=file_path2)
# out_figpath = "figure/fig_233-234.png"

# RawDataをDataFlameにコピー
df1 = sample1.data
df2 = sample2.data

print("パラメーターは次の通り")
print(list(df1))
print(list(df2))

# df1.head()

#グラフ描画に用いるパラメーターを定義

# 粒径のパラメーターを入力
target1 = "Diameter (nm)"

# 蛍光のパラメーターを入力
target2 = "Fluorescence 2"

# binの範囲を計算
# bin(ヒストグラムの棒)の個数を入力

def bin_calc(Cont_df , Test_df , columns):
    bin_num = "500" #@param {type:"string"}
    bin_num = int(bin_num)
    a = Cont_df[columns].min()
    b = Test_df[columns].min()
    min_num = min(a , b)
    a = Cont_df[columns].max()
    b = Test_df[columns].max()
    max_num = max(a , b)
    min_num = int(np.floor(min_num))
    max_num = int(np.floor(max_num))
    if min_num < 0:
      min_num = -2
    else:
      min_num = sum(c.isdigit() for c in str(min_num)) -1
    max_num = sum(c.isdigit() for c in str(max_num))
    c = np.logspace(min_num, max_num, bin_num)
    return c

bin_seq_D = bin_calc(df1 , df2 , target1)
bin_seq = bin_calc(df1 , df2 , target2)

# 粒径でヒストグラム描画

fig = plt.figure(facecolor = "white" ,dpi = 100,  figsize=(6, 4))

ax = fig.add_subplot(1,1,1)
ax.yaxis.set_label_coords(-0.07,1)
ax.set_xscale("log")
ax1 = plt.hist(df1[target1], bins=bin_seq_D , color="black" , alpha=0.3 , label = "Control")
ax2 = plt.hist(df2[target1], bins=bin_seq_D , color="red" , alpha=0.3 , label = "Test")
plt.legend(loc='upper left', borderaxespad=1)
ax.set_xlabel(target1)
plt.ylabel("Count", rotation=0)

plt.show()

# 粒径ヒストグラムに基づいて、切り捨てる値を入力
# この値より小さいものを切り捨てる
min_num = "4000"
min_num = int(min_num)

# この値より大きいものを切り捨てる
max_num = "30000"
max_num = int(max_num)

# 切らない場合、範囲外の適当な値を入力してスキップする
df1_a = df1[df1["Diameter (nm)"] >= min_num]
df2_a = df2[df2["Diameter (nm)"] >= min_num]

df1_a = df1_a[df1_a["Diameter (nm)"] <= max_num]
df2_a = df2_a[df2_a["Diameter (nm)"] <= max_num]

# 切り捨て後の粒径でヒストグラム描画

fig = plt.figure(facecolor = "white" ,dpi = 100,  figsize=(6, 4))

ax = fig.add_subplot(1,1,1)
ax.yaxis.set_label_coords(-0.07,1)
ax.set_xscale("log")
ax1 = plt.hist(df1_a[target1], bins=bin_seq_D , color="black" , alpha=0.3 , label = "Control")
ax2 = plt.hist(df2_a[target1], bins=bin_seq_D , color="red" , alpha=0.3 , label = "Test")
plt.legend(loc='upper left', borderaxespad=1)
ax.set_xlabel(target1)
plt.ylabel("Count", rotation=0)

plt.show()

# MFIの計算式を定義

def MFI_calc(df , columns_name):
    a = stats.gmean(df[columns_name])
    a = "{:.2f}".format(a)
    return str(a)

def MFI_calc_Ratio(Cont_df , Test_df , columns_name):
    a = stats.gmean(Test_df[columns_name])
    b = stats.gmean(Cont_df[columns_name])
    c = a / b
    c = "{:.2f}".format(c)
    return str(c)

df1_calc = df1_a[df1_a[target2] > 0]
df2_calc = df2_a[df2_a[target2] > 0]

# 蛍光強度のヒストグラム化
fig = plt.figure(facecolor = "white" ,dpi = 300,  figsize=(9, 6))

ax = fig.add_subplot(111)
ax.yaxis.set_label_coords(-0.07,1)
ax.set_xscale("log")

ax1 = plt.hist(df1_a[target2], bins=bin_seq , color="black" , alpha=0.3 , label = "Control\nMFI:" + MFI_calc(df1_calc , target2))
ax2 = plt.hist(df2_a[target2], bins=bin_seq , color="red" , alpha=0.3 , label = "Test\nMFI:" + MFI_calc(df2_calc , target2))

plt.legend(loc='upper left', borderaxespad=1 , fontsize=14, title = "MFI Ratio" + MFI_calc_Ratio(df1_calc , df2_calc , target2)).get_title().set_fontsize(fontsize=14)
plt.xlabel("Fluorescence", fontsize=16)
plt.ylabel("Count",fontsize=16, rotation=90)
plt.tick_params(labelsize=14)

plt.savefig(out_figpath, format="png", dpi=300)
plt.show()


