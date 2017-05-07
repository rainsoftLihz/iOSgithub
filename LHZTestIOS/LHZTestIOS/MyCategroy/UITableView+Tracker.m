//
//  UITableView+Tracker.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/4/10.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "UITableView+Tracker.h"

@implementation UITableView (Tracker)

+(void)load{
    
    Class class = [self class];
    SEL originalSelector = @selector(tableView:didSelectRowAtIndexPath:);
    SEL replacementSelector = @selector(jztTableView:didSelectRowAtIndexPath:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method replacementMethod = class_getInstanceMethod(class, replacementSelector);
    
    method_exchangeImplementations(originalMethod, replacementMethod);
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

-(void)jztTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jztTableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSLog(@"====didSelect====");
}

@end
