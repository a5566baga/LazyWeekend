//
//  AllActivitesTableViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AllActivitesTableViewCell.h"
#import "AutoFitImageButton.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD.h>
#import <UCZProgressView.h>

@interface AllActivitesTableViewCell ()

@property(nonatomic, strong)UIImageView * picView;

@property(nonatomic, strong)UIView * bgView;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * poiLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)AutoFitImageButton * favButton;
@property(nonatomic, strong)UILabel * priceLabel;
@property(nonatomic, strong)UILabel * lineLabel;

@property(nonatomic, strong)AllActiviteModel * model;

@property(nonatomic, strong)UCZProgressView * progressView;

@end

@implementation AllActivitesTableViewCell

#pragma mark
#pragma mark ========= 赋值
-(void)setCellStyle:(AllActiviteModel *)model{
    [self initForCellView];
    _model = model;
#warning 动态加载
//    动态展示
    _progressView = [[UCZProgressView alloc] init];
    _progressView.center = CGPointMake(self.width/2, self.width/2);
    _progressView.size = CGSizeMake(60, 60);
    _progressView.indeterminate = YES;
    _progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_progressView];
//   图片下载
    [_picView sd_setImageWithURL:[NSURL URLWithString:model.front_cover_image_list.firstObject] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_progressView removeFromSuperview];
    
        _picView.image = image;
    }];
    
    _titleLabel.text = model.title;
    
    NSString * poi = model.poi;
    double distance = (double)model.distance/1000.0;
    NSString * category = model.category;
    _poiLabel.text = [NSString stringWithFormat:@"%@ · %.1lfkm · %@", poi, distance, category];
    
    _timeLabel.text = model.time_info;
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)model.price];
    
    [_favButton setTitle:[NSString stringWithFormat:@"%ld人收藏", (long)model.collected_num] forState:UIControlStateNormal];
}

#pragma mark
#pragma mark ========= 布局
-(void)initForCellView{
    _picView = [[UIImageView alloc] init];
    _picView.userInteractionEnabled = YES;
    [self addSubview:_picView];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self insertSubview:_bgView atIndex:0];
    [self addSubview:_bgView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:20];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    [self.bgView addSubview:_titleLabel];
    
    _poiLabel = [[UILabel alloc] init];
    _poiLabel.textAlignment = NSTextAlignmentLeft;
    _poiLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:16];
    _poiLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    [self.bgView addSubview:_poiLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
    _timeLabel.layer.borderWidth = 1;
    _timeLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    _timeLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:13];
    _timeLabel.layer.cornerRadius = 5;
    [self.bgView addSubview:_timeLabel];
    
    _favButton = [AutoFitImageButton buttonWithType:UIButtonTypeCustom];
    [_favButton setImage:[UIImage imageNamed:@"ic_nav_black_heart_off"] forState:UIControlStateNormal];
    [_favButton setImage:[UIImage imageNamed:@"ic_nav_black_heart_on"] forState:UIControlStateSelected];
    _favButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_favButton setImageEdgeInsets:UIEdgeInsetsMake(5, 8, 5, 0)];
    _favButton.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
    _favButton.layer.borderWidth = 1;
    _favButton.titleLabel.numberOfLines = 1;
    [_favButton setTitleColor:[UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0] forState:UIControlStateNormal];
    _favButton.layer.cornerRadius = 5;
    _favButton.titleLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:13];
    [self.bgView addSubview:_favButton];
    [_favButton addTarget:self action:@selector(favAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    _priceLabel.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
    _priceLabel.layer.borderWidth = 1;
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:13];
    _priceLabel.layer.cornerRadius = 5;
    [self.bgView addSubview:_priceLabel];
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    [self.bgView addSubview:_lineLabel];
}

-(void)favAction:(UIButton *)button{
    [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionAutoreverse animations:^{
        button.selected = !button.selected;
        button.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
#warning 收藏写入数据库
        if (button.selected) {
            _model.collected_num += 1;
        }else{
            _model.collected_num -= 1;
        }
        [button setTitle:[NSString stringWithFormat:@"%ld人收藏", (long)_model.collected_num] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        button.imageView.transform = CGAffineTransformIdentity;
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    float leftMargin  = 15;
    float topMaring = 10;
    
    _picView.frame = CGRectMake(0, -self.width/3.5, self.width, self.width/3*4);
    
    _bgView.frame = CGRectMake(0, 100, self.width, 120);
    
    float titHeight = [self rowHeightByString:_titleLabel.text font:[UIFont fontWithName:@"Gotham-Light" size:20]];
    _titleLabel.frame = CGRectMake(leftMargin, topMaring, self.width-2*leftMargin, titHeight);
    
    _poiLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_titleLabel.frame)+topMaring, self.bgView.width-2*leftMargin, 25);
    
    float timeWidth = [self rowWidthByString:_timeLabel.text font:[UIFont systemFontOfSize:14]];
    _timeLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_poiLabel.frame)+topMaring, timeWidth+leftMargin, 25);
    
    float favWidth = [self rowWidthByString:_favButton.titleLabel.text font:[UIFont systemFontOfSize:14]];
    _favButton.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame)+topMaring, CGRectGetMaxY(_poiLabel.frame)+topMaring, favWidth+topMaring+2*leftMargin, 25);
    
    float priceWidth = [self rowWidthByString:_priceLabel.text font:[UIFont systemFontOfSize:14]];
    _priceLabel.frame = CGRectMake(self.width-2*leftMargin-priceWidth, CGRectGetMaxY(_poiLabel.frame)+topMaring, priceWidth+topMaring, 25);
    
    float bgHeight = CGRectGetMaxY(_timeLabel.frame)+topMaring;
    _bgView.y = self.height - bgHeight;
    _bgView.height = bgHeight;
    
    
    _lineLabel.frame = CGRectMake(0, self.bgView.height-1, self.bgView.width+topMaring, 1);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
#pragma mark
#pragma mark ========= 自适应高度
-(float)rowHeightByString:(NSString *)content font:(UIFont *)font{
    CGSize mySize = CGSizeMake(self.width-30, CGFLOAT_MAX);
    CGSize size = [content boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
    return size.height;
}
-(float)rowWidthByString:(NSString *)content font:(UIFont *)font{
    CGSize mySize = CGSizeMake(CGFLOAT_MAX, 25);
    CGSize size = [content boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:16]} context:nil].size;
    return size.width;
}
#pragma mark
#pragma mark ========= 跳转到二级页面
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    NSLog(@"cell");
}

@end
