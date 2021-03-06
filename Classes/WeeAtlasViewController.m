//
//  WeeAtlasViewController.m
//  WeeAtlas
//
//  Created by Josh Vickery on 4/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WeeAtlasViewController.h"
#import "WeeAtlasAppDelegate.h"
#import "CountryViewController.h"

@implementation WeeAtlasViewController

@synthesize brazilButton, countryVC, splashView, mapView, countryView, countryButtonImage;
@synthesize countryControllerDelegate, backgroundView, mapFrame;

- (IBAction) countryPressed {
	NSNumber *countryTag = [NSNumber numberWithInt:brazilButton.tag];
	NSDictionary *params = [NSDictionary dictionaryWithObject:countryTag forKey:@"countryTag"];
	NSNotification *notification = [NSNotification notificationWithName:@"CountrySelected" object:nil userInfo:params];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void) shrinkMapGrowCountry {
	CGRect mapRect = self.mapView.frame;
	self.brazilButton.hidden = YES;
	self.countryButtonImage.hidden = NO;
	self.mapFrame.hidden = YES;

	[UIView beginAnimations:@"shrinkMapGrowCountry" context:nil];
	[UIView setAnimationDuration:3];
	[UIView setAnimationDidStopSelector:@selector(countryDidFinishGrowing)];
	[UIView setAnimationDelegate:self];
	
	mapRect.origin.y = 20;
	mapRect.origin.x = 20;
	mapRect.size.width = 100;
	mapRect.size.height = 75;
	self.mapView.frame = mapRect;	
	
	self.mapView.alpha = 0.3;
	
	CGRect countryRect = self.countryButtonImage.frame;
	countryRect.origin.x = 281;
	countryRect.origin.y = 117;
	countryRect.size.width = 520;
	countryRect.size.height = 549;
	self.countryButtonImage.frame = countryRect;
	
	[UIView commitAnimations];
}

- (void) countryDidFinishGrowing {
	[self.countryControllerDelegate controllerDidFinishSelectionAnimation:self];
}

- (void) shrinkCountryGrowMap {
	self.backgroundView.alpha = 0;
	self.mapView.alpha = 1;
	[UIView beginAnimations:@"shrinkCountryGrowMap" context:nil];
	[UIView setAnimationDuration:3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(mapDidFinishGrowing)];

	self.backgroundView.alpha = 1;
	
	CGRect mapRect = CGRectMake(0, 0, 1024, 748);
	self.mapView.frame = mapRect;
	
	CGRect countryRect = CGRectMake(180, 317, 217, 296);
	self.countryButtonImage.frame = countryRect;
	
	[UIView commitAnimations];
}
	
- (void) mapDidFinishGrowing {
	self.brazilButton.hidden = NO;
	self.mapFrame.hidden = NO;
	[self.countryControllerDelegate controllerDidFinishReturnToMapAnimation:self];
}

- (void) growSplash {
	[UIView beginAnimations:@"zoomSplash" context:nil];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationDidStopSelector:@selector(crossFadeSplashToMap)];
	[UIView setAnimationDelegate:self];
	CGRect splashRect = self.splashView.frame;
	float newWidth = 2500;
	float newHeight = 1550;
	splashRect.origin.x = -740;
	splashRect.origin.y = -400;
	splashRect.size.width = newWidth;
	splashRect.size.height = newHeight;
	self.splashView.frame = splashRect;
	[UIView commitAnimations];
}

- (void) crossFadeSplashToMap {
	self.mapView.hidden = NO;
	self.mapView.alpha = 0;
	self.brazilButton.hidden = NO;
	self.brazilButton.alpha = 0;
	self.mapFrame.hidden = NO;
	self.mapFrame.alpha = 0;
	[UIView beginAnimations:@"crossFadeSplashToMap" context:nil];
	[UIView setAnimationDuration:1];
	self.splashView.alpha = 0;
	self.mapView.alpha = 1;
	self.brazilButton.alpha = 1;
	self.mapFrame.alpha = 1;
	[UIView commitAnimations];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
	[brazilButton release];
	[countryVC release];
	[splashView release];
	[mapView release];
	[countryView release];
	[countryButtonImage release];
	[backgroundView release];
	[mapFrame release];
    [super dealloc];
}

@end
