//
//  GenerateChatPlist.m
//  WeChat-ZK
//
//  Created by DrogoKhal on 2019/5/18.
//  Copyright © 2019 DrogoKhal. All rights reserved.
//

#import "GenerateChatPlist.h"

@implementation GenerateChatPlist

+ (void)generatePlist{
    NSMutableArray *finalArr = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSArray *dataArr = @[
                     @[ @"周玉立", @"*Github: https://github.com/zk31601102", @"0.jpg", ],
                     @[ @"沈懿忱", @"*博客地址: https://blog.csdn.net/weixin_40400177", @"1.jpg"],
                     @[ @"倪元晟", @"*集成了图灵机器人的自动聊天功能", @"2.jpg" ],
                     @[ @"张嘉诚", @"*麻麻再也不怕进来之后没有事干了...", @"3.jpg" ],
                     @[ @"赵豪杰", @"*PS: 聊天内容使用CoreData进行缓存", @"4.jpg"],
                     @[ @"陈达", @"您已添加了Hash Chen，现在可以开始聊天了。", @"5.jpg"],
                     @[ @"罗培铖", @"我是李狗蛋，你美死了(NMSL)", @"6.jpg"],
                     @[ @"季福乐", @"今天把论文赶完，现在凌晨3点，早上六点可以给我吗？", @"7.jpg"],
                     @[ @"陈相超", @"[动画表情]", @"8.jpg"],
                     @[ @"陈嘉盛", @"凯哥，比特币涨了涨了", @"8.jpg"],
                     @[ @"俞鑫", @"你现在在哪里工作？", @"9.jpg"]];
    
    int count = 0;
    for (NSArray *subArr in dataArr){
        NSString *name = [subArr objectAtIndex:0];
        NSString *message = [subArr objectAtIndex:1];
        NSString *icon = [subArr objectAtIndex:2];
        
        NSDate *lastMessageDate = [NSDate dateWithTimeIntervalSinceReferenceDate: ((dataArr.count-(int)pow(2,count))+365*18)*86400000];
        count += 1;

        NSDictionary *dict = @{@"name":name,
            @"message":message,
            @"icon":icon,
            @"lastMessageDate":lastMessageDate
        };
        
        [finalArr addObject:dict];
    }
    NSString *path = @"/Users/DrogoKhal/Downloads/chat_list.plist";
    NSLog(@"I am writing files");
    [finalArr writeToFile:path atomically:YES];
    
}
@end
