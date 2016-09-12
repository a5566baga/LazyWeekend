//
//  HeaderView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "HeaderView.h"
#import "LocationButton.h"
#import <UIImageView+WebCache.h>

@interface HeaderView ()<UIScrollViewDelegate>

//轮播图
@property(nonatomic, strong)UIScrollView * scrollView;
@property(nonatomic, strong)NSMutableArray * imagesArray;
//title的label
@property(nonatomic, strong)UILabel * titleLabel;
//价格区间
@property(nonatomic, strong)UIView * priceBg;
@property(nonatomic, strong)UIImageView * iconPic;
@property(nonatomic, strong)UILabel * typeNameLabel;
@property(nonatomic, strong)UILabel * priceLabel;
//大概时间和位置
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * lineLabel;
@property(nonatomic, strong)LocationButton * locationButton;
//活动详情
@property(nonatomic, strong)UILabel * detailLabel;
@property(nonatomic, strong)UIImageView * leftImg;
@property(nonatomic, strong)UIImageView * dotOneImg;
@property(nonatomic, strong)UIImageView * dotTwoImg;
@property(nonatomic, strong)UIImageView * rightImg;

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
-(void)initForView{
//    创建轮播图
    [self initScrollView];
    [self initForTitleView];
    [self initForPriceView];
    [self initForTimeView];
    [self initForDetailName];
}
#pragma mark
#pragma mark ========== 轮播图
-(void)initScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, 500)];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(self.width * _imagesArray.count, 0);
}
#pragma mark
#pragma mark ============ scrollView的代理(轮播处理)
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    //    设置轮播图
    NSInteger index = scrollView.contentOffset.x / self.width;
    if (index == 0) {
        scrollView.contentOffset = CGPointMake(self.width * (_imagesArray.count-2), 0);
    }else if (index == _imagesArray.count){
        
    }
    
}

#pragma mark
#pragma mark ============= 创建title
-(void)initForTitleView{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont fontWithName:@"Gotham-Light" size:24];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    [self addSubview:_titleLabel];
}
#pragma mark
#pragma mark ============= 价格区间
-(void)initForPriceView{
    _priceBg = [[UIView alloc] init];
    _priceBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:_priceBg];
    _iconPic = [[UIImageView alloc] init];
    _iconPic.userInteractionEnabled = YES;
    [self.priceBg addSubview:_iconPic];
    _typeNameLabel = [[UILabel alloc] init];
    _typeNameLabel.textAlignment = NSTextAlignmentLeft;
    _typeNameLabel.font = [UIFont fontWithName:@"Gotham-Light" size:20];
    _typeNameLabel.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    [self.priceBg addSubview:_typeNameLabel];
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = [UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0];
    _priceLabel.font = [UIFont systemFontOfSize:26];
    [self.priceBg addSubview:_priceLabel];
}
#pragma mark
#pragma mark ========== 时间分布
-(void)initForTimeView{
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont fontWithName:@"Gotham-Light" size:18];
    [self addSubview:_timeLabel];
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    [self addSubview:_lineLabel];
    _locationButton = [[LocationButton alloc] init];
    [_locationButton setImage:[UIImage imageNamed:@"ic_right_arrow"] forState:UIControlStateNormal];
    _locationButton.backgroundColor = [UIColor clearColor];
    [_locationButton setTitleColor:[UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_locationButton];
    [_locationButton addTarget:self action:@selector(gotoLocation:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)gotoLocation:(UIButton *)button{
#warning 跳转地图
}
#pragma mark
#pragma mark ========== 详情页面题目
-(void)initForDetailName{
    _leftImg = [[UIImageView alloc] init];
    [_leftImg setImage:[UIImage imageNamed:@"left_line"]];
    [self addSubview:_leftImg];
    _dotOneImg = [[UIImageView alloc] init];
    _dotOneImg.image = [UIImage imageNamed:@"dot"];
    [self addSubview:_dotOneImg];
    _dotTwoImg = [[UIImageView alloc] init];
    _dotTwoImg.image = [UIImage imageNamed:@"dot"];
    [self addSubview:_dotTwoImg];
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@"right_line"];
    [self addSubview:_rightImg];
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    _detailLabel.font = [UIFont fontWithName:@"Gotham-Light" size:20];
    _detailLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    _detailLabel.adjustsFontSizeToFitWidth = YES;
    _detailLabel.text = @"活动详情";
    [self addSubview:_detailLabel];
}
#pragma mark
#pragma mark ========== 设置控件位置
-(void)layoutSubviews{
    [super layoutSubviews];
//    scrollview的图片赋值
    _scrollView.frame = CGRectMake(0, 0, self.width, self.width);
    _scrollView.contentSize = CGSizeMake(self.width * _imagesArray.count, 0);
    for (NSInteger i = 0; i < _imagesArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(self.scrollView.width*i, 0, self.scrollView.width, self.scrollView.height);
        [imageView sd_setImageWithURL:[NSURL URLWithString:_imagesArray[i]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageView.image = image;
            [self.scrollView addSubview:imageView];
        }];
    }
//    创建titlview
    float leftMargin = 10;
    float topMargin = 10;
    float height = [self rowHeightByString:_titleLabel.text font:[UIFont systemFontOfSize:24]];
    _titleLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_scrollView.frame)+topMargin, self.width-2*leftMargin, height);
