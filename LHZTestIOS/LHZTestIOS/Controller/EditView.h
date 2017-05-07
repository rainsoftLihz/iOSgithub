//
//  EditView.h
//  LHZTestIOS
//
//  Created by rainsoft on 2017/5/7.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditView : UIView

-(void)configTitleWith:(NSString*)str;

@property (nonatomic,strong)void (^editBack)(NSString*);

@end
