//
//  StepViewController.m
//  LHZTestIOS
//
//  Created by rainsoft on 2017/6/27.
//  Copyright © 2017年 dazhuanjia. All rights reserved.
//

#import "StepViewController.h"

#import "JZTHealthKit.h"

@interface StepViewController ()
{
    UILabel* _stepNumLab;
    UITextField* _textField;
}
@property (nonatomic,strong) HKHealthStore *healthStore;
@end

@implementation StepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView* contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    UIView* line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(contentView);
        make.centerY.mas_equalTo(contentView.mas_centerY);
        make.height.mas_equalTo(0.5);
    }];
    
    
    
    UILabel* nowStepNum = [self createLab];
    [contentView addSubview:nowStepNum];
    nowStepNum.text = @"当前步数:";
    [nowStepNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView);
        make.left.mas_equalTo(15.0);
        make.bottom.mas_equalTo(line);
    }];
    
    _stepNumLab = [self createLab];
    _stepNumLab.text = @"0";
    [contentView addSubview:_stepNumLab];
    [_stepNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(line);
    }];
    
    UILabel* newStepNum = [self createLab];
    newStepNum.text = @"写入步数:";
    [contentView addSubview:newStepNum];
    [newStepNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom);
        make.left.mas_equalTo(15.0);
        make.bottom.mas_equalTo(contentView.mas_bottom);
    }];
    
    _textField = [UITextField new];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [contentView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(6.0);
        make.left.mas_equalTo(newStepNum.mas_right).offset(6.0);
        make.bottom.mas_equalTo(contentView.mas_bottom).offset(-6.0);
        make.width.mas_equalTo(100);
    }];
    
    UIButton* doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [contentView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contentView.mas_right).offset(-15.0);
        make.top.mas_equalTo(_textField);
        make.centerY.mas_equalTo(_textField.mas_centerY);
    }];
    [doneBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    [self readStep];
}

-(void)action
{
    [self addstepWithStepNum:_textField.text.doubleValue];
}

#pragma mark - 设置写入权限
- (NSSet *)dataTypesToWrite {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObjects:stepType, nil];
}

#pragma mark - 设置读取权限
- (NSSet *)dataTypesToRead {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObjects:stepType, nil];
}


#pragma mark --- 读取计步器步数
-(void)readStep
{
    //查看healthKit在设备上是否可用，iPad上不支持HealthKit
    if (![HKHealthStore isHealthDataAvailable]) {
        _stepNumLab.text = @"该设备不支持HealthKit";
    }
    
    //创建healthStore对象
    self.healthStore = [[HKHealthStore alloc]init];
    //设置需要获取的权限 这里仅设置了步数
    NSSet *writeDataTypes = [self dataTypesToWrite];
    NSSet *readDataTypes = [self dataTypesToRead];
    
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            
            //获取步数后我们调用获取步数的方法
            [self getStepsFromHealthKit];
        }
        else
        {
            _stepNumLab.text = @"获取步数权限失败";
        }
    }];
}

#pragma mark - 获取步数 刷新界面
- (void)getStepsFromHealthKit{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    [self fetchSumOfSamplesTodayForType:stepType unit:[HKUnit countUnit] completion:^(double stepCount, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _stepNumLab.text = [NSString stringWithFormat:@"你的步数为：%.f",stepCount];
        });
    }];
}

#pragma mark - 读取HealthKit数据
- (void)fetchSumOfSamplesTodayForType:(HKQuantityType *)quantityType unit:(HKUnit *)unit completion:(void (^)(double, NSError *))completionHandler {
    NSPredicate *predicate = [self predicateForSamplesToday];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        HKQuantity *sum = [result sumQuantity];
        if (completionHandler) {
            double value = [sum doubleValueForUnit:unit];
            completionHandler(value, error);
        }
    }];
    [self.healthStore executeQuery:query];
}

#pragma mark - NSPredicate数据模型
- (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDate *startDate = [calendar startOfDayForDate:now];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}

#pragma mark --- 修改计步器步数
#pragma mark - 添加步数
- (void)addstepWithStepNum:(double)stepNum {
    HKQuantitySample *stepCorrelationItem = [self stepCorrelationWithStepNum:stepNum];
    
    [self.healthStore saveObject:stepCorrelationItem withCompletion:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self.view endEditing:YES];
                //刷新数据  重新获取步数
                [self getStepsFromHealthKit];
            }else {
                NSLog(@"The error was: %@.", error);
                return ;
            }
        });
    }];
}

#pragma Mark - 获取HKQuantitySample数据模型
- (HKQuantitySample *)stepCorrelationWithStepNum:(double)stepNum {
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [NSDate dateWithTimeInterval:-300 sinceDate:endDate];
    
    HKQuantity *stepQuantityConsumed = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:stepNum];
    HKQuantityType *stepConsumedType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSString *strName = [[UIDevice currentDevice] name];
    NSString *strModel = [[UIDevice currentDevice] model];
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSString *localeIdentifier = [[NSLocale currentLocale] localeIdentifier];
    
    HKDevice *device = [[HKDevice alloc] initWithName:strName manufacturer:@"Apple" model:strModel hardwareVersion:strModel firmwareVersion:strModel softwareVersion:strSysVersion localIdentifier:localeIdentifier UDIDeviceIdentifier:localeIdentifier];
    
    HKQuantitySample *stepConsumedSample = [HKQuantitySample quantitySampleWithType:stepConsumedType quantity:stepQuantityConsumed startDate:startDate endDate:endDate device:device metadata:nil];
    
    return stepConsumedSample;
}

-(UILabel*)createLab
{
    UILabel* lab = [UILabel new];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:14.0];
    return lab;
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
