//
//  MyInfoCell.h
//  WeChat-ZK
//
//  Created by DrogoKhal on 2019/5/19.
//  Copyright © 2019 DrogoKhal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyInfoCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *myHeadImage;
@property (nonatomic, strong) IBOutlet UILabel *myName;
@property (nonatomic, strong) IBOutlet UILabel *myWeChatId;
@end

NS_ASSUME_NONNULL_END
