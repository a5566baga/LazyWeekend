//
//  UserSecondSettingCollectionViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UserSecondSettingCollectionViewCell.h"

@interface UserSecondSettingCollectionViewCell ()

//@property(nonatomic, strong)UIButton * imageView;
//@property(nonatomic , strong)UIButton * titleButton;

@property(nonatomic, strong)NSString * selectImage;
@property(nonatomic, strong)NSString * cancelImage;

@end

@implementation UserSecondSettingCollectionViewCell

//创建cell的内容
-(void)initForCell{
    _imageView = [[UIButton alloc] init];
    _imageView.userInteractionEnabled = NO;
    _imageView.selected = NO;
    [self.contentView addSubview:_imageView];
    
    _titleButton = [[UIButton alloc] init];
    _titleButton.userInteractionEnabled = NO;
    _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_titleButton setImage:[UIImage imageNamed:@"ic_check_uncheck"] forState:UIControlStateNormal];
    [_titleButton setImage:[UIImage imageNamed:@"ic_check_checked"] forState:UIControlStateSelected];
    _titleButton.selected = NO;
    [self.contentView addSubview:_titleButton];
}
//设立位置
-(void)layoutSubviews{
    [super layoutSubviews];
    float margin = 10;
    _imageView.frame = CGRectMake(3*margin, margin, self.width-6*margin, self.width-6*margin);
    _titleButton.frame = CGRectMake(2*margin, CGRectGetMaxY(_imageView.frame)+margin, self.width-margin, 25);
}

//为cell赋值
//一般状态
-(void)setCellDetail:(NSString *)imageSelStr imageCancel:(NSString *)imageCancelStr titleName:(NSString *)titleName{
    [self initForCell];
    [_imageView setBackgroundImage:[UIImage imageNamed:imageCancelStr] forState:UIControlStateNormal];
    [_imageView setBackgroundImage:[UIImage imageNamed:imageSelStr] forState:UIControlStateSelected];
    
    NSAttributedString * string = [[NSAttributedString alloc] initWithString:titleName attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light" size:18], NSForegroundColorAttributeName:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]}];
    [_titleButton setAttributedTitle:string forState:UIControlStateNormal];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    _titleButton.selected = selected;
    _imageView.selected = selected;
}

@end
