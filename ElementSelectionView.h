//
//  ElementSelectionView.h
//  Alchemy Pro
//
//  Created by James Linnell on 10/30/10.
//  Copyright (c) 2010 PDHS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ElementSelectionView : UIViewController {
    IBOutlet UILabel            *titleLabel;
    IBOutlet UIToolbar          *toolbar;
    IBOutlet UIBarButtonItem    *backAndDoneButton;
    IBOutlet UIScrollView       *scrollView;
    IBOutlet UIPageControl      *pageControl;
}

@property (nonatomic, retain) IBOutlet UILabel          *titleLabel;
@property (nonatomic, retain) IBOutlet UIToolbar        *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem  *backAndDoneButton;

- (IBAction)backDoneButtonPushed:(id)sender;

@end
