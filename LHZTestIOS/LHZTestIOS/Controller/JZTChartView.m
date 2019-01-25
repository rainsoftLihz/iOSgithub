//
//  JZTChartView.m
//  JZTArchives
//
//  Created by rainsoft on 16/11/7.
//  Copyright © 2016年 梁泽. All rights reserved.
//

#import "JZTChartView.h"
#define LeftViewWidth_Chart 151*kProportion //左边参考值
#define RighttViewWidth 51*kProportion //右边参考值
#define BOttomTime_H  130*kProportion //下面日期的高度
#define LineSpace_H  118*kProportion  //线条间距
#define Bottom_Left_W  (IS_IPHONE5?60*kProportion:50*kProportion)  //间距

#define TopSpace 15 //上边空出来的

#define LINE_TAG 1111

#define LINE_H 0.5 //描边线高
#define LINE_COLOR  UIColorFromRGB(0xffffff) //描边颜色

#define RED_COLOR UIColorFromRGB(0xff5b40) //红色  异常色

#define GRAY_COLOR UIColorFromRGB(0x848484) //灰色 字体颜色

@interface JZTChartView()<UIScrollViewDelegate>
{
    CGFloat Xmargin;//X轴方向的偏移
    CGFloat Ymargin;//Y轴方向的偏移
}
@property (nonatomic,strong)UIView *bgView;//背景图
@property (nonatomic,strong)UIScrollView *scrollView;//可滚动数据视图

@property (nonatomic,strong)UIView *dateView;
@property (nonatomic,strong)UIScrollView *bottomScrollView;//可滚动日期视图
//坐标点
@property (nonatomic,strong) NSMutableArray *point1Arr;//左边数据1条线

@property (nonatomic,strong)NSMutableArray *btn1Arr;//左边按钮1描点


@property (nonatomic,strong)UILabel* showDataLab;//点击按钮时候，显示对应数据

/**处理点击的BTN**/
//@property (nonatomic,assign)NSInteger lastBtn;
@property (nonatomic,assign) CGFloat MAX_Value;//折线图最大值数据
@property (nonatomic,assign) CGFloat MIN_Value;//折线图最大值数据

@end

@implementation JZTChartView

+(CGFloat)chartHeight
{
    return TopSpace+LineSpace_H*(MAX_Y_NUMS-1)+BOttomTime_H;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initDataArr];
        
        [self addDetailView];
    }
    return self;
}

#pragma mark --- 初始化数组
-(void)initDataArr
{
    self.point1Arr = [NSMutableArray array];
   
    self.btn1Arr = [NSMutableArray array];
}

#pragma mark --- 添加视图
-(void)addDetailView
{
    [self addSubview:self.bgView];
    //添加方格线
    [self addLinesWith:self.bgView];
    
    //添加滚动视图
    [self.bgView addSubview:self.scrollView];
    
    //添加点击按钮显示的Lab
    [self.scrollView addSubview:self.showDataLab];
    
    [self addSubview:self.dateView];
    [self.dateView addSubview:self.bottomScrollView];
}

#pragma mark --- 滚动视图
-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, self.bgView.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

-(UIView *)dateView
{
    if (_dateView == nil) {
        _dateView = [[UIView alloc]initWithFrame:CGRectMake(LeftViewWidth_Chart-Bottom_Left_W, self.bgView.bottom, self.width-LeftViewWidth_Chart-RighttViewWidth+Bottom_Left_W, BOttomTime_H)];
    }
    return _dateView;
}

#pragma mark --- 日期滚动视图
-(UIScrollView *)bottomScrollView
{
    if (_bottomScrollView == nil) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.dateView.width, self.dateView.height)];
        _bottomScrollView.scrollEnabled = YES;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.delegate = self;
    }
    return _bottomScrollView;
}

