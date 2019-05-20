//
//  ChatViewController.m
//  WeChat-ZK
//
//  Created by DrogoKhal on 2019/5/18.
//  Copyright © 2019 DrogoKhal. All rights reserved.
//

#import "ChatViewController.h"
#import "chatList/ChatListCell.h"
#import "personalChat/Controller/ChatroomViewController.h"
@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *chats;
@property (nonatomic, strong) NSMutableArray *chatFilterArray;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_mainframe.jpg"]];//普通图片
//    
//    [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_mainframeHL.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];//选中图片
   
    // Do any additional setup after loading the view.
    self.searchBar.showsCancelButton = false;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    self.searchBar.layer.masksToBounds = true;
//    self.searchBar.layer.cornerRadius = self.searchBar.frame.size.height / 2;
//    self.searchBar.layer.borderWidth = 1;
    
    self.tableView.rowHeight=65;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

// 隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (NSArray *)chats{
    if (_chats==nil){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"chat_list.plist" ofType:nil];
        //load
        _chats = [NSArray arrayWithContentsOfFile:path];
    }
    return _chats;
}

- (NSMutableArray*)carFilterArray{
    if (_chatFilterArray==nil){
        _chatFilterArray = [NSMutableArray array];
    }
    return _chatFilterArray;
}


//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.news.count;
//}

// 准备跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = segue.destinationViewController;
    if ([vc isKindOfClass:[ChatroomViewController class]]){
        ChatroomViewController *chatroomVc = (ChatroomViewController *)vc;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"chatroomIdentifier" sender:self];
}

#pragma mark dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chats.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"chatListCell";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    // 从缓冲池中获取单元格对象
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSDictionary *dic = self.chats[indexPath.row];
    
    
    cell.labelName.text = dic[@"name"];
    cell.labelMessage.text = dic[@"message"];
    cell.labelTime.text = [formatter stringFromDate:dic[@"lastMessageDate"]];
    cell.imageHead.image = [UIImage imageNamed:dic[@"icon"]];
    
    cell.imageHead.layer.cornerRadius = 5;
    cell.imageHead.clipsToBounds = YES;
    // 完全圆角
//    CAShapeLayer *mask = [CAShapeLayer new];
//    mask.path = [UIBezierPath bezierPathWithOvalInRect:cell.imageHead.bounds].CGPath;
//
//    cell.imageHead.layer.mask = mask;

    return cell;
    
}

// Header

//-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (self.searchbar.text.length == 0){
//        CarGroup *group = self.groups[section];
//        return group.title;
//    }else{
//        return nil;
//    }
//}

//- (NSArray<NSString *>*)sectionIndexTitlesForTableView:(UITableView *)tableView{
////    NSLog(@"%@", [self.groups valueForKey:@"title"]);
//    NSMutableArray *arr = [NSMutableArray array];
//    for (NSDictionary *dict in self.news){
//        [arr addObject:dict[@"title"]];
//    }
//    return [arr valueForKey:@"title"];
//
//}

//#pragma mark - UISearchBarDelegate
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    [self handleSearchForTerm:searchText];
//}
//
//
//- (void)handleSearchForTerm:(NSString *)searchTerm{
//    if (self.searchbar.text.length == 0){
//        [self.tableview reloadData];
//    }else{
//        [self.carFilterArray removeAllObjects];
//        for (CarGroup *group in self.groups){
//            for (Car *car in group.cars){
//                NSString *str1 = [car.name uppercaseString];
//                NSString *str2 = [searchTerm uppercaseString];
//                if ([str1 containsString:str2]){
//                    [self.carFilterArray addObject:car];
//                }
//            }
//        }
//        [self.tableview reloadData];
//    }
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    [self.searchbar resignFirstResponder];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
