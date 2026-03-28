//
//  BagBaseProtocol.h
//  NewBag
//
//  Created by Jacky on 2024/3/21.
//

#ifndef BagBaseProtocol_h
#define BagBaseProtocol_h

@protocol BagBaseProtocol <NSObject>
@optional
- (void)updateUIWithModel:(id)model;
- (void)showToast:(NSString *)title duration:(CGFloat)duration;
- (void)dissmiss;
@end
#endif /* BagBaseProtocol_h */
