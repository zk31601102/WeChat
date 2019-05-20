//
//  MeViewController.m
//  WeChat-ZK
//
//  Created by DrogoKhal on 2019/5/19.
//  Copyright © 2019 DrogoKhal. All rights reserved.
//

#import "MeViewController.h"
@interface MeViewController ()

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *myHeadImage;
//@property (nonatomic, strong) IBOutlet MyInfoCell *myInfo;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.rowHeight = 100;
    self.myHeadImage.image = [UIImage imageNamed:@"drogozhang"];
    self.myHeadImage.layer.cornerRadius = 5;
    self.myHeadImage.clipsToBounds = YES;

}

@end
