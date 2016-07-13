//
//  LoopBannerView.m
//  arthome
//
//  Created by 海修杰 on 16/4/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "LoopBannerView.h"
#import "LoopPageControl.h"
#define BANNERWIDTH  DEF_DEVICE_WIDTH
#define BANNERHEIGHT DEF_RESIZE_UI(200)

@interface LoopBannerView()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,weak) NSTimer * timer;

@property (nonatomic,strong) LoopPageControl * pageControl ;

@property (nonatomic,assign) NSInteger  bannerNum;

@end

@implementation LoopBannerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加mainScroll
        UIScrollView *mainScr = [[UIScrollView alloc]init];
        mainScr.scrollsToTop = NO;
        mainScr.delegate = self;
        self.mainScr = mainScr;
        mainScr.showsHorizontalScrollIndicator = NO;
        mainScr.pagingEnabled = YES;
        mainScr.frame = CGRectMake(0, 0, BANNERWIDTH, BANNERHEIGHT);
        [self addSubview:mainScr];
    }
    return self;
}

-(void)setImgViewArr:(NSArray *)imgViewArr{
    _imgViewArr = imgViewArr;
    NSInteger imgConut = imgViewArr.count;
    self.bannerNum = imgConut;
    for(UIView *view in self.mainScr.subviews)
    {
        [view removeFromSuperview];
    }
    //firstBtn
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    firstBtn.imageView.clipsToBounds = YES;
    [firstBtn sd_setImageWithURL:[NSURL URLWithString:imgViewArr[imgConut-1][@"artImgUrl"]] forState:UIControlStateNormal placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    firstBtn.frame = CGRectMake(0, 0, BANNERWIDTH, BANNERHEIGHT);
    [firstBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScr addSubview:firstBtn];
    //不固定的banner数目
    for (NSInteger index = 0; index<imgConut; index++) {
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        imgBtn.imageView.clipsToBounds = YES;
        imgBtn.tag = index;
        [imgBtn sd_setImageWithURL:imgViewArr[index][@"artImgUrl"] forState:UIControlStateNormal placeholderImage:DEF_DEFAULPLACEHOLDIMG];
        imgBtn.frame = CGRectMake(DEF_DEVICE_WIDTH*(index+1), 0, BANNERWIDTH, BANNERHEIGHT);
        [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScr addSubview:imgBtn];
    }
    //lastBtn
    UIButton *lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lastBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    lastBtn.imageView.clipsToBounds = YES;
    [lastBtn sd_setImageWithURL:[NSURL URLWithString:imgViewArr[0][@"artImgUrl"]] forState:UIControlStateNormal placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    lastBtn.frame = CGRectMake((imgConut+1)*BANNERWIDTH, 0, BANNERWIDTH, BANNERHEIGHT);
    [lastBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScr addSubview:lastBtn];
    self.mainScr.contentSize = CGSizeMake((imgConut+2)*BANNERWIDTH, 0);
    //添加pageControl
    LoopPageControl *pageControl = [[LoopPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.nolImg = DEF_IMAGENAME(@"find_oval_transparent");
    pageControl.selImg = DEF_IMAGENAME(@"find_oval_opacity");
    pageControl.size = CGSizeMake(DEF_RESIZE_UI(7), DEF_RESIZE_UI(7));
    pageControl.imgDistance = DEF_RESIZE_UI(10);
    pageControl.imgCount = imgConut;
    pageControl.frame = CGRectMake(self.width-60, self.height-10, 50, 10);
    [self addSubview:pageControl];
    self.mainScr.contentOffset = CGPointMake(BANNERWIDTH, 0);
    self.mainScr.contentSize = CGSizeMake(BANNERWIDTH*(imgConut+2), 0);
    [self stopPlay];
    [self startPlay];
}

-(void)imgBtnClick:(UIButton *)btn{
    self.blockBanner(btn.tag);
}

- (void) startPlay
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}

- (void) stopPlay{
    [self.timer invalidate];
}

-(void)nextPage{
    NSInteger page = self.mainScr.contentOffset.x/DEF_DEVICE_WIDTH;
    page++;
    if (page > self.bannerNum+1) {
        self.mainScr.contentOffset = CGPointMake(DEF_DEVICE_WIDTH*page, 0);
    }
    else{
    [UIView animateWithDuration:0.5 animations:^{
    self.mainScr.contentOffset = CGPointMake(DEF_DEVICE_WIDTH*page, 0);
    }];
    }
    if (page==0) {
        page=self.bannerNum;
    }
    if (page==self.bannerNum+1||page==self.bannerNum+2) {
        page=1;
    }
    self.pageControl.selCount = page;
}

#pragma mark - 代理方法
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = self.mainScr.contentOffset.x/DEF_DEVICE_WIDTH;
    
    if (page==0) {
        page=self.bannerNum;
    }
    if (page==self.bannerNum+1) {
        page=1;
    }
    self.pageControl.selCount = page;
    
    if (scrollView.contentOffset.x>(self.bannerNum+1)*DEF_DEVICE_WIDTH) {
        scrollView.contentOffset = CGPointMake(DEF_DEVICE_WIDTH, 0);
    }
    else if (scrollView.contentOffset.x<=0){
        scrollView.contentOffset = CGPointMake(DEF_DEVICE_WIDTH*self.bannerNum, 0);
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopPlay];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self stopPlay];
    [self startPlay];
}

@end
