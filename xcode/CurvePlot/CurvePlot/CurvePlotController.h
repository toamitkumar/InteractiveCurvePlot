//
//  ViewController.h
//  CurvePlot
//
//  Created by Amit Kumar on 11/14/12.
//  Copyright (c) 2012 Amit Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurvePlotController : UIViewController

@property (nonatomic, retain) IBOutlet CPTGraphHostingView *curve_hosting_view;
@property (nonatomic, retain) IBOutlet UISlider *horizontal_zoom;

-(IBAction)zoom_x:(id)sender;

@end
