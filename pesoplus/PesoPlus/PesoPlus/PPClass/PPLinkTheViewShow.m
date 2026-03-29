//
//  PPLinkTheViewShow.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPLinkTheViewShow.h"

#import <ContactsUI/ContactsUI.h>

@interface PPLinkTheViewShow() <CNContactPickerDelegate>
@end

@implementation PPLinkTheViewShow

- (void)display {
    self.hidden = YES;
}

- (void)hide {
    self.hidden = NO;
}
@end
