//
//  DBPopAnimation.m
//  VCTransition
//
//  Created by dengbin on 17/8/3.
//  Copyright © 2017年 dengbin. All rights reserved.
//

#import "DBPopAnimation.h"

@implementation DBPopAnimation
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

//此时 containerView里布包括上一个试图，需要添加上一个试图
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    // 1.创建一个关键帧动画

//    CAKeyframeAnimation*anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];
//
//    // 2.设置关键帧值数组
//
//    //anim.values=@[@(-M_PI_4*0.1*2),@(M_PI_4*0.1*2),@(-M_PI_4*0.1*2),];
//        anim.values=@[@0,@(2*M_PI)];
//    anim.duration = 0.7;
//    anim.repeatCount=1;//CGFLOAT_MAX;
//
//    // 3.把核心动画对象添加到layer中
//    [fromView.layer addAnimation:anim forKey:@"icon_anim"];


    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    //缩小小于1， 放大大于1
    basicAnimation.toValue = @0.0;

    basicAnimation.duration = 1;

    basicAnimation.removedOnCompletion = NO;

    basicAnimation.fillMode = kCAFillModeForwards;

    [fromView.layer addAnimation:basicAnimation forKey:nil];


    [self performSelector:@selector(cancel:) withObject:transitionContext afterDelay:1];


//    fromView.frame = CGRectMake(0, 0, width, height);
//   // fromView.frame = CGRectMake(0, height, width, height);
//
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        NSLog(@"%@",[NSThread currentThread]);
//      //  fromView.center = transitionContext.containerView.center;
//
//        fromView.frame = CGRectMake(width, 0,width, height);
//
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//
//    }];
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
//    } completion:^(BOOL finished) {
//
//    }];

}

- (void)cancel:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [transitionContext completeTransition:!transitionContext.transitionWasCancelled];


}

@end
