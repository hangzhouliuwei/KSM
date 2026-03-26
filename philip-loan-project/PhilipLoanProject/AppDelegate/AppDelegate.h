//
//  AppDelegate.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/23.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic)UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

