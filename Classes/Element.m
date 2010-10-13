// Element.m
#import "Element.h"
#import "Alchemy_ProViewController.h"

@implementation Element


@synthesize controller, elementName, elementID, delegate;
@synthesize startPosition, sitting, inSideBar, currentPlacement;

- (void)setDelegate:(id <ElementDelegate>)dlg {
	delegate = dlg;
}

- (id)init {
    if((self = [super init])){
        self.userInteractionEnabled = TRUE;
        [self setBackgroundColor:[UIColor clearColor]];
        sitting = FALSE;
        inSidebar = FALSE;
        currentPlacement = 0;
        elementName = @"Blah";
        elementID = 1;
    }
    return self;
}

- (void)loadVisualViews {
    controller = [[Alchemy_ProViewController alloc] init];

    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    [backgroundImage setImage:[UIImage imageNamed:@"ElementBackground2.png"]];
    [backgroundImage setOpaque:TRUE];
    [self addSubview:backgroundImage];
    [backgroundImage release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, 64, 21)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setAdjustsFontSizeToFitWidth:TRUE];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:elementName];
    [self addSubview:label];
    [label release];
    
    UIImageView *mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 5, 32, 32)];
    [mainImage setImage:[UIImage imageNamed:@"SampleElementIcon2.png"]];
    [mainImage setOpaque:TRUE];
    [self addSubview:mainImage];
    [mainImage release];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint pt = [[touches anyObject] locationInView:self];
    startPosition = pt;
    [[self superview] bringSubviewToFront:self];
//    NSLog(@"Cont: %@", [controller firstElementComboTaken]);
    if(![controller firstElementComboTaken]){
        NSLog(@"Controller link working");
    }
	[delegate elementWasTouchedWithName:elementName andID:elementID];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGRect frame = [self frame];
    frame.origin.x += pt.x - startPosition.x;
    frame.origin.y += pt.y - startPosition.y;
    if(frame.origin.x >= 0 && frame.origin.y >= 0 && frame.origin.x <= 272 && frame.origin.y <= 252){
        inSidebar = FALSE;
        sitting = FALSE;
        if(currentPlacement != 0){
            if(currentPlacement == 1)
                [controller setFirstElementComboTaken:NO];
            if(currentPlacement == 2)
                [controller setSecondElementComboTaken:NO];
            if(currentPlacement == 3)
                [controller setThirdElementComboTaken:NO];
            currentPlacement = 0;
        }
        self.frame = frame;
    }
    else
        inSidebar = TRUE;
    
    if(inSidebar == TRUE){
//        if(CGRectContainsPoint(CGRectMake(272, 0, 80, 252), CGPointMake(self.frame.origin.x +   16, self.frame.origin.y))){
        if(sitting == FALSE){
            if([controller firstElementComboTaken] == NO){
                NSLog(@"First");
              [UIView beginAnimations:nil context:NULL];
                sitting = TRUE;
                currentPlacement = 1;
            [UIView setAnimationDuration:0.2];
                [self setFrame:CGRectMake(280, 8, 64, 64)];
            [UIView commitAnimations];
                [controller setFirstElementComboTaken:YES];
            }
            else{
                if([controller secondElementComboTaken] == NO){
                    NSLog(@"Second");
                    [UIView beginAnimations:nil context:NULL];
                    sitting = TRUE;
                    currentPlacement = 2;
                    [UIView setAnimationDuration:0.2];
                    [self setFrame:CGRectMake(280, 80, 64, 64)];
                    [UIView commitAnimations];
                    [controller setSecondElementComboTaken:YES];
                }
                else {
                    if([controller thirdElementComboTaken] == NO){
                        NSLog(@"Third");
                        [UIView beginAnimations:nil context:NULL];
                        sitting = TRUE;
                        currentPlacement = 3;
                        [UIView setAnimationDuration:0.2];
                        [self setFrame:CGRectMake(280, 152, 64, 64)];
                        [UIView commitAnimations];
                        [controller setThirdElementComboTaken:YES];
                    }
                }
            }
        }
    }
//    NSLog(@"%i, %i", (int)self.frame.origin.x, (int)self.frame.origin.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    pt = pt; // Only for not getting a warning
}

- (void)dealloc {
    [controller release];
    [super dealloc];
}

@end
