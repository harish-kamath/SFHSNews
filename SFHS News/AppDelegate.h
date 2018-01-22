//
//  AppDelegate.h
//  SFHS News
//
//  Created by Harish Kamath on 12/20/14.
//  Copyright (c) 2014 Harish Kamath. All rights reserved.
//
//  This class is the default-created class in all iOS applications. It is the first one called, and manages window creation and view hierarchy during the initial app opening. For those unfamiliar with iOS development, I will continue to explain basic iOS concepts. NOTE: A background in programming is inferred. I will explain how classes and methods are initialized and used, but the basic understanding of what a class and method is should be known to the reader.

//There are two main parts to all iOS classes: the header file(.h extension), and the implementation file(.m extension). The header file is mostly used to apply delegates to a class, introduce any public methods, and create instances of any variables. The implementation file is the backbone of the class, and implements methods and variables into the application.

//The #import command is used to give access to any other classes. Classes surrounded by <>(as in this example) mean that the class is default to iOS development, while "" signifies a locally created class.
#import <UIKit/UIKit.h>
       //Name of class   Parent class Delegate. This is used to give the class access to specific methods.
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
//Area in which private variables are first stated.
    
}

//Method to instantiate public variables. Needs to be @synthesized as well in .m file.
@property (strong, nonatomic) UIWindow *window;

//Any methods will go here. Methods are usually in the format of +/- (returntype) nameOfMethod:(type)parameterOne parameterTwoName:(type)parameterTwo...
//A method started by a - refers to a instance method. A method started by a + refers to a static method. Only one static method exists in this project; the database static method.


@end

