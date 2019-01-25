//
//  JZTPickViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2018/5/14.
//  Copyright © 2018年 dazhuanjia. All rights reserved.
//

#import "JZTPickViewController.h"
//#import "JZTDropDownMenu.h"
#import "JZTDropDownConfigManager.h"
#import "JZTDropDownTableMenu.h"

@interface JZTPickViewController()<JZTDropDownTableMenuDelegate,JZTDropDownTableMenuDataSource>
@property (nonatomic,strong)JZTDropDownTableMenu* menu;

@property (nonatomic,strong)NSArray* dataLeft;
@property (nonatomic,strong)NSArray* dataRight;
@end
@implementation JZTPickViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    JZTDropDownConfigManager* manager = [[JZTDropDownConfigManager alloc] init];
    manager.indicatorNormalColor = [UIColor blackColor];
    manager.bgNormalColor = [UIColor yellowColor];
    manager.indicatorSelectedColor = [UIColor redColor];
    manager.bottomLineColor = [UIColor blueColor];
    manager.separatorColor = [UIColor greenColor];
    manager.columNums = 2;
    
    JZTDropDownTableMenu *menu = [[JZTDropDownTableMenu alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40) andConfigManager:manager];
    menu.dataSource = self;
    menu.delegate = self;
    menu.titleDataSource = @[@"区 域",@"体检品牌"];
    [self.view addSubview:_menu = menu];
    
    self.dataLeft = @[@"湖北",@"湖南",@"河北",@"河南"];
    self.dataRight = @[@"美年大健康",@"艾度",@"瑞兹",@"瑞恩",@"协和",@"同济",@"湖北",@"湖南",@"河北",@"河南"];
}

#pragma mark - JZTDropDownTableMenuDataSource
- (NSInteger)numberOfColumnsInMenu:(JZTDropDownTableMenu *)menu{
    return 3;
}
- (NSInteger)menu:(JZTDropDownTableMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    switch (column) {
        case 0:
            return self.dataLeft.count;
            break;
        case 1:
            return self.dataRight.count;
            break;
        default:
            return 0;
            break;
    }
}

//默认标题
- (NSString *)menu:(JZTDropDownTableMenu *)menu titleForColumn:(NSInteger)column{
    if (column == 2) {
        return @"距离优先";
    }
    return [@[@"区 域",@"体检品牌"] objectAtIndex:column];
}


/// 选中以后刷新标题
- (NSString *)menu:(JZTDropDownTableMenu *)menu titleForColumn:(NSInteger)column row:(NSInteger)row{
//    if (row == 0) {
//        if (column == 0) {
//            return @"区 域";
//        }else{
//            return @"体检品牌";
//        }
//    }
    if (column == 0) {
        return self.dataLeft[row];
    }
    if (column == 1) {
        return self.dataRight[row];
    }
    return nil;
}
- (UITableViewCell *)menu:(JZTDropDownTableMenu *)menu tableView:(UITableView*)tableView tableColumn:(NSInteger)column selectedRow:(NSInteger)selectedRow cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.tintColor = [UIColor redColor];
    }
    
    if (column == 0) {
        cell.textLabel.text = self.dataLeft[indexPath.row];
    }else{
        cell.textLabel.text = self.dataRight[indexPath.row];
    }

    BOOL isSelectedRow = (selectedRow == indexPath.row);
    cell.textLabel.textColor = isSelectedRow ? [UIColor redColor]:[UIColor blackColor];
    cell.accessoryType = isSelectedRow ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - JZTDropDownTableMenuDelegate
- (void)menu:(JZTDropDownTableMenu *)menu didSelectRow:(NSInteger)row column:(NSInteger)column{
    if (column == 0) {
        
    }else{
      
    }
    
}



#pragma mark -UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
//        //获取当前的图片
//        OriginalImageItem *item = [self getCurrentImageItem];
//        //标记重新上传
//        item.againUploadFlag = YES;
//        //创建UUID
//        item.uuid = [NSString stringWithUUID];
//        //改变图片的状态
//        item.status = DETAIL_STATUS_UNSTRUCT;
//        //创建locationUrl
//        //原始图片
//        UIImage *oImage = [FactoryModel getCompressImageByOrigalImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
//        //压缩图片
//        UIImage *cImage = [FactoryModel getImageCompressBy:0.1 andOrigalImage:oImage];
//        //路径
//        NSString *imagePath = [kPATH_OF_DOCUMENT stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[item.uuid lowercaseString]]];
//        //保存图片路径、刷新列表
//        item.localUrl = imagePath;
//        //记录图片信息
//        [item prepareDefaultImageInfo];
//        //记录图片的大小
//        item.imageInfo.image_height = [NSString stringWithFormat:@"%.f",oImage.size.height];
//        item.imageInfo.image_width = [NSString stringWithFormat:@"%.f",oImage.size.width];
//
//        //异步存储
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            //写入图片到沙盒
//            NSData *cImageData = UIImageJPEGRepresentation(cImage, 1);
//            [cImageData writeToFile:imagePath atomically:YES ];
//            dispatch_async_on_main_queue(^{
//
////            });
//        });
    }];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
