//
//  TalkTableView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TalkTableView.h"
#import "TalkMessageModel.h"
#import "TalkTableViewCell.h"
#import "TalkHeaderView.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@interface TalkTableView ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)UIView * textBgView;
@property(nonatomic, strong)UITextField * textField;
@property(nonatomic, strong)UITapGestureRecognizer * tap;

@property(nonatomic, strong)AFHTTPSessionManager * manager;
@property(nonatomic, strong)NSArray<TalkMessageModel *> * modelArray;
@property(nonatomic, strong)NSMutableArray<TalkMessageModel *> * revModelArray;

@property(nonatomic, strong)NSMutableArray * commentStr;

@end

@implementation TalkTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initForData];
        [self noticeFicKeyBoard];
        [self initForView];
    }
    return self;
}
#pragma mark
#pragma mark ========= 初始化数据
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc] init];
        NSSet * set = [[NSSet alloc] initWithObjects:@"text/html", nil];
        [_manager.responseSerializer setAcceptableContentTypes:set];
    }
    return _manager;
}
-(void)initForData{
    _revModelArray = [[NSMutableArray alloc] init];
#warning 参数尚未决定是存到数据库还是网络请求
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@""] = @"";
    [self.manager GET:@"http://api.lanrenzhoumo.com/tailor/requirement/list?start_id=&session_id=00004061a9f934aa1954907af22163863e8d00" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = responseObject[@"result"];
        _modelArray = [TalkMessageModel mj_objectArrayWithKeyValuesArray:dic[@"result_list"]];
        for (TalkMessageModel * model in _modelArray) {
            [_revModelArray insertObject:model atIndex:0];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark
#pragma mark ========= 设置tableView
-(void)initForView{
    //    一个tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-40) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    _tableView.backgroundColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.97 alpha:1.00];
    
//    点击手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    _tap.numberOfTapsRequired = 1;
    [_tableView addGestureRecognizer:_tap];
    
//    一个文本框
    _textBgView = [[UIView alloc] init];
    _textBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_textBgView];
    
    _textField = [[UITextField alloc] init];
    NSDictionary * dic = @{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light" size:18], NSForegroundColorAttributeName:[UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0]};
    NSAttributedString * string = [[NSAttributedString alloc] initWithString:@"告诉我你的周末需求吧 · · · " attributes:dic];
    _textField.delegate = self;
    [_textField setAttributedPlaceholder:string];
    [self.textBgView addSubview:_textField];
}
-(NSMutableArray *)commentStr{
    if (_commentStr == nil) {
        _commentStr = [[NSMutableArray alloc] init];
    }
    return _commentStr;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString * str = textField.text;
    [self.commentStr addObject:str];
    [_tableView reloadData];
    _textField.text = nil;
    return YES;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _textBgView.frame = CGRectMake(0, self.height-40, self.width, 40);
    _textField.frame = self.textBgView.bounds;
    _textField.x += 30;
    
    _tableView.frame = CGRectMake(0, 0, self.width, self.height-40);
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    [_textField resignFirstResponder];
}
#pragma mark
#pragma mark =========== tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  _revModelArray.count;
    return _commentStr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TalkTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[TalkTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.97 alpha:1.00];
//    [cell setCellValue:_revModelArray[indexPath.row]];
    [cell setCellString:_commentStr[indexPath.row]];
//    自动降到底部
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [_revModelArray[indexPath.row] cellHeight];
    return [self cellHeight:indexPath.row];
}

-(float)cellHeight:(NSInteger)index{
    CGSize size = CGSizeMake(([UIScreen mainScreen].bounds.size.width-20)/2, MAXFLOAT);
    CGFloat height = [self.commentStr[index] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    return height + 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TalkHeaderView * headerView = [[TalkHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
    headerView.backgroundColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.97 alpha:1.00];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}

#pragma mark
#pragma mark =========== 对于键盘监听的修改
-(void)noticeFicKeyBoard{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillApperance:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidApperance:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHideHide:) name:UIKeyboardDidHideNotification object:nil];
}
//对于textField的移动
-(void)keyBoardWillApperance:(NSNotification *)notification{
    CGRect rect = [self getKeyBoardRect:notification];
    _textBgView.y -= rect.size.height-49;
}
-(void)keyBoardWillHide:(NSNotification *)notification{
    CGRect rect = [self getKeyBoardRect:notification];
    _textBgView.y += rect.size.height-49;
}
//对于tableView的大小调整
-(void)keyBoardDidApperance:(NSNotification *)notification{
    CGRect rect = [self getKeyBoardRect:notification];
    _tableView.y -= rect.size.height-49;
}
-(void)keyBoardHideHide:(NSNotification *)notification{
    CGRect rect = [self getKeyBoardRect:notification];
    _tableView.y += rect.size.height-49;
}
-(CGRect)getKeyBoardRect:(NSNotification *)notification{
    NSDictionary * infor = notification.userInfo;
    //取出键盘的Rect
    NSValue * nsR = [infor valueForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect rect={};
    [nsR getValue:&rect];
    return rect;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textField resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
