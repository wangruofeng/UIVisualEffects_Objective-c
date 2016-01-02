//
//  ViewController.m
//  UIVisualEffects_Objective-c
//
//  Created by 王若风 on 1/2/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollerView.delegate = self;
    scrollerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrollerView];
    
    UIImage *elCapitanImage = [UIImage imageNamed:@"ElCapitan"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:elCapitanImage];
    [scrollerView addSubview:backgroundImageView];
    
    //
    scrollerView.contentSize = elCapitanImage.size;
    CGFloat minHorizScale = CGRectGetWidth(scrollerView.bounds) / elCapitanImage.size.width;
    CGFloat minVertScale = CGRectGetHeight(scrollerView.bounds) / elCapitanImage.size.height;
    scrollerView.minimumZoomScale = MIN(minHorizScale, minVertScale);
    scrollerView.maximumZoomScale = 1.0;
    scrollerView.zoomScale = MAX(minHorizScale, minVertScale);
    scrollerView.contentOffset = CGPointMake((scrollerView.contentSize.width - CGRectGetWidth(scrollerView.bounds)) / 2, (scrollerView.contentSize.height - CGRectGetHeight(scrollerView.bounds)) / 2);
    [self setContentInsetToCenterScrollView:scrollerView];
    
    //
    UIBlurEffect *darkBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *darkBlurView = [[UIVisualEffectView alloc] initWithEffect:darkBlur];
    [self.view addSubview:darkBlurView];
    
    //
    UIBlurEffect *lightBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *lightBlurView = [[UIVisualEffectView alloc] initWithEffect:lightBlur];
    [self.view addSubview:lightBlurView];
    
    //
    UIBlurEffect *extraLightBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *extraLightBlurView = [[UIVisualEffectView alloc] initWithEffect:extraLightBlur];
    [self.view addSubview:extraLightBlurView];
    
    
    //
    CGFloat blurAreaAmount = CGRectGetHeight(self.view.bounds) / 4;
    CGRect remainder, slice;
    CGRectDivide(self.view.bounds, &slice, &remainder, blurAreaAmount, CGRectMaxYEdge);
    darkBlurView.frame = slice;
    
    CGRectDivide(remainder, &slice, &remainder, blurAreaAmount, CGRectMaxYEdge);
    lightBlurView.frame = slice;
    
    CGRectDivide(remainder, &slice, &remainder, blurAreaAmount, CGRectMaxYEdge);
    extraLightBlurView.frame = slice;
    
    darkBlurView.frame = CGRectIntegral(darkBlurView.frame);
    lightBlurView.frame = CGRectIntegral(lightBlurView.frame);
    extraLightBlurView.frame = CGRectIntegral(extraLightBlurView.frame);
    
    
    
    UIVisualEffectView *extraLightVibrancyView = [self vibrancyEffectViewForBlurEffectView:extraLightBlurView];
    [extraLightBlurView.contentView addSubview:extraLightVibrancyView];
    
    UIVisualEffectView *lightVibrancyView = [self vibrancyEffectViewForBlurEffectView:lightBlurView];
    [lightBlurView.contentView addSubview:lightVibrancyView];
    
    UIVisualEffectView *darkVibrancyView = [self vibrancyEffectViewForBlurEffectView:darkBlurView];
    [darkBlurView.contentView addSubview:darkVibrancyView];
    
    
    UIButton *cameraButton = [self tintedIconButtonIconNamed:@"Camera"];
    cameraButton.center = [extraLightVibrancyView convertPoint:extraLightVibrancyView.center fromView:extraLightVibrancyView.superview];
    [extraLightVibrancyView.contentView addSubview:cameraButton];
    
    UIButton *geniusButton = [self tintedIconButtonIconNamed:@"Genius"];
    geniusButton.center = [lightVibrancyView convertPoint:lightVibrancyView.center fromView:lightVibrancyView.superview];
    [lightVibrancyView.contentView addSubview:geniusButton];
    
    UIButton *bitcoinButton = [self tintedIconButtonIconNamed:@"Bitcoin"];
    bitcoinButton.center = [darkVibrancyView convertPoint:darkVibrancyView.center fromView:darkVibrancyView.superview];
    [darkVibrancyView.contentView addSubview:bitcoinButton];
    
    
    
    UILabel *extraLightTitleLabel = [self titleLabelText:@"Extra Light Blur"];
    [extraLightVibrancyView.contentView addSubview:extraLightTitleLabel];
    
    UILabel *lightTitleLabel = [self titleLabelText:@"Light Blur"];
    [lightVibrancyView.contentView addSubview:lightTitleLabel];
    
    UILabel *darkTitleLabel = [self titleLabelText:@"Dark Blur"];
    [darkVibrancyView.contentView addSubview:darkTitleLabel];
    
    [self addVibrantStatusBarBackground:extraLightBlur];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - private
- (UIVisualEffectView *)vibrancyEffectViewForBlurEffectView:(UIVisualEffectView *)blurEffectView
{
    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)blurEffectView.effect];
    
    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
    vibrancyView.frame = blurEffectView.bounds;
    vibrancyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return vibrancyView;
}

- (UIButton *)tintedIconButtonIconNamed:(NSString *)iconName {
    UIImage *iconImage = [[UIImage imageNamed:iconName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *borderImage = [[UIImage imageNamed:@"ButtonRoundRect"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){CGPointZero, borderImage.size};
    [button setBackgroundImage:borderImage forState:UIControlStateNormal];
    [button setImage:iconImage forState:UIControlStateNormal];
    
    return button;
}

- (UILabel *)titleLabelText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    [label sizeToFit];
    
    CGRect labelFrame = label.frame;
    labelFrame.origin = CGPointMake(12, 12);
    label.frame = labelFrame;
    
    return label;
}

- (void)addVibrantStatusBarBackground:(UIBlurEffect *)effect {
    UIVisualEffectView *statusBarBlurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    statusBarBlurView.frame = [UIApplication sharedApplication].statusBarFrame;
    statusBarBlurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIVisualEffectView *statusBarVibrancyView = [self vibrancyEffectViewForBlurEffectView:statusBarBlurView];
    [statusBarBlurView.contentView addSubview:statusBarVibrancyView];
    
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    [statusBar.superview insertSubview:statusBarVibrancyView belowSubview:statusBar];
    [self.view addSubview:statusBarBlurView];
    
    UIImage *statusBarBackgroundImage = [[UIImage imageNamed:@"MaskPixel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *statusBarBackgroundView = [[UIImageView alloc] initWithImage:statusBarBackgroundImage];
    statusBarBackgroundView.frame = statusBarVibrancyView.bounds;
    statusBarBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [statusBarVibrancyView.contentView addSubview:statusBarBackgroundView];
    
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView.subviews.count == 0 ? nil : scrollView.subviews[0];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self setContentInsetToCenterScrollView:scrollView];
}

- (void)setContentInsetToCenterScrollView:(UIScrollView *)scrollView{
    
    CGFloat leftInset = 0.0;
    if (scrollView.contentSize.width < CGRectGetWidth(scrollView.bounds)) {
        leftInset = (CGRectGetWidth(scrollView.bounds) - scrollView.contentSize.width) / 2;
    }
    
    CGFloat topInset = 0.0;
    if (scrollView.contentSize.height < CGRectGetHeight(scrollView.bounds)) {
        topInset = (CGRectGetHeight(scrollView.bounds) - scrollView.contentSize.height) / 2;
    }
    
    scrollView.contentInset = UIEdgeInsetsMake(topInset, leftInset, 0, 0);
}

@end
