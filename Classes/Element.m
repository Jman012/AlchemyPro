// Element.m
#import "Element.h"
#import "Alchemy_ProViewController.h"

@implementation Element


@synthesize elementName, elementID, delegate;
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
    }
    return self;
}

- (void)loadVisualViews {
    
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
	[delegate elementWasTouchedWithName:elementName andID:elementID touch:touches andEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [delegate elementWasMovedWithName:elementName andID:elementID touch:touches andEvent:event];
//    NSLog(@"%i, %i", (int)self.frame.origin.x, (int)self.frame.origin.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    pt = pt; // Only for not getting a warning
}

- (BOOL)isValid {
    return TRUE;
}

- (void)dealloc {
    [super dealloc];
}

@end
