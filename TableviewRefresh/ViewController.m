//
//  ViewController.m
//  TableviewRefresh
//
//  Created by sheldonloys on 16/8/16.
//  Copyright © 2016年 sheldonloys. All rights reserved.
//

#import "ViewController.h"
#import "UIRefreshControl+Smooth.h"

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    UIRefreshControl *refreshCtl = [[UIRefreshControl alloc] init];
    refreshCtl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [refreshCtl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.backgroundView = nil;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview insertSubview:refreshCtl atIndex:0];
    [self.view addSubview: tableview];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//下拉刷新
- (void)refreshTableView:(UIRefreshControl *)sender {
    
    if (sender.refreshing) {
        //do refreshing
        sender.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
        
        [self performSelector:@selector(endRefreshing:) withObject:sender afterDelay:3];
    }
}

- (void)endRefreshing:(UIRefreshControl *)sender {
    [sender endRefreshing];
    sender.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
}

# pragma -mark Tableview Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *simpleTableIdentifier = @"tableviewCell";
    UITableViewCell * sceneCell;
    
    sceneCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (sceneCell == nil) {
        sceneCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    sceneCell.textLabel.text = @"S";
    return sceneCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
