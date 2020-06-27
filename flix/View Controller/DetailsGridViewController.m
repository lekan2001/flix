//
//  DetailsGridViewController.m
//  flix
//
//  Created by Olalekan Abdurazaq Adisa on 6/26/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "DetailsGridViewController.h"
#import "UIImageView+AFNetworking.h"
@interface DetailsGridViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backDropView;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLStrring = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL * posterURL = [NSURL URLWithString:fullPosterURLStrring];
    [self.posterView setImageWithURL:posterURL];
    
   
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackDropURLStrring = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL * backDropURL = [NSURL URLWithString:fullBackDropURLStrring];
    [self.backDropView setImageWithURL:backDropURL];
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
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
