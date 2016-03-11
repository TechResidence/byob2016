//
//  GraphViewController.m
//  PettyPay
//
//  Created by AsukaKadowaki on 2016/02/22.
//  Copyright © 2016年 Evgeny Nazarov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JBChartView-Bridging-Header.h"

/*


// 折れ線グラフの識別子
NSString *const kData   = @"Data Source Plot";

@interface UIViewController ()

@end

@implementation GraphViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // グラフに表示するデータを生成
    // X軸とY軸の両方を設定する必要がある。キーを設定し、次のようなデータ構造になっている
    // [{ x = 0; y = 0; }, { x = 1; y = 1; }, { x = 2; y = 7; },
    // { x = 3; y = 4; }, { x = 4; y = 5; }, { x = 5; y = 2; },
    // { x = 6; y = 0; }, { x = 7; y = 6; }, { x = 8; y = 6; },
    // { x = 9; y = 9; }, { x = 10: y = 3 }]
    self.scatterPlotData = [NSMutableArray array];
    
    for ( NSUInteger i = 0; i < 11; i++ ) {
        NSNumber *x = [NSNumber numberWithDouble:i];
        NSNumber *y = [NSNumber numberWithDouble:(int)(rand() / (double)RAND_MAX * 10)]; // 1〜10の値のランダム値(int)
        [self.scatterPlotData addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    }
    
    // ホスティングビューを生成
    CPTGraphHostingView *hostingView =
    [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    // 画面にホスティングビューを追加
    [self.view addSubview:hostingView];
    
    // グラフを生成
    graph = [[CPTXYGraph alloc] initWithFrame:hostingView.bounds];
    hostingView.hostedGraph = graph;
    
    // グラフのボーダー設定
    graph.plotAreaFrame.borderLineStyle = nil;
    graph.plotAreaFrame.cornerRadius    = 0.0f;
    graph.plotAreaFrame.masksToBorder   = NO;
    
    // パディング
    graph.paddingLeft   = 0.0f;
    graph.paddingRight  = 0.0f;
    graph.paddingTop    = 0.0f;
    graph.paddingBottom = 0.0f;
    
    graph.plotAreaFrame.paddingLeft   = 60.0f;
    graph.plotAreaFrame.paddingTop    = 60.0f;
    graph.plotAreaFrame.paddingRight  = 20.0f;
    graph.plotAreaFrame.paddingBottom = 65.0f;
    
    //プロット間隔の設定
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    //Y軸は0〜10の値で設定
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(10)];
    //X軸は0〜10の値で設定
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromInt(0) length:CPTDecimalFromInt(10)];
    
    // テキストスタイル
    CPTMutableTextStyle *textStyle = [CPTTextStyle textStyle];
    textStyle.color                = [CPTColor colorWithComponentRed:0.447f green:0.443f blue:0.443f alpha:1.0f];
    textStyle.fontSize             = 13.0f;
    textStyle.textAlignment        = CPTTextAlignmentCenter;
    
    // ラインスタイル
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor            = [CPTColor colorWithComponentRed:0.788f green:0.792f blue:0.792f alpha:1.0f];
    lineStyle.lineWidth            = 2.0f;
    
    // X軸のメモリ・ラベルなどの設定
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.axisLineStyle               = lineStyle;      // X軸の線にラインスタイルを適用
    x.majorTickLineStyle          = lineStyle;      // X軸の大きいメモリにラインスタイルを適用
    x.minorTickLineStyle          = lineStyle;      // X軸の小さいメモリにラインスタイルを適用
    x.majorIntervalLength         = CPTDecimalFromString(@"2"); // X軸ラベルの表示間隔
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0"); // X軸のY位置
    x.title                       = @"X軸";
    x.titleTextStyle = textStyle;
    x.titleLocation               = CPTDecimalFromFloat(5.0f);
    x.titleOffset                 = 36.0f;
    //    x.minorTickLength = 5.0f;                   // X軸のメモリの長さ ラベルを設定しているため無効ぽい
    //    x.majorTickLength = 9.0f;                   // X軸のメモリの長さ ラベルを設定しているため無効ぽい
    x.labelTextStyle = textStyle;
    
    // Y軸のメモリ・ラベルなどの設定
    CPTXYAxis *y = axisSet.yAxis;
    y.axisLineStyle               = lineStyle;      // Y軸の線にラインスタイルを適用
    y.majorTickLineStyle          = lineStyle;      // Y軸の大きいメモリにラインスタイルを適用
    y.minorTickLineStyle          = lineStyle;      // Y軸の小さいメモリにラインスタイルを適用
    y.majorTickLength = 9.0f;                   // Y軸の大きいメモリの長さ
    y.minorTickLength = 5.0f;                   // Y軸の小さいメモリの長さ
    y.majorIntervalLength         = CPTDecimalFromFloat(1.0f);  // Y軸ラベルの表示間隔
    y.orthogonalCoordinateDecimal = CPTDecimalFromFloat(0.0f);  // Y軸のX位置
    y.title                       = @"Y軸";
    y.titleTextStyle = textStyle;
    y.titleRotation = M_PI*2;
    y.titleLocation               = CPTDecimalFromFloat(11.0f);
    y.titleOffset                 = 15.0f;
    lineStyle.lineWidth = 0.5f;
    y.majorGridLineStyle = lineStyle;
    y.labelTextStyle = textStyle;
    
    // 折れ線グラフのインスタンスを生成
    CPTScatterPlot *scatterPlot = [[CPTScatterPlot alloc] init];
    scatterPlot.identifier      = kData;    // 折れ線グラフを識別するために識別子を設定
    scatterPlot.dataSource      = self;     // 折れ線グラフのデータソースを設定
    
    // 折れ線グラフのスタイルを設定
    CPTMutableLineStyle *graphlineStyle = [scatterPlot.dataLineStyle mutableCopy];
    graphlineStyle.lineWidth = 3;                    // 太さ
    graphlineStyle.lineColor = [CPTColor colorWithComponentRed:0.573f green:0.82f blue:0.831f alpha:0.50f];// 色
    scatterPlot.dataLineStyle = graphlineStyle;
    
    // グラフに折れ線グラフを追加
    [graph addPlot:scatterPlot];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Plot Data Source Methods

// グラフに使用する折れ線グラフのデータ数を返す
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    NSUInteger numRecords = 0;
    NSString *identifier  = (NSString *)plot.identifier;
    
    // 折れ線グラフのidentifierにより返すデータ数を変える（複数グラフを表示する場合に必要）
    if ( [identifier isEqualToString:kData] ) {
        numRecords = self.scatterPlotData.count;
    }
    
    return numRecords;
}

// グラフに使用する折れ線グラフのX軸とY軸のデータを返す
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSNumber *num        = nil;
    NSString *identifier = (NSString *)plot.identifier;
    
    // 折れ線グラフのidentifierにより返すデータ数を変える（複数グラフを表示する場合に必要）
    if ( [identifier isEqualToString:kData] ) {
        switch (fieldEnum) {
            case CPTScatterPlotFieldX:  // X軸の場合
                num = [[self.scatterPlotData objectAtIndex:index] valueForKey:@"x"];
                break;
            case CPTScatterPlotFieldY:  // Y軸の場合
                num = [[self.scatterPlotData objectAtIndex:index] valueForKey:@"y"];
                break;
        }
    }
    
    return num;
}

@end

*/