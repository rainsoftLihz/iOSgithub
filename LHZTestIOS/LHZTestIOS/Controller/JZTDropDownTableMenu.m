//
//  JZTDropDownTableMenu.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/15.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTDropDownTableMenu.h"
@interface JZTDropDownTableMenu()<UITableViewDelegate,UITableViewDataSource>
//当前所选的column
@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;
//判断table是否展示
@property (nonatomic, assign) BOOL show;
//column 组数
@property (nonatomic, assign) NSInteger numOfMenu;
//初始坐标
@property (nonatomic, assign) CGPoint origin;
//背景
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UIView *bottomShadow;
//table
@property (nonatomic, strong) UITableView *tableView;


//layers array
@property (nonatomic, copy) NSArray *titlesLayers;
@property (nonatomic, copy) NSArray *indicators;
@property (nonatomic, copy) NSArray *bgLayers;
@property (nonatomic, strong) NSMutableDictionary *selectedColumnRowDic;

@end
@implementation JZTDropDownTableMenu

#pragma mark --- getter
-(JZTDropDownConfigManager *)configManager{
    if (!_configManager) {
        _configManager = [[JZTDropDownConfigManager alloc] init];
    }
    return _configManager;
}

#pragma mark --- setter
#pragma mark --- 标题
-(void)setTitleDataSource:(NSArray<NSString *> *)titleDataSource{
    
    _titleDataSource = titleDataSource;
    _numOfMenu = titleDataSource.count;
    
    CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
    CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
    CGFloat bgLayerInterval = self.frame.size.width / _numOfMenu;
    
    NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    for (int i = 0; i < _numOfMenu; i++) {
        //bgLayer
        CGPoint bgLayerPosition = CGPointMake((i+0.5)*bgLayerInterval, self.frame.size.height/2);
        CALayer *bgLayer = [self createBgLayerWithColor:self.configManager.bgNormalColor andPosition:bgLayerPosition];
        [self.layer addSublayer:bgLayer];
        [tempBgLayers addObject:bgLayer];
        //title
        CGPoint titlePosition = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
        NSString *titleString = _titleDataSource[i];
        CATextLayer *title = [self createTextLayerWithNSString:titleString withColor:self.configManager.textNormalColor andPosition:titlePosition];
        [self.layer addSublayer:title];
        [tempTitles addObject:title];
        //indicator
        CAShapeLayer *indicator = [self createIndicatorWithColor:self.configManager.indicatorNormalColor andPosition:CGPointMake(titlePosition.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2 + 1)];
        [self.layer addSublayer:indicator];
        [tempIndicators addObject:indicator];
        
        //separator
        if (i != _numOfMenu - 1) {
            CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height/2);
            CAShapeLayer *separator = [self createSeparatorLineWithColor:self.configManager.separatorColor andPosition:separatorPosition];
            [self.layer addSublayer:separator];
        }
    }
    
    _bottomShadow.backgroundColor = self.configManager.bottomLineColor;
    
    _titlesLayers = [tempTitles copy];
    _indicators = [tempIndicators copy];
    _bgLayers = [tempBgLayers copy];
    
}

#pragma mark - init method
- (instancetype)init{
    NSAssert(NO, @"请用initWithFrame初始化");
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andConfigManager:(JZTDropDownConfigManager*)manger{
    if (self = [super initWithFrame:frame]) {
         _configManager = manger;
        [self configUIWith:frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       [self configUIWith:frame];
    }
    return self;
}

-(void)configUIWith:(CGRect)frame{
    _origin = frame.origin;
    _currentSelectedMenudIndex = -1;
    _selectedColumnRowDic = [NSMutableDictionary dictionaryWithDictionary:self.configManager.defaultSelectDic];
    _show = NO;
    
    //tableView init
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, 0, 0) style:UITableViewStyleGrouped];
    _tableView.rowHeight = 38;
    _tableView.separatorColor = [UIColor colorWithRed:220.f/255.0f green:220.f/255.0f blue:220.f/255.0f alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    self.autoresizesSubviews = NO;
    _tableView.autoresizesSubviews = NO;
    
    //self tapped
    self.backgroundColor = [UIColor whiteColor];
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
    [self addGestureRecognizer:tapGesture];
    
    //background init and tapped
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(_origin.x, _origin.y, frame.size.width, [UIScreen mainScreen].bounds.size.height)];
    _backGroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [_backGroundView addGestureRecognizer:gesture];
    
    //add bottom shadow
    _bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.3, self.frame.size.width, 0.3)];
    [self addSubview:_bottomShadow];
}