#pragma mark --- 背景图
-(UIView*)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(LeftViewWidth_Chart, TopSpace, self.width-LeftViewWidth_Chart-RighttViewWidth, self.height-BOttomTime_H-TopSpace)];
    }
    return _bgView;
}

#pragma mark --- 点击对应圈圈显示相应数据
-(UILabel *)showDataLab{
    if (!_showDataLab) {
        _showDataLab = [[UILabel alloc]init];
        _showDataLab.textAlignment = 1;
        _showDataLab.font = [UIFont systemFontOfSize:11];
        _showDataLab.layer.cornerRadius = 2;
        _showDataLab.layer.masksToBounds = YES;
        _showDataLab.textColor = [UIColor redColor];
    }
    return _showDataLab;
}

#pragma mark --- 显示方格线
-(void)addLinesWith:(UIView *)view{
   
    CGFloat labelWith = view.width;
    /* 宽度间距 */
    Xmargin = self.bgView.width/MAX_X_NUMS;
    /* 中心高度间距 */
    Ymargin = LineSpace_H;
    //横线
    for (int i = 0;i < MAX_Y_NUMS ;i++ ) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, LineSpace_H*i, labelWith, LINE_H)];
        label.tag = LINE_TAG+i;
        label.backgroundColor = LINE_COLOR;
        [view addSubview:label];
    }
}

#pragma mark --- 左边视图(参考值)
-(void)setLeftArr:(NSArray *)leftArr{
    
    if ([leftArr[MAX_Y_NUMS/2] floatValue] < 1) {
        return;
    }
    
    for (int i = 0;i<leftArr.count;i++) {
        
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(-LeftViewWidth_Chart, TopSpace+i*LineSpace_H,LeftViewWidth_Chart, LineSpace_H)];
        leftLabel.textColor = [UIColor grayColor];
        leftLabel.font = [UIFont systemFontOfSize:12.0];
        leftLabel.text = leftArr[i];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        
        /** 与线距中 **/
        UILabel* linew = [self.bgView viewWithTag:LINE_TAG+i];
        leftLabel.centerY = linew.centerY;
        
        [self.bgView addSubview:leftLabel];
    }
    
}

-(void)setBottomArr:(NSArray *)bottomArr
{
    _bottomArr = bottomArr;
    for (NSInteger i = bottomArr.count - 1;i >= 0;i--) {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*Xmargin, 0, Xmargin, BOttomTime_H)];
        leftLabel.textColor = UIColorFromRGB(0x898989);
        leftLabel.font = [UIFont systemFontOfSize:12];
        leftLabel.text = bottomArr[i];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        /***  与点剧中 ***/
        leftLabel.centerX = i*Xmargin+Bottom_Left_W;
        [self.bottomScrollView addSubview:leftLabel];
    }
    self.bottomScrollView.contentSize = CGSizeMake(bottomArr.count*Xmargin+Bottom_Left_W, BOttomTime_H);
}

#pragma mark --- 最大值最小值
-(void)configMax:(CGFloat)maxValue andMin:(CGFloat)minValue
{
    CGFloat stepVlue = (maxValue-minValue)/MAX_Y_NUMS;
    
    for (int i = 0; i < MAX_Y_NUMS ; i++) {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(-LeftViewWidth_Chart, TopSpace+i*LineSpace_H,LeftViewWidth_Chart, LineSpace_H)];
        leftLabel.textColor = [UIColor grayColor];
        leftLabel.font = [UIFont systemFontOfSize:13];
        leftLabel.text = [NSString stringWithFormat:@"%.1f",minValue+stepVlue*i];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        
        /** 与线距中 **/
        UILabel* linew = [self.bgView viewWithTag:LINE_TAG+i];
        leftLabel.centerY = linew.centerY;
        
        [self.bgView addSubview:leftLabel];
    }
}

