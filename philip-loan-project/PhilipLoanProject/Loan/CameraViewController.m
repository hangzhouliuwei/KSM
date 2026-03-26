//
//  CameraViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/9.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController ()<AVCapturePhotoCaptureDelegate>
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation CameraViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideServeImageView = true;
    self.navigationItem.title = @"Employee ID Card";
    self.view.backgroundColor = UIColor.blackColor;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, kTopHeight);
    gradientLayer.colors = @[
        (__bridge id)UIColor.blackColor.CGColor,  // #2964F6
        (__bridge id)UIColor.blackColor.CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *rearCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:rearCamera error:&error];
    if ([self.captureSession canAddInput:self.videoInput]) {
        [self.captureSession addInput:self.videoInput];
    } else {
        NSLog(@"无法添加视频输入: %@", error.localizedDescription);
        return;
    }
    // 添加照片输出
    self.photoOutput = [[AVCapturePhotoOutput alloc] init];
    if ([self.captureSession canAddOutput:self.photoOutput]) {
        [self.captureSession addOutput:self.photoOutput];
    }
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.frame = CGRectMake(0, 0, kScreenW, kScreenH - 190);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    // 启动会话
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.captureSession startRunning];
    });
    
    
    // 添加拍照按钮
    UIButton *captureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    captureButton.frame = CGRectMake((self.view.bounds.size.width - 70) / 2, (190 - 70) / 2.0 + (kScreenH - 190), 70, 70);
    captureButton.layer.cornerRadius = 35;
    [captureButton setBackgroundImage:kImageName(@"auth_camera") forState:UIControlStateNormal];
    captureButton.backgroundColor = [UIColor whiteColor];
    [captureButton addTarget:self action:@selector(capturePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:captureButton];
}
- (void)capturePhoto {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettings];
    [self.photoOutput capturePhotoWithSettings:settings delegate:self];
}
#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output
didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(NSError *)error {
    if (error) {
        NSLog(@"拍照失败: %@", error.localizedDescription);
        return;
    }
    NSData *imageData = [photo fileDataRepresentation];
//#if DEBUG
//    imageData = UIImageJPEGRepresentation(kImageName(@"test.jpg"), 1);
//#endif
    UIImage *capturedImage = [UIImage imageWithData:imageData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.captureSession stopRunning];
        if (self.takeFinish) {
            self.takeFinish(nil, capturedImage);
        }
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    return;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        __block NSData *result = [self compressImageToTargetKB:300 oldData:imageData];
        
        [[PLPNetRequestManager plpJsonManager] UPLOADURL:@"twelveca/ocr" imageData:result paramsInfo:@{@"name":@"am",@"light":self.light} successBlk:^(id  _Nonnull responseObject) {
            kHideLoading
            if (self.takeFinish) {
                self.takeFinish(responseObject[@"viustwelveNc"], capturedImage);
            }
            [self.navigationController popViewControllerAnimated:YES];
        } failureBlk:^(NSError * _Nonnull error) {
            [self.captureSession startRunning];
        }];
    });
}
- (NSData *)compressImageToTargetKB:(NSInteger )numOfKB oldData:(NSData *)data{
    UIImage *image = [[UIImage alloc] initWithData:data];
    CGFloat compressionQuality = 0.9f;
    CGFloat compressionCount = 0;
    NSData *imageData = UIImageJPEGRepresentation(image,compressionQuality);
    while (imageData.length >= 1000 * numOfKB && compressionCount < 15) {
        compressionQuality = compressionQuality * 0.9;
        compressionCount ++;
        imageData = UIImageJPEGRepresentation(image, compressionQuality);
    }
    return imageData;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
