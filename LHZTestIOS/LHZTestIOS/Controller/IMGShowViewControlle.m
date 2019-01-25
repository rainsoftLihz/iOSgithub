//
//  ViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 16/12/22.
//  Copyright © 2016年 dazhuanjia. All rights reserved.
//

#import "IMGShowViewControlle.h"
#import "SDCycleScrollView.h"
#import "MWPhotoBrowser.h"
#import "IMGCollectionViewCell.h"
#import "JZTPlayManager.h"
#import "CollectionFooterView.h"

@interface IMGShowViewControlle ()<UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate>

@property (nonatomic,strong)UICollectionView* collectionView;

@property (nonatomic,strong)SDCycleScrollView* scrollView;

@property (nonatomic,strong)NSArray* imgArr;

@property (nonatomic,strong)UIImageView* bkImageView;

/**
 图片浏览器
 */
@property (strong, nonatomic) MWPhotoBrowser *browser;

@property (nonatomic,strong)NSArray* photosArr;

@end


@implementation IMGShowViewControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [[JZTPlayManager shareManager] play];
    
    [self confgUI];
}


-(void)confgUI
{
   /*
   self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, Screen_Width, 1280 * (Screen_Width)/960) imageNamesGroup:@[@"IMG_0108.JPG",@"IMG_0110.JPG",@"IMG_0126.JPG",@"IMG_0128.JPG",@"IMG_0129.JPG",@"IMG_0130.JPG",@"IMG_0131.JPG",@"IMG_0132.JPG",@"IMG_0134.JPG",@"IMG_0135.JPG",@"IMG_0136.JPG",@"IMG_0137.JPG",@"IMG_0138.JPG",@"IMG_0139.JPG",@"IMG_0140.JPG"]];
    [self.view addSubview:self.scrollView];
    self.collectionView.center = CGPointMake(Screen_Width/2.0, Screen_Height/2.0);
    */
    
    [self.view addSubview:self.collectionView];
    
    CollectionFooterView* playView = [[CollectionFooterView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom, Screen_Width, 128/3.0+20)];
    [self.view addSubview:playView];

}

-(NSArray *)imgArr
{
    NSMutableArray* arr = [NSMutableArray array];
    for (int i = 1; i<16; i++) {
        NSString* str = [NSString stringWithFormat:@"%d.jpg",i];
        [arr addObject:str];
    }
    return [arr copy];
}

-(NSArray *)photosArr
{
    NSMutableArray* pArr = [NSMutableArray array];
    
    for (NSString* str in self.imgArr) {
        MWPhoto *photo = [MWPhoto photoWithImage:[UIImage imageNamed:str]];
        [pArr addObject:photo];
    }
    
    return pArr;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photosArr.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photosArr.count) {
        return [self.photosArr objectAtIndex:index];
    }
    return nil;
}


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.itemSize = CGSizeMake(Screen_Width/2.0, 1280 *(Screen_Width/2.0)/960);
        
        //layout.footerReferenceSize = CGSizeMake(Screen_Width, 128/3.0+20);
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-128/3.0-20) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[IMGCollectionViewCell class] forCellWithReuseIdentifier:[IMGCollectionViewCell className]];
        [_collectionView registerClass:[CollectionFooterView
                                        class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource|UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imgArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IMGCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[IMGCollectionViewCell className] forIndexPath:indexPath];

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(IMGCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.img.image = [UIImage imageNamed:self.imgArr[indexPath.item]];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_browser == nil) {
        _browser = [[MWPhotoBrowser alloc] initWithPhotos:self.imgArr];
        _browser.displayActionButton = YES;
        _browser.displayNavArrows = YES;
        _browser.displaySelectionButtons = NO;
        _browser.alwaysShowControls = NO;
        _browser.zoomPhotosToFill = YES;
        _browser.enableSwipeToDismiss = YES;
        _browser.autoPlayOnAppear = YES;
        _browser.delegate = self;
    }
    [_browser setCurrentPhotoIndex:indexPath.item];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:_browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}

// 设置headerView和footerView的
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableView = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
//        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        reusableView = header;
//    }
//    reusableView.backgroundColor = [UIColor greenColor];
//    if (kind == UICollectionElementKindSectionFooter)
//    {
//        CollectionFooterView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
//        
//        reusableView = footerview;
//    }
//    
//    reusableView.userInteractionEnabled = YES;
//    
//    return reusableView;
//}

-(void)dealloc
{
    [[JZTPlayManager shareManager] stop];
}

@end
