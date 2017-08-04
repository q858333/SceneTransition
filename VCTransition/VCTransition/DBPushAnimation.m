//
//  DBPushAnimation.m
//  VCTransition
//
//  Created by dengbin on 17/8/3.
//  Copyright © 2017年 dengbin. All rights reserved.
//

#import "DBPushAnimation.h"

@implementation DBPushAnimation
//设置转场动画的时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //from
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //to
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView* toView = nil;
    UIView* fromView = nil;
    //UITransitionContextFromViewKey和UITransitionContextToViewKey定义在iOS8.0以后的SDK中，所以在iOS8.0以下SDK中将toViewController和fromViewController的view设置给toView和fromView
    //iOS8.0 之前和之后view的层次结构发生变化，所以iOS8.0以后UITransitionContextFromViewKey获得view并不是fromViewController的view
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    //这个非常重要，将toView加入到containerView中
    [[transitionContext containerView]  addSubview:toView];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    toView.frame = CGRectMake(0, height, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

}


@end
