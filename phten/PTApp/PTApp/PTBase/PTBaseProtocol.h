//
//  PTBaseProtocol.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#ifndef PTBaseProtocol_h
#define PTBaseProtocol_h
@protocol PTBaseProtocol <NSObject>

@optional
- (void)router:(NSString *)url;
- (void)updateUIWithModel:(id)model;
- (void)showToast:(NSString *)title duration:(CGFloat)duration;
- (void)dissmiss;
- (void)removeViewController;
@end

#endif /* PTBaseProtocol_h */
