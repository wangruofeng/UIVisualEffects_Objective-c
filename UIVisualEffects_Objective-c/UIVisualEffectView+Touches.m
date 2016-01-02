//
//  UIVisualEffectView+Touches.m
//  UIVisualEffects_Objective-c
//
//  Created by 王若风 on 1/2/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "UIVisualEffectView+Touches.h"

@implementation UIVisualEffectView (Touches)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    return view = self.contentView ? nil : view;
}

@end
