//
//  UIImage+XTCategory.h
//  XTApp
//
//  Created by xia on 2024/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XTCategory)

/*
 *  压缩图片方法(先压缩质量再压缩尺寸)
 */
-(NSData *)xt_compressWithLengthLimit:(NSUInteger)maxLength;
/*
 *  压缩图片方法(先压缩质量再压缩尺寸)
 */
-(UIImage *)xt_imageCompressWithLengthLimit:(NSUInteger)maxLength;
/*
 *  压缩图片方法(压缩质量)
 */
-(NSData *)xt_compressQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩质量二分法)
 */
-(NSData *)xt_compressMidQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩尺寸)
 */
-(NSData *)xt_compressBySizeWithLengthLimit:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
