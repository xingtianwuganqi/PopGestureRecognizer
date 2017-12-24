//
//  AppDelegate.h
//  PopGestureRecognizer
//
//  Created by 景军 on 2017/12/24.
//  Copyright © 2017年 com.technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

