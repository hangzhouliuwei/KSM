//
//  NSString+Category.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)

-(BOOL)isReal;


-(CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font;
-(CGFloat)widthWithFont:(UIFont *)font;


@end

@interface NSNull (Category)
-(BOOL)isReal;
@end


NS_ASSUME_NONNULL_END
