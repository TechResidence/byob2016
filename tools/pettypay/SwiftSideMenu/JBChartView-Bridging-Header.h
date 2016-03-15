//
//  JBChartView-Bridging-Header.h
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/02/21.
//  Copyright © 2016年 Evgeny Nazarov. All rights reserved.
//
/*

#ifndef JBChartView_Bridging_Header_h
#define JBChartView_Bridging_Header_h


#import <UIKit/UIKit.h>
#import "JBChartView.h"
#import "JBBarChartView.h"
#import "JBLineChartView.h"

#import "CorePlot-CocoaTouch.h"

// 折れ線グラフ用のデータソース(CPTPlotDataSource)を記載。CPTScatterPlotDataSourceと間違えないように注意
@interface ScatterPlotViewController : UIViewController
<CPTPlotDataSource>
{
@private
    // グラフ表示領域（この領域に円グラフを追加する）
    CPTGraph *graph;
}

// 円グラフで表示するデータを保持する配列
@property (readwrite, nonatomic) NSMutableArray *scatterPlotData;

@endif

*/