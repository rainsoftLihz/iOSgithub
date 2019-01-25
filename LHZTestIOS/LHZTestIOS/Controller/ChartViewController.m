//
//  ChartViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/9.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "ChartViewController.h"
#import "LanguageTool.h"
#import "ChineseString.h"
@interface ChartViewController ()
@property (nonatomic,strong)AAChartView* aaChartView;
@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //1.创建视图AAChartView
//    CGFloat chartViewWidth  = self.view.frame.size.width-20;
//    CGFloat chartViewHeight = self.view.frame.size.height-250;
//    self.aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 60, chartViewWidth, chartViewHeight)];
//    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
//    //self.aaChartView.contentHeight = self.view.frame.size.height-250;
//    [self.view addSubview:self.aaChartView];
//
//    AAChartModel *chartModel= AAObject(AAChartModel)
//    .chartTypeSet(AAChartTypeColumn)//设置图表的类型(这里以设置的为柱状图为例)
//    .titleSet(@"编程语言热度")//设置图表标题
//    .subtitleSet(@"虚拟数据")//设置图表副标题
//    .categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++"])//设置图表横轴的内容
//    .yAxisTitleSet(@"摄氏度")//设置图表 y 轴的单位
//    .seriesSet(@[
//                 AAObject(AASeriesElement)
//                 .nameSet(@"2017")
//                 .dataSet(@[@45,@56,@34,@43,@65,@56,@47,@28,@49]),
//                 AAObject(AASeriesElement)
//                 .nameSet(@"2018")
//                 .dataSet(@[@11,@12,@13,@14,@15,@16,@17,@18,@19]),
//                 AAObject(AASeriesElement)
//                 .nameSet(@"2019")
//                 .dataSet(@[@31,@22,@33,@54,@35,@36,@27,@38,@39]),
//                 AAObject(AASeriesElement)
//                 .nameSet(@"2020")
//                 .dataSet(@[@21,@22,@53,@24,@65,@26,@37,@28,@49]),
//                 ]);
//
//    /*图表视图对象调用图表模型对象,绘制最终图形*/
//    [_aaChartView aa_drawChartWithChartModel:chartModel];
    //    [self configUI];
    
    [self ddd];
}

-(void)ddd{

    //Step1:初始化
    NSMutableArray *stringsToSort=[NSArray arrayWithObjects:
                                   @"电视",
                                   @"电脑",
                                   @"阿胶",
                                   @"ac",
                                   @"显示器",
                                   @"你好",
                                   @"推特",
                                   @"乔布斯",
                                   @"再见",
                                   @"暑假作业",
                                   @"键盘",
                                   @"鼠标",
                                   @"谷歌",
                                   @"1苹果",
                                   @"ab够",
                                   @"ab啊",
                                   nil].mutableCopy;
    //Step1输出
    NSLog(@"尚未排序的NSString数组:");
    for(int i=0;i<[stringsToSort count];i++){
        NSLog(@"%@",[stringsToSort objectAtIndex:i]);
    }
    
    
    //Step2:获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableDictionary* leterDic = [NSMutableDictionary dictionary];
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringsToSort count];i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        
        chineseString.string=[NSString stringWithString:[stringsToSort objectAtIndex:i]];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        chineseString.pinYin = [[LanguageTool chineseChangeToPinYin:chineseString.string]uppercaseString];
        
        [chineseStringsArray addObject:chineseString];
        
    }
    
    //Step2输出
    NSLog(@"\n\n\n转换为拼音首字母后的NSString数组");
    for(int i=0;i<[chineseStringsArray count];i++){
        ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
        NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);
    }
    
    
    
    //Step3:按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    

    
    // Step4:如果有需要，再把排序好的内容从ChineseString类中提取出来

    
    
    NSMutableArray *dicArr=[NSMutableArray array];
    NSArray* arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    NSMutableDictionary* dicData = [NSMutableDictionary dictionary];
    
    for(int i=0;i<[arr count];i++){
        
        NSMutableArray* dataArr = [NSMutableArray array];
        for (ChineseString* cha in chineseStringsArray) {
            if ([[cha.pinYin substringToIndex:1] isEqualToString:arr[i]]) {
                //首字母相同的添加到同一个数组
                [dataArr addObject:cha];
            }
        }
        
       
        
        if (dataArr.count > 0) {
             [chineseStringsArray removeObjectsInArray:dataArr];
            
            NSDictionary* dic = @{arr[i]:dataArr};
            [dicArr addObject:dic];
            
            [dicData setObject:dataArr forKey:arr[i]];
        }
    }
    
    //首字母不是字母的
    NSMutableArray* dataArr = [NSMutableArray array];
    for (ChineseString* cha in chineseStringsArray) {
        //不是字母打头的
        if (![arr containsObject:[cha.pinYin substringToIndex:1]] ) {
            [dataArr addObject:cha];
        }
    }
    
    [dicData setObject:dataArr forKey:@"其他"];
    NSDictionary* dic = @{@"其他":dataArr};
    [dicArr addObject:dic];
    
    
    //Step4输出
    NSLog(@"\n\n\n最终结果:");
    for(int i=0;i<[chineseStringsArray count];i++){
        NSLog(@"%@",[chineseStringsArray objectAtIndex:i]);
    }
    
}

-(void)configUI{
    [self.view addSubview:self.ChartView];
    
    NSMutableArray* dataArr = [NSMutableArray array];
    NSMutableArray* bdataArr = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        JZTChartModel* momdel = [JZTChartModel new];
        momdel.value = [NSString stringWithFormat:@"%d",i+1];
        momdel.percentValue = [NSString stringWithFormat:@"%f",arc4random()%100/100.0];
        if (i%2) {
            [dataArr addObject:momdel];
            
            NSString* str = [NSString stringWithFormat:@"%d",i];
            [bdataArr addObject:str];
        }
        
    }
    self.ChartView.data1Arr = dataArr;
    self.ChartView.bottomArr = bdataArr;
    
    [self.ChartView configMax:10.0 andMin:1.0];
}

-(JZTChartView *)ChartView
{
    if (!_ChartView) {
        _ChartView = [[JZTChartView alloc] initWithFrame:CGRectMake(0, 100, Screen_Width, [JZTChartView chartHeight])];
        _ChartView.backgroundColor = UIColorFromRGB(0xffffff);
    }
    return _ChartView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
