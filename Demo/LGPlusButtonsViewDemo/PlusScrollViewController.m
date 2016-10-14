//
//  PlusScrollViewController.m
//  LGPlusButtonsViewDemo
//
//  Created by Grigory Lutkov on 26.02.15.
//  Copyright (c) 2015 Grigory Lutkov. All rights reserved.
//

#import "PlusScrollViewController.h"
#import "LGPlusButtonsView.h"


#define HIGHLIGHT_COLOR [UIColor colorWithRed:88/255. green:89/255. blue:91/255. alpha:1]
#define BACKGROUND_COLOR [UIColor colorWithRed:38/255. green:160/255. blue:166/255. alpha:1]
#define TITLE_COLOR [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1]


@interface PlusScrollViewController ()

@property (strong, nonatomic) UIScrollView      *scrollView;
@property (strong, nonatomic) UIView            *exampleView;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewNavBar;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewMain;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewExample;

@end


@implementation PlusScrollViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"LGPlusButtonsView";

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showHideButtonsAction)];

        // -----

        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];

        _exampleView = [UIView new];
        _exampleView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.1];
        [_scrollView addSubview:_exampleView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _plusButtonsViewMain = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:5
                                                         firstButtonIsPlusButton:YES
                                                                   showAfterInit:YES
                                                                   actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                            {
                                NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);

                                if (index == 0)
                                    [_plusButtonsViewNavBar hideAnimated:YES completionHandler:nil];
                            }];

    _plusButtonsViewMain.observedScrollView = self.scrollView;
//    _plusButtonsViewMain.coverColor = [UIColor colorWithWhite:1.f alpha:0.7];
    _plusButtonsViewMain.showHideOnScroll = NO;
    _plusButtonsViewMain.hideButtonsOnScroll = YES;
    _plusButtonsViewMain.position = LGPlusButtonsViewPositionBottomRight;
    _plusButtonsViewMain.plusButtonAnimationType = LGPlusButtonAnimationTypeRotate;
    _plusButtonsViewMain.buttonsAppearingType = LGPlusButtonsAppearingTypeHorizontal;
    _plusButtonsViewMain.buttonsAppearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndSlideVertical;
    
    [_plusButtonsViewMain setContentEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setDescriptionsInsets:UIEdgeInsetsZero forOrientation:LGPlusButtonsViewOrientationAll];

    [_plusButtonsViewMain setButtonsTitles:@[@"⋮", @"", @"", @"", @""] forState:UIControlStateNormal];
    [_plusButtonsViewMain setDescriptionsTexts:@[@"", @"Unread", @"Read", @"All", @"Menu"]];
    [_plusButtonsViewMain setButtonsImages:@[[NSNull new], [UIImage imageNamed:@"Message"], [UIImage imageNamed:@"Read Message"], [UIImage imageNamed:@"Group Message"], [UIImage imageNamed:@"Home"]]
                                  forState:UIControlStateNormal
                            forOrientation:LGPlusButtonsViewOrientationAll];

    [_plusButtonsViewMain setButtonsAdjustsImageWhenHighlighted:NO];
    
    [_plusButtonsViewMain setButtonsBackgroundColor:BACKGROUND_COLOR forState:UIControlStateNormal];
    [_plusButtonsViewMain setButtonsBackgroundColor:HIGHLIGHT_COLOR forState:UIControlStateHighlighted];
    [_plusButtonsViewMain setButtonsBackgroundColor:HIGHLIGHT_COLOR forState:UIControlStateHighlighted|UIControlStateSelected];
    
    [_plusButtonsViewMain setButtonsSize:CGSizeMake(50, 50) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setButtonsLayerCornerRadius:50/2. forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setButtonsTitleFont:[UIFont systemFontOfSize:35 weight:UIFontWeightBlack] forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setButtonsLayerBorderWidth:1.5];
    [_plusButtonsViewMain setButtonsLayerBorderColor:HIGHLIGHT_COLOR];
    [_plusButtonsViewMain setButtonsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]];
    [_plusButtonsViewMain setButtonsLayerShadowOpacity:0.5];
    [_plusButtonsViewMain setButtonsLayerShadowRadius:3];
    [_plusButtonsViewMain setButtonsLayerShadowOffset:CGSizeMake(0, 2)];
    
    [_plusButtonsViewMain setDescriptionsBackgroundColor:HIGHLIGHT_COLOR];
    [_plusButtonsViewMain setDescriptionsFont:[UIFont systemFontOfSize:10] forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setDescriptionsTextColor:TITLE_COLOR];
    [_plusButtonsViewMain setDescriptionsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]];
    [_plusButtonsViewMain setDescriptionsLayerShadowOpacity:0.25];
    [_plusButtonsViewMain setDescriptionsLayerShadowRadius:1];
    [_plusButtonsViewMain setDescriptionsLayerShadowOffset:CGSizeMake(0, 1)];
    [_plusButtonsViewMain setDescriptionsLayerCornerRadius:6 forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewMain setDescriptionsSize:CGSizeMake(50, 12) forOrientation:LGPlusButtonsViewOrientationAll];
    
