//
//  ContactTableViewController.m
//  WeChat-ZK
//
//  Created by DrogoKhal on 2019/5/18.
//  Copyright © 2019 DrogoKhal. All rights reserved.
//

#import "ContactTableViewController.h"
#import "NSArray+SortContact.h"
#import "contactList/ContactListCellTableViewCell.h"

@interface ContactTableViewController ()<UITableViewDelegate, UITableViewDataSource,
UISearchControllerDelegate, UISearchBarDelegate>
@property (nonatomic, copy) NSArray* firstSectionData;

@property (nonatomic, copy) NSArray* contacts;
@property (nonatomic, copy) NSArray* grouppedContacts;
@property (nonatomic, copy) NSArray* headers;

@property (nonatomic, strong) UISearchController* searchController;

@property (strong, nonatomic) NSMutableArray* fiteredResults;

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self buildTableView];
    
}

- (void)initializeData{
    self.firstSectionData = @[
                              @[ @"plugins_FriendNotify", @"新的朋友" ],
                              @[ @"add_friend_icon_addgroup", @"群聊" ],
                              @[ @"Contact_icon_ContactTag", @"标签" ],
                              @[ @"add_friend_icon_offical", @"公众号" ]];
    
    NSString *contactPath = [[NSBundle mainBundle]pathForResource:@"contact_list.plist" ofType:nil];
    self.contacts = [NSArray arrayWithContentsOfFile:contactPath];
    
    [self.contacts sortContactTOTitleAndSectionRow_A_EC:^(
                                                          BOOL isSuccess, NSArray* titleArray, NSArray* rowArray) {
        if (!isSuccess)
            return;
        
        self.grouppedContacts = rowArray;
        self.headers = titleArray;
        
//        NSLog(@"%@", self.grouppedContacts);
    }];
}

- (void)buildTableView
{
    self.tableView.rowHeight = 60;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [self tableFooterView];
    
    self.tableView.sectionFooterHeight = 0;
    
    self.tableView.sectionHeaderHeight = 10;
}



- (void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar //todo
{
    //修改searchBar右侧按钮的文字
    [searchBar setShowsCancelButton:YES animated:YES];
    
    UIButton* btn = [searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}

#pragma mark - footer
- (UIView*)tableFooterView
{
    UIView* view = [[UIView alloc]
                    initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    UILabel* label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = [NSString
                  stringWithFormat:@"%lu位联系人 ", (unsigned long)self.contacts.count];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
    
    return view;
}

#pragma mark - tableview datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.headers.count + 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.firstSectionData.count;
    
    return [self.grouppedContacts[section - 1] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *identifier = @"contactsCellIdentifier";
    ContactListCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ContactListCellTableViewCell alloc] init];
        [cell setRestorationIdentifier:identifier];
        
        //调整分割线长度
        cell.preservesSuperviewLayoutMargins = true;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    
    return cell;
}

- (void)tableView:(UITableView*)tableView
  willDisplayCell:(ContactListCellTableViewCell*)cell
forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        cell.imageHead.image = [UIImage imageNamed:self.firstSectionData[indexPath.row][0]];
        cell.name.text = self.firstSectionData[indexPath.row][1];
    } else {
        cell.imageHead.image = [UIImage imageNamed:self.grouppedContacts[indexPath.section-1][indexPath.row][@"icon"]];
        cell.name.text = self.grouppedContacts[indexPath.section - 1][indexPath.row][@"name"];
    }
    cell.imageHead.layer.cornerRadius = 5;
    cell.imageHead.clipsToBounds = YES;
}

// 设置section header
- (UIView*)tableView:(UITableView*)tableView
viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return nil;
    
    UIView* headerView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
    
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    headerLabel.text = self.headers[section - 1];
    headerLabel.frame = CGRectMake(15, 0, headerView.bounds.size.width,
                                   headerView.bounds.size.height);
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 20;
}

- (NSArray<NSString*>*)sectionIndexTitlesForTableView:(UITableView*)tableView
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.headers];
    [arr insertObject:@"⭐︎" atIndex:0];
    
    return arr;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0)
        return nil;

    UIView* footerView = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    footerView.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
//    NSLog(@"%f", footerView.bounds.size.height);
//    NSLog(@"%f", footerView.frame.size.height);
//    NSLog(@"%f", footerView.bounds.size.width);
//    NSLog(@"%f", footerView.frame.size.width);
    return footerView;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
