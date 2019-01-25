//
//  JZTMulButtonsCollectionView.h
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/23.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZTMulButtonsCollectionView;
#pragma mark - delegate
@protocol JZTMulButtonsCollectionViewDelegate <NSObject>
@optional
- (void)collectionView:(JZTMulButtonsCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface JZTMulButtonsCollectionView : UIView

@property (nonatomic, weak) id<JZTMulButtonsCollectionViewDelegate> delegate;

-(instancetype)initWith:(CGRect)frame WithTitles:(NSArray*)titleArr andImgs:(NSArray*)imgArr;

@end