//    for (NSUInteger i=1; i<=3; i++)
//        [_plusButtonsViewMain setButtonAtIndex:i offset:CGPointMake(-6.f, 0.f)
//                                forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
//
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        [_plusButtonsViewMain setButtonAtIndex:0 titleOffset:CGPointMake(0.f, -2.f) forOrientation:LGPlusButtonsViewOrientationLandscape];
//        [_plusButtonsViewMain setButtonAtIndex:0 titleFont:[UIFont systemFontOfSize:32.f] forOrientation:LGPlusButtonsViewOrientationLandscape];
//    }

    [self.navigationController.view addSubview:_plusButtonsViewMain];

    // -----

    _plusButtonsViewNavBar = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:3
                                                           firstButtonIsPlusButton:NO
                                                                     showAfterInit:NO
                                                                     actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                              {
                                  NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                              }];

    _plusButtonsViewNavBar.showHideOnScroll = NO;
    _plusButtonsViewNavBar.appearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndPop;
    _plusButtonsViewNavBar.position = LGPlusButtonsViewPositionTopRight;

    [_plusButtonsViewNavBar setButtonsTitles:@[@"1", @"2", @"3"] forState:UIControlStateNormal];
    [_plusButtonsViewNavBar setDescriptionsTexts:@[@"Description 1", @"Description 2", @"Description 3"]];

    [_plusButtonsViewNavBar setButtonsTitleFont:[UIFont boldSystemFontOfSize:32.f] forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewNavBar setButtonsSize:CGSizeMake(52.f, 52.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewNavBar setButtonsLayerCornerRadius:52.f/2.f forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewNavBar setButtonsBackgroundColor:[UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f] forState:UIControlStateNormal];
    [_plusButtonsViewNavBar setButtonsBackgroundColor:[UIColor colorWithRed:0.2 green:0.6 blue:1.f alpha:1.f] forState:UIControlStateHighlighted];
    [_plusButtonsViewNavBar setButtonsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.f]];
    [_plusButtonsViewNavBar setButtonsLayerShadowOpacity:0.5];
    [_plusButtonsViewNavBar setButtonsLayerShadowRadius:3.f];
    [_plusButtonsViewNavBar setButtonsLayerShadowOffset:CGSizeMake(0.f, 2.f)];

    [_plusButtonsViewNavBar setDescriptionsTextColor:[UIColor whiteColor]];
    [_plusButtonsViewNavBar setDescriptionsBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.66]];
    [_plusButtonsViewNavBar setDescriptionsLayerCornerRadius:6.f forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewNavBar setDescriptionsContentEdgeInsets:UIEdgeInsetsMake(4.f, 8.f, 4.f, 8.f) forOrientation:LGPlusButtonsViewOrientationAll];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [_plusButtonsViewNavBar setButtonsSize:CGSizeMake(44.f, 44.f) forOrientation:LGPlusButtonsViewOrientationLandscape];
        [_plusButtonsViewNavBar setButtonsLayerCornerRadius:44.f/2.f forOrientation:LGPlusButtonsViewOrientationLandscape];
        [_plusButtonsViewNavBar setButtonsTitleFont:[UIFont systemFontOfSize:24.f] forOrientation:LGPlusButtonsViewOrientationLandscape];
    }

    [self.scrollView addSubview:_plusButtonsViewNavBar];

    // -----

    _plusButtonsViewExample = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:3
                                                         firstButtonIsPlusButton:YES
                                                                   showAfterInit:YES
                                                                   actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                            {
                                NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                            }];

    _plusButtonsViewExample.position = LGPlusButtonsViewPositionBottomLeft;
    _plusButtonsViewExample.plusButtonAnimationType = LGPlusButtonAnimationTypeCrossDissolve;
    _plusButtonsViewExample.buttonsAppearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolve;

    [_plusButtonsViewExample setButtonsTitles:@[@"+", @"1", @"2"] forState:UIControlStateNormal];
    [_plusButtonsViewExample setDescriptionsTexts:@[@"", @"Description 1", @"Description 2"]];

    [_plusButtonsViewExample setButtonsBackgroundColor:[UIColor colorWithRed:1.f green:0.f blue:0.5 alpha:1.f] forState:UIControlStateNormal];
    [_plusButtonsViewExample setButtonsBackgroundColor:[UIColor colorWithRed:1.f green:0.2 blue:0.6 alpha:1.f] forState:UIControlStateHighlighted];
    [_plusButtonsViewExample setButtonsBackgroundColor:[UIColor colorWithRed:1.f green:0.2 blue:0.6 alpha:1.f] forState:UIControlStateHighlighted|UIControlStateSelected];
    [_plusButtonsViewExample setButtonsSize:CGSizeMake(44.f, 44.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewExample setButtonsLayerBorderWidth:2.f];
    [_plusButtonsViewExample setButtonsLayerBorderColor:[UIColor colorWithWhite:0.9 alpha:1.f]];
    [_plusButtonsViewExample setButtonsTitleFont:[UIFont systemFontOfSize:24.f] forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewExample setButtonAtIndex:0 titleOffset:CGPointMake(0.f, -2.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewExample setButtonAtIndex:0 title:@"-" forState:UIControlStateSelected];

    [_plusButtonsViewExample setDescriptionsTextColor:[UIColor whiteColor]];
    [_plusButtonsViewExample setDescriptionsFont:[UIFont boldSystemFontOfSize:18.f] forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewExample setDescriptionsInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, 4.f) forOrientation:LGPlusButtonsViewOrientationAll];

    [_exampleView addSubview:_plusButtonsViewExample];
}

#pragma mark - Dealloc

- (void)dealloc
{
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
}

#pragma mark - Appearing

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    _scrollView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);

    UIEdgeInsets contentInsets = _scrollView.contentInset;
    contentInsets.top = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 2000.f);

    // -----

    _exampleView.frame = CGRectMake(0.f, 0.f, _scrollView.frame.size.width, 400.f);
}

#pragma mark -

- (void)showHideButtonsAction
{
    if (_plusButtonsViewNavBar.isShowing)
        [_plusButtonsViewNavBar hideAnimated:YES completionHandler:nil];
    else
        [_plusButtonsViewNavBar showAnimated:YES completionHandler:nil];
}


@end
