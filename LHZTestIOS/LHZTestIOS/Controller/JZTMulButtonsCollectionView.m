//
//  JZTMulButtonsCollectionView.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/4/23.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTMulButtonsCollectionView.h"
#import "JZTMulButtonsCell.h"
@interface JZTMulButtonsCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic)NSArray* titleArr;

@property (strong,nonatomic)NSArray* imgArr;

@property (strong,nonatomic)UICollectionView* colletionView;

@end

@implementation JZTMulButtonsCollectionView

-(instancetype)initWith:(CGRect)frame WithTitles:(NSArray*)titleArr andImgs:(NSArray*)imgArr
{
    if (self = [super initWithFrame:frame]) {
        self.titleArr = titleArr;
        self.imgArr = imgArr;
        [self addSubview:self.colletionView];
    }
    return self;
}

-(UICollectionView *)colletionView
{
    if (_colletionView == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //列距
        layout.minimumInteritemSpacing = 0;
        //行距
        layout.minimumLineSpacing = 0;
        //设置每个item的大小为100*100
        layout.itemSize = CGSizeMake(self.frame.size.width/self.imgArr.count, self.frame.size.height);
        //创建collectionView 通过一个布局策略layout来创建
        _colletionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        //代理设置
        _colletionView.delegate=self;
        _colletionView.dataSource=self;
        
        //不允许滑动
        _colletionView.scrollEnabled = NO;
        
        _colletionView.backgroundColor = [UIColor whiteColor];
        
        //注册item类型 这里使用系统的类型
        [_colletionView registerClass:[JZTMulButtonsCell class] forCellWithReuseIdentifier:[JZTMulButtonsCell cellId]];
    }
    return _colletionView;
}


#pragma mark --- UICollectionViewDataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    JZTMulButtonsCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:[JZTMulButtonsCell cellId] forIndexPath:indexPath];
    [cell layoutUIwihtTopSpace:8.0 andImgW:CGSizeMake(128/3.0, 128/3.0) andCenterSpeace:8.7];
    cell.titleLab.text = self.titleArr[indexPath.item];
    cell.imgView.image = [UIImage imageNamed:self.imgArr[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#pragma mark --- UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@",@"点击了---》",self.titleArr[indexPath.item]]);
    if ([self.delegate respondsToSelector:@selector(collectionView: didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:self didSelectItemAtIndexPath:indexPath];
    }
    
}


@end
