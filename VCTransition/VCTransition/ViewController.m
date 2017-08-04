//
//  ViewController.m
//  VCTransition
//
//  Created by dengbin on 17/8/3.
//  Copyright © 2017年 dengbin. All rights reserved.
//


#import "ViewController.h"
#import "SecondViewController.h"
#import "DBPushAnimation.h"
#import "DBPopAnimation.h"
@interface ViewController ()
{
    UIPercentDrivenInteractiveTransition *_interactiveTransition;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1";
    self.navigationController.delegate = self;



    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(panGestureRecognizerAction:)];
    [self.navigationController.view addGestureRecognizer:pan];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan{

    //产生百分比
    CGFloat process = [pan translationInView:self.view].x / ([UIScreen mainScreen].bounds.size.width);

    process = MIN(1.0,(MAX(0.0, process)));

    if (pan.state == UIGestureRecognizerStateBegan) {
        _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
        //触发pop转场动画
        [self.navigationController popViewControllerAnimated:YES];

    }else if (pan.state == UIGestureRecognizerStateChanged){
        [_interactiveTransition updateInteractiveTransition:process];
    }else if (pan.state == UIGestureRecognizerStateEnded
              || pan.state == UIGestureRecognizerStateCancelled){
        if (process > 0.5) {
            [_interactiveTransition finishInteractiveTransition];
        }else{
            [ _interactiveTransition cancelInteractiveTransition];
        }
        _interactiveTransition = nil;
    }
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return [[DBPushAnimation alloc] init];
    }
    else  if (operation == UINavigationControllerOperationPop)
    {
        return [[DBPopAnimation alloc] init];

    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isKindOfClass:[DBPopAnimation class]]) {
        return _interactiveTransition;
    }
    return nil;
}


@end