#pragma mark --- 赋值
-(void)setData1Arr:(NSArray *)data1Arr
{
    if (data1Arr.count == 0) {
        return;
    }
    [self checkMAXNumAndMixNum:data1Arr];
    //添加点
    [self addArrWithData:data1Arr andAddPointArr:self.point1Arr andAddBtnArr:self.btn1Arr withColor:COLOR_ZHUSE];
    //添加线
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf addBezierLineWithPointArr:weakSelf.point1Arr andBtnArr:weakSelf.btn1Arr withColor:COLOR_ZHUSE];
    });
    
}



#pragma mark --- 计算最大值最小值
-(void)checkMAXNumAndMixNum:(NSArray*)chartListArr
{
    CGFloat maxV = 0;
    CGFloat minV = MAXFLOAT;
    
    for (JZTChartModel* modle in chartListArr) {
        /*****获取最大值 最小值*****/
        if (maxV < modle.value.floatValue) {
            maxV = modle.value.floatValue;
        }
        
        if (minV > modle.value.floatValue) {
            minV = modle.value.floatValue;
        }
        
    }
    //高斯函数，向下取整
    self.MIN_Value = floorf(minV)-1 > 0 ?  floorf(minV) - 1.0:0.0;
    //ceil函数，向上取整。
    self.MAX_Value = ceilf(maxV)+1.0;
}

#pragma mark --- 描点
-(void)addArrWithData:(NSArray*)dataArr andAddPointArr:(NSMutableArray*)pointArr andAddBtnArr:(NSMutableArray*)btnArr withColor:(UIColor*)color
{
    
    //改变画布大小
    self.scrollView.contentSize = CGSizeMake(dataArr.count*Xmargin, self.scrollView.height);
    self.bottomScrollView.contentSize = CGSizeMake(dataArr.count*Xmargin+Bottom_Left_W, self.bottomScrollView.height);
    
    if (self.scrollView.contentSize.width > self.scrollView.width) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - self.scrollView.width - 5, 0)];
    }
    
    
    CGFloat height = self.bgView.height;
    
    /* 反着画线*/
    for (NSInteger i = dataArr.count-1 ; i >= 0; i--) {
        
        JZTChartModel* model = dataArr[i];
        
        //规避异常数据 >1 或 < 0
        if([model.percentValue floatValue] < 0)
        {
            model.percentValue = @"0.0";
        }
        
        if([model.percentValue floatValue] > 1)
        {
            model.percentValue = @"1.0";
        }
        
        CGFloat btnW = 9.0;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((Xmargin)*i-btnW/2, (1.0-[model.percentValue floatValue])*height-btnW/2, btnW, btnW)];
        btn.backgroundColor = [UIColor whiteColor];
        
        if (i == 0) {
            //起始坐标
            btn.left = 0.5;
            //btn.frame = CGRectMake(0.5, (1.0-[model.percentValue floatValue])*height-btnW, btnW, btnW);
        }
        
        //防止最顶部的圆圈超过界限
        if (btn.centerY < btnW/2.0) {
            btn.top = 0.1;
        }
    
        //防止最低部的圆圈超过界限
        if (btn.centerY > (height - btnW/2.0)) {
            btn.centerY = height - btnW/2.0;
        }

        if ((i == dataArr.count - 1) && dataArr.count != 1) {
            //终止坐标,如果数值为6  //防止只有一个点的时候，圆圈没有
//            btn.frame = CGRectMake((Xmargin)*i+0.5-btnW, (1.0-[model.percentValue floatValue])*height-btnW/2, btnW, btnW);
        }
        
        /************ 特殊点处理 没有值的要跨越 ***************/
        if ([model.value isEqualToString:@"-"] && i != 0) {
            //第一个点为－的话 从0开始  其余的置为透明
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.userInteractionEnabled = NO;
            /* 取上一个点的值和下一个点的值 */
        }
        else {
            btn.userInteractionEnabled = YES;
        }

        btn.layer.cornerRadius = btnW/2;
        btn.tag = i;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = [UIColor redColor].CGColor;

        [btnArr addObject:btn];
        //需要扩大点击区域
        btn.touchExtendInset = UIEdgeInsetsMake(-20, -20, -20, -20);
        @weakify(self)
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self showLabWithBtn:btn color:color andIndex:i andModel:model];
        }];

        NSValue *point = [NSValue valueWithCGPoint:btn.center];
        
        if (![model.value isEqualToString:@"-"]) {
            [pointArr addObject:point];
            if (i == dataArr.count-1) {
                [self showLabWithBtn:btn color:color andIndex:i andModel:model];
            }
        }

    }
    
}

