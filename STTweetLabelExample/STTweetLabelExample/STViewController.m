//
//  STViewController.m
//  STTweetLabel
//
//  Created by Sebastien Thiebaud on 12/15/12.
//  Copyright (c) 2012 Sebastien Thiebaud. All rights reserved.
//

#import "STViewController.h"
#import "STTweetLabel.h"

@interface STViewController ()

@end

@implementation STViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _tweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(20.0, 60.0, 280.0, 230.0)];
    
    STStoreCallbackBlock storeCallbackBlock = ^(STLinkActionType actionType, NSString *link)  {
        NSString *userDefaultsKey;
        switch (actionType)
        {
            case STLinkActionTypeAccount:
                userDefaultsKey = @"UserDefaultsHandleKey";
                break;
            case STLinkActionTypeHashtag:
                userDefaultsKey = @"UserDefaultsHashtagKey";
                break;
            case STLinkActionTypeWebsite:
                userDefaultsKey = @"UserDefaultsLinkKey";
                break;
            default:
                break;
        }
        NSData *userDefaultsData = [[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsKey];
        NSMutableSet *userDefaultsSet = userDefaultsData ? [NSKeyedUnarchiver unarchiveObjectWithData:userDefaultsData] : [[NSMutableSet alloc] init];
        if (![userDefaultsSet containsObject:link])
        {
            [userDefaultsSet addObject:link];
            userDefaultsData = [NSKeyedArchiver archivedDataWithRootObject:userDefaultsSet];
            [[NSUserDefaults standardUserDefaults] setObject:userDefaultsData forKey:userDefaultsKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    };
    
    [_tweetLabel setStoreCallbackBlock:storeCallbackBlock];
    
    [_tweetLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
    [_tweetLabel setTextColor:[UIColor blackColor]];
    [_tweetLabel setText:@"Hi. This is a new tool for @you! Developed by->@SebThiebaud for #iPhone #Obj-C... ;-)\nMy GitHub page: https://www.github.com/SebastienThiebaud!"];

    STLinkCallbackBlock linkCallbackBlock = ^(STLinkActionType actionType, NSString *link) {
        
        NSString *displayString = NULL;
        
        switch (actionType) {
                
            case STLinkActionTypeAccount:
                displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
                break;
                
            case STLinkActionTypeHashtag:
                displayString = [NSString stringWithFormat:@"Twitter hashtag:\n%@", link];
                break;
                
            case STLinkActionTypeWebsite:
                displayString = [NSString stringWithFormat:@"Website:\n%@", link];
                break;
        }
        
        [_displayLabel setText:displayString];
        
    };
    
    [_tweetLabel setLinkCallbackBlock:linkCallbackBlock];
    
    [self.view addSubview:_tweetLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
