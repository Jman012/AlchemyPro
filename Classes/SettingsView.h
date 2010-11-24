//
//  SettingsView.h
//  Alchemy Pro
//
//  Created by James Linnell on 11/24/10.
//  Copyright 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewDelegate <NSObject>
@optional
- (void)shouldRefreshChangedSettings;
@end

@interface SettingsView : UIViewController <UIActionSheetDelegate> {
    id <SettingsViewDelegate>   delegate;
    IBOutlet UIView             *mainView;
    IBOutlet UIBarButtonItem    *backButton;
    IBOutlet UIButton           *clearProgressButton;
    IBOutlet UISegmentedControl *combineMethodSegment;
    IBOutlet UISegmentedControl *appearanceSegment;
    
    NSUserDefaults              *settings;
}

- (void)setDelegate:(id <SettingsViewDelegate>)dlg;
- (IBAction)backButtonPushed:(id)sender;
- (IBAction)clearButtonPushed:(id)sender;

@end
