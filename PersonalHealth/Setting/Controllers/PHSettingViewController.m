//
//  PHSettingViewController.m
//  PersonalHealth
//
//  Created by lifan on 16/3/2.
//  Copyright © 2016年 PHTeam. All rights reserved.
//

#import "PHSettingViewController.h"
//附近医院
#import "PHHospitalViewController.h"
//今日步数
#import "PHStepViewController.h"
//精华文章
#import "PHArticleViewController.h"
//好书常阅
#import "PHBookViewController.h"


@interface PHSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
//附近医院
@property (nonatomic, strong) UIViewController *hospitalVC;
//今日步数
@property (nonatomic, strong) UIViewController *stepVC;
//精华文章
@property (nonatomic, strong) UIViewController *articleVC;
//好书常阅
@property (nonatomic, strong) UIViewController *bookVC;
//主体
@property (nonatomic, strong) UITableView *tableView;
//头部
@property (nonatomic, strong) UIView *headerView;
//头部图片
@property (nonatomic, strong) UIImageView *headerImageView;


@end

@implementation PHSettingViewController


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView.tableHeaderView addSubview:self.headerView];
    [self.headerView addSubview:self.headerImageView];
    //配置子视图布局约束
    [self configSubviewsConstraints];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:20 weight:2];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"附近医院";
            break;
        case 1:
            cell.textLabel.text = @"今日步数";
            break;
        case 2:
            cell.textLabel.text = @"精华文章";
            break;
        case 3:
            cell.textLabel.text = @"好书常阅";
            break;
        case 4:
            cell.textLabel.text = @"清除缓存";
            break;
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:self.hospitalVC animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:self.stepVC animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:self.articleVC animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:self.bookVC animated:YES];
            break;
        default:
            break;
    }
}


#pragma mark - Private Methods

- (void)configSubviewsConstraints {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(StatusBarH, 0, 0, 0);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(edgeInsets);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headerView);
    }];
}

#pragma mark - Setter & Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentMode = UIViewContentModeScaleToFill;
        _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG"]];
        _tableView.bounces = NO;
        _tableView.rowHeight = 55;
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    }
    return _headerView;
}

- (UIViewController *)hospitalVC {
    if (!_hospitalVC) {
        _hospitalVC = [[PHHospitalViewController alloc] init];
    }
    return _hospitalVC;
}

- (UIViewController *)stepVC {
    if (!_stepVC) {
        _stepVC = [[PHStepViewController alloc] init];
    }
    return _stepVC;
}

- (UIViewController *)articleVC {
    if (!_articleVC) {
        _articleVC = [[PHArticleViewController alloc] init];
    }
    return _articleVC;
}

- (UIViewController *)bookVC {
    if (!_bookVC) {
        _bookVC = [[PHBookViewController alloc] init];
    }
    return _bookVC;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = [UIImage imageNamed:@"Snip20160309_1"];
    }
    return _headerImageView;
}

@end
