//
//  PPHaussKingPictureTools.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPHaussKingPictureTools.h"
@interface PPHaussKingPictureTools () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, copy) CallBackObject finishBlock;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@end

@implementation PPHaussKingPictureTools

- (void)ppGotoChoosePictureToUse:(CallBackObject)block {
    self.finishBlock = block;
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    
    [self showAlert];
}

- (void)showAlert {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [Page present:self.imagePicker animated:YES completion:nil];
        }
    }];
    [actionSheet addAction:cameraAction];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
          self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
          [Page present:self.imagePicker animated:YES completion:nil];
      }
    }];
   [actionSheet addAction:photoAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [actionSheet addAction:cancelAction];
    [Page present:actionSheet animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.finishBlock) {
        self.finishBlock(image);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
