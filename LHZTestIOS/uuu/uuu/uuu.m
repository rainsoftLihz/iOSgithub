//
//  uuu.m
//  uuu
//
//  Created by rainsoft on 2018/11/7.
//  Copyright © 2018年 jzt. All rights reserved.
//

#import "uuu.h"

@implementation uuu
+(void)sayHello{
//    [ddd sayHello];
    NSLog(@"%@:sayHello",NSStringFromClass(self.class));
    
    NSString *gdPath = [[NSString stringWithFormat:@"https://restapi.amap.com/v3/weather/weatherInfo?key=b74b13cfc2842d5c5a397e752ee764e1&extensions=base&city=%@",@"武汉"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    [manger GET:gdPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
