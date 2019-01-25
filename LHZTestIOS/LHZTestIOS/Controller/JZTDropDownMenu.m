//
//  JZTDropDowmMenu.m
//  JZTDropDownMenu
//
//  Created by 梁泽 on 2017/2/8.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTDropDownMenu.h"
@interface NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        
        textSize = [self sizeWithAttributes:attributes];
    }
    else
    {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

@end

#pragma mark - menu implementation

@interface JZTDropDownMenu ()
@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger numOfMenu;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UIView *bottomShadow;
@property (nonatomic, strong) UITableView *tableView;

//data source
@property (nonatomic, copy) NSArray *dataArray;
//layers array
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *indicators;
@property (nonatomic, copy) NSArray *bgLayers;
@property (nonatomic, strong) NSMutableDictionary *selectedColumnRowDic;
@end


@implementation JZTDropDownMenu
#pragma mark - getter
- (UIColor *)bgNormalColor{
    if (!_bgNormalColor) {
        _bgNormalColor = [UIColor whiteColor];
    }
    return _bgNormalColor;
}

- (UIColor *)bgSelectedColor{
    if (!_bgSelectedColor) {
        _bgSelectedColor = [UIColor whiteColor];
    }
    return _bgSelectedColor;
}

- (UIColor *)indicatorNormalColor {
    if (!_indicatorNormalColor) {
        _indicatorNormalColor = [UIColor colorWithWhite:0.518 alpha:1.000];
    }
    return _indicatorNormalColor;
}

- (UIColor *)indicatorSelectedColor{
    if (!_indicatorSelectedColor) {
        _indicatorSelectedColor = [UIColor colorWithRed:0.157 green:0.769 blue:0.686 alpha:1.000];
    }
    return _indicatorSelectedColor;
}

- (UIColor *)textNormalColor{
    if (!_textNormalColor) {
        _textNormalColor = [UIColor colorWithWhite:0.518 alpha:1.000];
    }
    return _textNormalColor;
}

- (UIColor *)textSelectedColor{
    if (!_textSelectedColor) {
        _textSelectedColor = self.indicatorSelectedColor;
    }
    return _textSelectedColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor clearColor];
    }
    return _separatorColor;
}

- (UIColor *)bottomLineColor{
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor colorWithWhite:0.816 alpha:1.000];
    }
    return _bottomLineColor;
}

#pragma mark - setter
- (void)setDataSource:(id<JZTDropDownMenuDataSource>)dataSource {
    _dataSource = dataSource;
    
    //configure view
    _numOfMenu = [_dataSource numberOfColumnsInMenu:self];
    
    CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
    CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
    CGFloat bgLayerInterval = self.frame.size.width / _numOfMenu;
    
    NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    for (int i = 0; i < _numOfMenu; i++) {
        //bgLayer
        CGPoint bgLayerPosition = CGPointMake((i+0.5)*bgLayerInterval, self.frame.size.height/2);
        CALayer *bgLayer = [self createBgLayerWithColor:self.bgNormalColor andPosition:bgLayerPosition];
        [self.layer addSublayer:bgLayer];
        [tempBgLayers addObject:bgLayer];
        //title
        CGPoint titlePosition = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
        NSString *titleString = [_dataSource menu:self titleForColumn:i];
        CATextLayer *title = [self createTextLayerWithNSString:titleString withColor:self.textNormalColor andPosition:titlePosition];
        [self.layer addSublayer:title];
        [tempTitles addObject:title];
        //indicator
        CAShapeLayer *indicator = [self createIndicatorWithColor:self.indicatorNormalColor andPosition:CGPointMake(titlePosition.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2 + 1)];
        [self.layer addSublayer:indicator];
        [tempIndicators addObject:indicator];
        
        //separator
        if (i != _numOfMenu - 1) {
            CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height/2);
            CAShapeLayer *separator = [self createSeparatorLineWithColor:self.separatorColor andPosition:separatorPosition];
            [self.layer addSublayer:separator];
        }
    }
    
    _bottomShadow.backgroundColor = self.bottomLineColor;
    
    _titles = [tempTitles copy];
    _indicators = [tempIndicators copy];
    _bgLayers = [tempBgLayers copy];
}

#pragma mark - init method
- (instancetype)init{
    NSAssert(NO, @"请用initWithFrame初始化");
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _origin = frame.origin;
        _currentSelectedMenudIndex = -1;
        _selectedColumnRowDic = [NSMutableDictionary dictionary];
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
    return self;
}

- (void)setupDefaultSelectedCloumRow:(NSDictionary *)dic{
    self.selectedColumnRowDic = dic.mutableCopy;
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

- (void)setNormalColorAtIndex:(NSInteger)index{
    [(CALayer *)self.bgLayers[index] setBackgroundColor:self.bgNormalColor.CGColor];
    [(CAShapeLayer *)self.indicators[index] setFillColor:self.indicatorNormalColor.CGColor];
    [(CATextLayer *)self.titles[index] setForegroundColor:self.textNormalColor.CGColor];
}
- (void)setSelectedColorAtIndex:(NSInteger)index{
    [(CALayer *)self.bgLayers[index] setBackgroundColor:self.bgSelectedColor.CGColor];
    [(CAShapeLayer *)self.indicators[index] setFillColor:self.indicatorSelectedColor.CGColor];
    [(CATextLayer *)self.titles[index] setForegroundColor:self.indicatorSelectedColor.CGColor];
}
#pragma mark - gesture handle
- (void)menuTapped:(UITapGestureRecognizer *)paramSender {
    CGPoint touchPoint = [paramSender locationInView:self];
    //calculate index
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                    
                }];
            }];
            [self setNormalColorAtIndex:i];
        }
    }
    
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
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
        
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
        [self setSelectedColorAtIndex:tapIndex];
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender
{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView  title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    
    [self setNormalColorAtIndex:_currentSelectedMenudIndex];
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
    cell.textLabel.textColor = self.textNormalColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.tintColor = self.indicatorSelectedColor;
    
    if ([self.dataSource respondsToSelector:@selector(menu:titleForColumn:row:)]) {
        cell.textLabel.text = [self.dataSource menu:self titleForColumn:self.currentSelectedMenudIndex row:indexPath.row];
    }
    
    if ([self.selectedColumnRowDic[@(self.currentSelectedMenudIndex)] integerValue] == indexPath.row) {
        cell.textLabel.textColor = self.indicatorSelectedColor;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.textLabel.textColor = self.textNormalColor;
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
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
    title.string = [self.dataSource menu:self titleForColumn:self.currentSelectedMenudIndex row:row];
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    
    [self setNormalColorAtIndex:_currentSelectedMenudIndex];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}

@end
