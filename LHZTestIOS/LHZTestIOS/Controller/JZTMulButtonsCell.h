//
//  JZTMulButtonsCell.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/23.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTMulButtonsCell : UICollectionViewCell

@property (strong,nonatomic)UIImageView* imgView;

@property (strong,nonatomic)UILabel* titleLab;

-(void)layoutUIwihtTopSpace:(CGFloat)topSpace andImgW:(CGSize) imgSize  andCenterSpeace:(CGFloat)centerSpace;

+(NSString*)cellId;

@end
