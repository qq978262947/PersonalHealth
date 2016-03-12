//
//  PHArticleViewController.m
//  PersonalHealth
//
//  Created by lifan on 16/3/4.
//  Copyright © 2016年 PHTeam. All rights reserved.
//

#import "PHArticleViewController.h"
#import "PHArticleCell.h"
#import "TSDbManager.h"
#import "PHMsgTableView.h"
#import "PHMsgDetailController.h"

static NSString *const cellID = @"cellID";

@interface PHArticleViewController ()<PHMsgTableViewDelegate>

@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) NSArray *articles;

@end

@implementation PHArticleViewController


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.subView];
    
    [self configSubviewConstraints];
}

//#pragma mark UITableViewDelegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.articles.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    PHArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    return cell;
//}

#pragma mark - Private Method

- (void)configSubviewConstraints {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(StatusBarH, 0, 0, 0);
    
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.equalTo(self.view).with.insets(edgeInsets);
    }];
}
-(void)downLoadRowsMsgWithModel:(PHMsgTableMod *)mod
{
    
    NSString * modID=[NSString stringWithFormat:@"0%@",mod.ID];
    NSString * currentDate=[NSDate currentDateStringWithFormat:@"yyyyMM ddHHmmss"];
    NSString * usefulDate=[currentDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * path=@"96-36";
    //这里通过model获取id,并且加入序列中
    NSString * sign=[NSString stringWithFormat:@"id%@showapi_appid%@showapi_timestamp%@%@",modID,PHID,usefulDate,PHSerect];
   // NSLog(@"%@",mod.ID);

    NSString * md5Sign=[sign md532BitLower];
    NSDictionary * param =@{
                            @"id":modID,
                            @"showapi_appid":PHID,
                            @"showapi_timestamp":usefulDate,
                            @"showapi_sign":md5Sign
                            };
    
    [PHNetHelper POSTWithExtraUrl:path andParam:param andComplete:^(BOOL success, id result) {
        
        if (success)
        {
            NSLog(@"请求成功");
            NSError * error;
            NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
            if (error)
            {
                NSLog(@"解析失败%@",error);
            }
            else
            {
                //获取名称
                NSDictionary * tempDict=dict[@"showapi_res_body"];
                PHDetailMod * detailMod= [PHDetailMod modWithDict:tempDict[@"item"]];
                PHMsgDetailController * detailCtl=[PHMsgDetailController phMsgDetailControllerWithPHDetailMod:detailMod];
                detailCtl.tableMod=mod;
                
                [self.navigationController pushViewController:detailCtl animated:YES];
            }
        }
        else
        {
            NSLog(@"%@",result);
            NSLog(@"请求失败");
        }
    }];
}

#pragma mark - setting & getting

- (UIView *)subView {
    if (!_subView) {
        //_subView
       PHMsgTableView * tableView  = [PHMsgTableView phmsgTableViewWithFrame:CGRectMake(0, 64, SCRW, SCRH - 64) andtableModArray:self.articles];
        tableView.delegate=self;
        _subView=tableView;
        
        _subView.backgroundColor=[UIColor whiteColor];
    }
    return _subView;
}

- (NSArray *)articles {
    if (!_articles) {
        _articles = [[TSDbManager sharedManager] searchAllCollect];
        NSLog(@"%ld",_articles.count);
    }
    return _articles;
}
#pragma mark PHMsgTableViewDelegate
-(void)phMsgTableViewRowsSelectedWithMode:(PHMsgTableMod *)mod
{
    //根据mod获取界面
    [self downLoadRowsMsgWithModel:mod];
}
@end
