//
//  IMGCollectionViewCell.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/15.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "IMGCollectionViewCell.h"

@implementation IMGCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, frame.size.width-3, frame.size.height-3)];
        [self.contentView addSubview:self.img];
    }
    return self;
}

@end
