//
//  DetailActivtyViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/9.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "DetailActivtyViewController.h"
#import "DetailActivtyView.h"

@interface DetailActivtyViewController ()

@end

@implementation DetailActivtyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initForView];
}

-(void)initForView{
    DetailActivtyView * detailView = [[DetailActivtyView alloc] initWithFrame:self.view.bounds];
    detailView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:detailView];
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
