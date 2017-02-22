//
//  PanView.m
//  LHZTestIOS
//
//  Created by rainsoft on 17/2/22.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "PanView.h"

@interface PanView ()

/**
 拖动手势
 */
@property (nonatomic,strong) UIPanGestureRecognizer *panGestrueRecognizer;

@end

@implementation PanView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        
        self.layer.cornerRadius = frame.size.width/2.0;
        
        self.layer.masksToBounds = YES;
        
        [self _createTapGestureRecognizer];
        
    }
    return self;
}

- (void)_createTapGestureRecognizer
{
    
    @weakify(self)
    UIPanGestureRecognizer  *pan = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(UIPanGestureRecognizer *sender) {
        @strongify(self)
        if (sender.state == UIGestureRecognizerStateChanged ||
            sender.state == UIGestureRecognizerStateEnded) {
            //注意，这里取得的参照坐标系是该对象的上层View的坐标。
            CGPoint offset = [sender translationInView:self];
            
            CGPoint center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y);
            
            //判断横坐标是否超出屏幕
            if (center.x < (CGRectGetWidth(self.bounds)/2)) {
                
                center.x = (CGRectGetWidth(self.bounds)/2);
                
            }else if (center.x > Screen_Width - (CGRectGetWidth(self.bounds)/2))
            {
                center.x = Screen_Width - (CGRectGetWidth(self.bounds)/2);
            }
            
            NSLog(@"boundsWidth==========%f",(CGRectGetWidth(self.bounds)/2));
            
            NSLog(@"centerx==========%f",center.x);
            
            //判断纵坐标是否超出屏幕
            if (center.y < (CGRectGetHeight(self.bounds)/2)) {
                
                center.y = (CGRectGetHeight(self.bounds)/2);
                
            }else if (center.y > Screen_Height - (CGRectGetHeight(self.bounds)/2) - 64 - 184*kHProportion)
            {
                center.y = Screen_Height - (CGRectGetHeight(self.bounds)/2 + 64 + 184*kHProportion);
            }
            
            
            NSLog(@"centerY==========%f",center.y);
            
            //设置偏移坐标
            [self setCenter:center ];
            //初始化sender中的坐标位置。如果不初始化，移动坐标会一直积累起来。
            [sender setTranslation:CGPointMake(0, 0) inView:self];
        }
    }];
    
    self.panGestrueRecognizer = pan;
    [self addGestureRecognizer:pan];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
