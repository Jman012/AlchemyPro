//
//  Alchemy_ProAppDelegate.h
//  Alchemy Pro
//
//  Created by James Linnell on 9/25/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alchemy_ProViewController;

@interface Alchemy_ProAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Alchemy_ProViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Alchemy_ProViewController *viewController;

@end