// 价格区间的大小
    float priceWidth = (self.width-5*leftMargin-40);
    _priceBg.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+topMargin, self.width, 60);
    _iconPic.frame = CGRectMake(2*leftMargin, topMargin, 40, 40);
    _typeNameLabel.frame = CGRectMake(3*leftMargin+40, topMargin, priceWidth, 40);
    _priceLabel.frame = CGRectMake(self.width-leftMargin-priceWidth, topMargin, priceWidth, 40);
//    时间和位置
    _timeLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_priceBg.frame)+topMargin, self.width-2*leftMargin, 40);
    _lineLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_timeLabel.frame), self.width-2*leftMargin, 1);
    _locationButton.frame = CGRectMake(leftMargin, CGRectGetMaxY(_timeLabel.frame)+topMargin, self.width-2*leftMargin, 40);
//    活动详情
    float width = (self.width-2*leftMargin)/5;
    _leftImg.frame = CGRectMake(width, CGRectGetMaxY(_locationButton.frame)+3*topMargin, width, 2);
    _dotOneImg.frame = CGRectMake(2*width, CGRectGetMaxY(_locationButton.frame)+3*topMargin, 3, 3);
    _detailLabel.frame = CGRectMake(CGRectGetMaxX(_dotOneImg.frame), CGRectGetMaxY(_locationButton.frame)+2*topMargin, width+2*leftMargin, 30);
    _dotTwoImg.frame = CGRectMake(CGRectGetMaxX(_detailLabel.frame), CGRectGetMaxY(_locationButton.frame)+3*topMargin, 3, 3);
    _rightImg.frame = CGRectMake(CGRectGetMaxX(_dotTwoImg.frame), CGRectGetMaxY(_locationButton.frame)+3*topMargin, width, 2);
    
}
#pragma mark
#pragma mark =========== 赋值
-(void)setHeaderStyle:(NSArray *)imageArray title:(NSString *)title price_info:(NSString *)price_info type:(NSString *)type iconStr:(NSString *)iconStr timeStr:(NSString *)timeStr locationStr:(NSString *)locationStr{
    _imagesArray = [NSMutableArray arrayWithArray:imageArray];
    [_imagesArray insertObject:imageArray.firstObject atIndex:imageArray.count-1];
    [_imagesArray insertObject:imageArray.lastObject atIndex:0];
//        创建视图
    [self initForView];
//    赋值
    _titleLabel.text = title;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", price_info];
    [_iconPic sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:[UIImage imageNamed:@"ic_bag_small_small"]];
    _typeNameLabel.text = type;
    _timeLabel.text = timeStr;
    [_locationButton setTitle:locationStr forState:UIControlStateNormal];
}

#pragma mark
#pragma mark ========== 工具类
-(float)rowHeightByString:(NSString *)content font:(UIFont *)font{
    CGSize mySize = CGSizeMake(self.width-20, CGFLOAT_MAX);
    CGSize size = [content boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

@end