#pragma mark - gesture handle
- (void)menuTapped:(UITapGestureRecognizer *)paramSender {
    CGPoint touchPoint = [paramSender locationInView:self];
    //calculate index
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titlesLayers[i] show:NO complete:^{
                    
                }];
            }];
            [self setNormalColorAtIndex:i];
        }
    }
    
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titlesLayers[_currentSelectedMenudIndex] forward:NO complecte:^{
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
        }];
        
        [self setNormalColorAtIndex:tapIndex];
    } else {
        _currentSelectedMenudIndex = tapIndex;
        
        [_tableView reloadData];
        
        if (_tableView) {
            _tableView.frame = CGRectMake(_tableView.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        }
        
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView title:_titlesLayers[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
        [self setSelectedColorAtIndex:tapIndex];
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender
{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView  title:_titlesLayers[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    
    [self setNormalColorAtIndex:_currentSelectedMenudIndex];
}

#pragma mark - init support
- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, self.frame.size.width/self.numOfMenu, self.frame.size.height-1);
    layer.backgroundColor = color.CGColor;
    
    return layer;
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)createSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, self.frame.size.height)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

- (CATextLayer *)createTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 14.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark ---  切换标题颜色
- (void)setNormalColorAtIndex:(NSInteger)index{
    [(CALayer *)self.bgLayers[index] setBackgroundColor:self.configManager.bgNormalColor.CGColor];
    [(CAShapeLayer *)self.indicators[index] setFillColor:self.configManager.indicatorNormalColor.CGColor];
    [(CATextLayer *)self.titlesLayers[index] setForegroundColor:self.configManager.textNormalColor.CGColor];
}
- (void)setSelectedColorAtIndex:(NSInteger)index{
    [(CALayer *)self.bgLayers[index] setBackgroundColor:self.configManager.bgSelectedColor.CGColor];
    [(CAShapeLayer *)self.indicators[index] setFillColor:self.configManager.indicatorSelectedColor.CGColor];
    [(CATextLayer *)self.titlesLayers[index] setForegroundColor:self.configManager.indicatorSelectedColor.CGColor];
}



#pragma mark - animation method
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    complete();
}

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        CGFloat height = 0;
        if (tableView) {
            tableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
            [self.superview addSubview:tableView];
            
            //超过7个需要下滑
            height = ([tableView numberOfRowsInSection:0] > 7) ? (7 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
            
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            if (tableView) {
                tableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, height);
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            if (tableView) {
                tableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
            }
        } completion:^(BOOL finished) {
            if (tableView) {
                [tableView removeFromSuperview];
            }
        }];
    }
    complete();
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background tableView:(UITableView *)tableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateTableView:tableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}

#pragma mark --- 默认选中情况
- (void)setupDefaultSelectedCloumRow:(NSDictionary *)dic{
    self.selectedColumnRowDic = dic.mutableCopy;
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSAssert(self.dataSource != nil, @"menu's dataSource shouldn't be nil");
    if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColumn:)]) {
        return [self.dataSource menu:self numberOfRowsInColumn:self.currentSelectedMenudIndex];
    } else {
        NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(menu:tableView:tableColumn:selectedRow:cellForRowAtIndexPath:)]) {
        UITableViewCell *cell = [self.dataSource menu:self tableView:tableView tableColumn:self.currentSelectedMenudIndex selectedRow:[self.selectedColumnRowDic[@(self.currentSelectedMenudIndex)] integerValue] cellForRowAtIndexPath:indexPath];
        return cell;
    }
    
    static NSString *identifier = @"DropDownMenuCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.textColor = self.configManager.textNormalColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.tintColor = self.configManager.indicatorSelectedColor;
    
    if ([self.dataSource respondsToSelector:@selector(menu:titleForColumn:row:)]) {
        cell.textLabel.text = [self.dataSource menu:self titleForColumn:self.currentSelectedMenudIndex row:indexPath.row];
    }
    
    if ([self.selectedColumnRowDic[@(self.currentSelectedMenudIndex)] integerValue] == indexPath.row) {
        cell.textLabel.textColor = self.configManager.indicatorSelectedColor;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.textLabel.textColor = self.configManager.textNormalColor;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedColumnRowDic[@(self.currentSelectedMenudIndex)] = @(indexPath.row);
    
    [self confiMenuWithSelectRow:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(menu:didSelectRow:column:)]) {
        [self.delegate menu:self didSelectRow:indexPath.row column:self.currentSelectedMenudIndex];
    }
}

- (void)confiMenuWithSelectRow:(NSInteger)row{
    CATextLayer *title = (CATextLayer *)_titlesLayers[_currentSelectedMenudIndex];
    title.string = [self.dataSource menu:self titleForColumn:self.currentSelectedMenudIndex row:row];
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titlesLayers[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    
    [self setNormalColorAtIndex:_currentSelectedMenudIndex];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}


@end
