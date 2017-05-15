//
//  TitleViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/15.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "TitleViewController.h"

#import "JZTScrollTitleView.h"

#import "JZTTitleCollectionCell.h"

@interface TitleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSArray* titleArr;

@property (nonatomic,strong)JZTScrollTitleView* titleView;

@property (nonatomic,strong)UIButton* arrowsBtn;

@property (nonatomic,strong)UICollectionView* collectionView;

@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic,assign)BOOL showCollection;

@property (nonatomic,strong)UILabel* titleLab;

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self.view addSubview:self.titleView];
    __weak typeof(self) weakSelf = self;
    self.titleView.clickBack = ^(NSInteger index){
        weakSelf.selectIndex = index;
        [weakSelf.collectionView reloadData];
    };
    [self.view addSubview:self.arrowsBtn];
    [self.view addSubview:self.collectionView];
    self.collectionView.alpha = 0;
    
    [self.view addSubview:self.titleLab];
    self.titleLab.alpha = 0;
    
}


-(void)initData
{
    self.showCollection = NO;
    
    NSMutableArray* arr = [NSMutableArray array];
    
    for (int i = 0; i < 18; i++) {
        NSString* titleStr = [NSString stringWithFormat:@"标题%d",i];
        [arr addObject:titleStr];
    }
    
    self.titleArr = [arr copy];
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.itemSize = CGSizeMake(Screen_Width/5.0, 44.0);
        layout.footerReferenceSize = CGSizeMake(Screen_Width, Screen_Height-64-44-(self.titleArr.count/5.0)*44);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_Height-64) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JZTTitleCollectionCell class] forCellWithReuseIdentifier:[JZTTitleCollectionCell className]];
        [_collectionView registerClass:[UICollectionReusableView
                                        class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];

    }
    return _collectionView;
}

-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width-60, 44.0)];
        _titleLab.font = [UIFont systemFontOfSize:12.0];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.text = @"全部类型";
    }
    return _titleLab;
}


#pragma mark - UICollectionViewDataSource|UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JZTTitleCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[JZTTitleCollectionCell className] forIndexPath:indexPath];
    cell.titleLab.text = self.titleArr[indexPath.item];
    if (indexPath.item == self.selectIndex) {
        cell.titleLab.textColor = [UIColor redColor];
    }
    else cell.titleLab.textColor = [UIColor blackColor];
    
    return cell;
}

// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableView = header;
    }
    reusableView.backgroundColor = [UIColor greenColor];
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        footerview.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        reusableView = footerview;
    }
    
    reusableView.userInteractionEnabled = YES;
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [reusableView addSubview:btn];
    [btn addTarget:self action:@selector(hidenColltion) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(reusableView);
    }];
    
    return reusableView;
}

-(void)hidenColltion
{
    self.collectionView.alpha = 0;
    
    self.titleLab.alpha = 0;
    
    self.titleView.alpha = 1.0;
    
    self.showCollection = NO;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self hidenColltion];
    
    [self.titleView setSelectedIndex:indexPath.item];
}




-(JZTScrollTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[JZTScrollTitleView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width-60, 44.0) andDataArr:self.titleArr andselectTextColor:[UIColor redColor] andTitleType:kScrollTitleTypeEqualToSpace];
    }
    return _titleView;
}

-(UIButton *)arrowsBtn
{
    if (!_arrowsBtn) {
        _arrowsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowsBtn.backgroundColor = [UIColor whiteColor];
        [_arrowsBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _arrowsBtn.frame = CGRectMake(Screen_Width-60, 0, 60, 44.0);
    }
    return _arrowsBtn;
}

-(void)btnClick:(UIButton*)btn
{
    if (self.showCollection == NO) {
        [UIView animateWithDuration:0.2 animations:^{
            self.collectionView.alpha = 1;
            
            self.titleView.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.titleLab.alpha = 1;
        }];
        
        self.showCollection = YES;
    }
    else {
        [UIView animateWithDuration:0.2 animations:^{
            self.collectionView.alpha = 0;
            self.titleLab.alpha = 0;
            
        } completion:^(BOOL finished) {
            self.titleView.alpha = 1.0;
        }];
        self.showCollection = NO;
    }
    
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
