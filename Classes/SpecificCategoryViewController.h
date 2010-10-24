//
//  SpecificCategoryViewController.h
//  Alchemy Pro
//
//  Created by James Linnell on 10/23/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SpecificCategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UIBarButtonItem    *backButton;
    IBOutlet UIToolbar          *toolbar;
    IBOutlet UITableView        *mainTableView;
    IBOutlet UILabel            *titleLabel;
    
    NSString                    *category;
    
    NSDictionary                *elementCategories;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem  *backButton;
@property (nonatomic, retain) IBOutlet UIToolbar        *toolbar;
@property (nonatomic, retain) IBOutlet UITableView      *mainTableView;
@property (nonatomic, retain) IBOutlet UILabel          *titleLabel;

@property (nonatomic, retain) NSString                  *category;

@property (nonatomic, retain) NSDictionary              *elementCategories;

- (IBAction)backButtonPressed:(id)sender;
- (void)giveCategory:(NSString *)categoryName;

@end
