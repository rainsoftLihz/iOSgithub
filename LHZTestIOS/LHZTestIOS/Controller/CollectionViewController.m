//
//  CollectionViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/7.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "CollectionViewController.h"

#import "CollectionViewCell.h"

#import "EditView.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView* collectionView;

@property (nonatomic,strong)NSArray* titleArr;

@property (nonatomic,strong) NSArray* iconArr;

@property (nonatomic,assign) CGFloat lineSpace;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArr = @[@"网上商城",@"1小时购药",@"咨询",@"挂号",@"陪诊",@"体检"];
    self.iconArr = @[@"wd_dd_wssc",@"wd_dd_1xsgy",@"wd_dd_zx",@"wd_dd_gh",@"wd_dd_pz",@"wd_dd_tj"];
    [self.view addSubview:self.collectionView];
    
    [self configBottomView];
}


-(void)configBottomView
{
    EditView* view = [[EditView alloc] initWithFrame:CGRectMake(0, self.collectionView.bottom, Screen_Width/3.0, 100)];
    [view configTitleWith:@"行间距"];
    [self.view addSubview:view];
    
    view.editBack = ^(NSString* lineSpace){
        self.lineSpace = [lineSpace floatValue];
        [self.collectionView layoutSubviews];
        [self.collectionView reloadData];
    };
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.itemSize = CGSizeMake(Screen_Width/3.0, 450*kHProportion/2.0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-100) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:[CollectionViewCell className]];
        [_collectionView registerClass:[UICollectionReusableView
                                        class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource|UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return 4;
    }
    return self.titleArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CollectionViewCell className] forIndexPath:indexPath];
    cell.titleLab.text = self.titleArr[indexPath.item];
    cell.iconImg.image = [UIImage imageNamed:self.iconArr[indexPath.item]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -- 创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"header"
                                                                                   forIndexPath:indexPath];
    headView.backgroundColor = [UIColor redColor];
    
    
    
    return headView;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(Screen_Width, 100);
    }
    else {
        return CGSizeMake(Screen_Width, 10);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
//itemSize
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

//    if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            return CGSizeMake(Screen_Width/2.0, 100*2);
//        }
//        if (indexPath.row == 1) {
//            return CGSizeMake(Screen_Width/2.0, 100);
//        }
//        if (indexPath.row == 2) {
//            return CGSizeMake(0, 0);
//        }
//        return CGSizeMake(Screen_Width/2.0, 100);
//    }
    return CGSizeMake(Screen_Width/3.0, 450*kHProportion/2.0);
}

//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //根据indexPath获取item的attributes
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    return attributes;
//}

//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;//self.lineSpace*(section+1);
}

//UIEdgeInsets
- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(self.lineSpace*(section+1), 0, self.lineSpace*(section+1), 0);
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
