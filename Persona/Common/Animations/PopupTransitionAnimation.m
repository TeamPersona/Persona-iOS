//
//  PopupTransitionAnimation.m
//  Persona
//
//  Created by Denny Kim on 2016-02-29.
//  Copyright © 2016 Persona. All rights reserved.
//

#import "PopupTransitionAnimation.h"

@interface PopupTransitionAnimation ()
@property (nonatomic, strong) UIView *overlayView;
@end

@implementation PopupTransitionAnimation

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresenting = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromVCFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectMake(0, 0, CGRectGetWidth(fromVCFrame), CGRectGetHeight(fromVCFrame));
    CGRect initialFrame = CGRectMake(0, CGRectGetHeight(fromVCFrame), CGRectGetWidth(fromVCFrame), CGRectGetHeight(fromVCFrame));
    
    if (!self.overlayView) {
        self.overlayView = [[UIView alloc] initWithFrame:finalFrame];
        self.overlayView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    }
    
    if (self.isPresenting) {
        self.overlayView.alpha = 0.0;
        toVC.view.frame = initialFrame;
        [[transitionContext containerView] addSubview:self.overlayView];
        [[transitionContext containerView] addSubview:toVC.view];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toVC.view.frame = finalFrame;
            self.overlayView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        self.overlayView.alpha = 1.0;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromVC.view.frame = initialFrame;
            self.overlayView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [fromVC.view removeFromSuperview];
            [self.overlayView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }

}

@end
