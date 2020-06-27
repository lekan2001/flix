//
//  MovieTrailerViewController.m
//  flix
//
//  Created by Olalekan Abdurazaq Adisa on 6/26/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "MovieTrailerViewController.h"
#import  <WebKit/WebKit.h>

#import "UIImageView+AFNetworking.h"
@interface MovieTrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *trailerView;
@property NSString *urlString;

@end

@implementation MovieTrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *basevideoURLString = @"https://youtube.com/watch?v=";
    id videoURLString = self.movie[@"key"];
    NSString *fullPosterURLStrring = [basevideoURLString stringByAppendingFormat:@"%@", videoURLString];
    
    NSURL * videoURL = [NSURL URLWithString:fullPosterURLStrring];
    NSLog(@"%@", videoURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:videoURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [self.trailerView loadRequest:request];
    [self fetchVideos];
   
    
    //[self.posterView setImageWithURL:posterURL];
    
    
    
    
    
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    
    
    
}


-(void) fetchVideos{
    //[self.activityIndicator startAnimating];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/508439/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"];
      NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
      NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
      NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          
             if (error != nil) {
                 
                 NSLog(@"%@", [error localizedDescription]);
             }
             else {
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                 
                 NSLog(@"%@", dataDictionary);
                 // TODO: Get the array of movies
     
                 self.movie = dataDictionary[@"results"];
                 //[self.activityIndicator stopAnimating];

                 for (NSDictionary *movie in self.movie) {
                     
                     NSLog(@"%@", movie[@"key"]);
                     
                    // NSLog(@"%@", movie[@"id"]);
                    // NSLog(@"")
                 }
             }
      }];
      [task resume];
}








#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieTrailerViewController *movietrailer = segue.destinationViewController;
    movietrailer.trailerView = self.trailerView.URL;
    
    
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end




/*
 WKWebView
#import <WebKit/WebKit.h>

 From Stephanie Santana to Everyone: (4:14 PM)
 
https://courses.codepath.org/courses/ios_university_fast_track/unit/5#!exercises
https://www.youtube.com/watch?v=PJ2D_soJycE
PJ2D_soJycE
how to pass url to wkwebview
 
 
 
 */