#pragma mark --- 画线加点,有先后区别
-(void)addBezierLineWithPointArr:(NSMutableArray*)pointArr andBtnArr:(NSMutableArray*)btnArr withColor:(UIColor*)color
{
    if (pointArr.count < 1) {
        return;
    }
    
    //直线的连线
    UIBezierPath *beizer = [UIBezierPath bezierPath];
    
    //开始画线
    CGPoint first = [[pointArr firstObject] CGPointValue];
    [beizer moveToPoint:CGPointMake(first.x, self.scrollView.height)];
    
    CGPoint last = [[pointArr lastObject] CGPointValue];
    [beizer addLineToPoint:CGPointMake(last.x, self.scrollView.height)];
    
   
    for (NSInteger i = pointArr.count - 1; i >= 0 ; i-- ) {
        CGPoint point = [[pointArr objectAtIndex:i] CGPointValue];
        [beizer addLineToPoint:point];
    }
    
    beizer.lineJoinStyle = kCGLineJoinRound;
 
    [beizer stroke];
    
    [beizer closePath];//第五条线通过调用closePath方法得到的

    
    //*****************添加动画连线******************//
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = beizer.CGPath;
    shapeLayer.fillColor = UIColorFromRGB(0xffeadf).CGColor;
    shapeLayer.strokeColor = UIColorFromRGB(0xffeadf).CGColor;
    shapeLayer.lineWidth = 1;
    [self.scrollView.layer addSublayer:shapeLayer];
//
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    /* 连线时间 */
    anmi.duration = 2.5;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;

    [shapeLayer addAnimation:anmi forKey:@"stroke"];
    
    //需要加在上层视图
    for (UIButton* btn in btnArr) {
        [self.scrollView addSubview:btn];
    }
}

#pragma mark --- scroll代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint bottomp = self.bottomScrollView.contentOffset;
    CGPoint scrollp = self.scrollView.contentOffset;

    bottomp.x = scrollp.x;
    
    self.bottomScrollView.contentOffset = bottomp;
    
    self.scrollView.contentOffset = scrollp;
    
    self.showDataLab.hidden = YES;
}

#pragma mark ---  点击显示对应的值
-(void)showLabWithBtn:(UIButton*)btn color:(UIColor*)color andIndex:(int)i andModel:(JZTChartModel*)model
{
    CGFloat labH = 20.0;
    self.showDataLab.frame = CGRectMake(0, 0, 30, labH);
    
    CGFloat spaceY = 18.0;
    
    if(btn.centerY-spaceY > labH/2){
        self.showDataLab.center = CGPointMake(btn.centerX, btn.centerY-spaceY);
        if (i == 0){
            self.showDataLab.center = CGPointMake(btn.centerX+20, btn.centerY-spaceY);
        }
    }
    else {
        self.showDataLab.center = CGPointMake(btn.centerX, btn.centerY+spaceY);
        if (i == 0){
            self.showDataLab.center = CGPointMake(btn.centerX+20, btn.centerY+spaceY);
        }
    }
    self.showDataLab.textColor = [UIColor whiteColor];
    self.showDataLab.text = model.value;
    self.showDataLab.hidden = NO;
    self.showDataLab.backgroundColor = [UIColor redColor];
    [self.scrollView bringSubviewToFront:self.showDataLab];
    
}


@end
