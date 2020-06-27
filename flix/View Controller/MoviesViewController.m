//
//  MoviesViewController.m
//  flix
//
//  Created by Olalekan Abdurazaq Adisa on 6/24/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *movies;
 
@property (weak, nonatomic) IBOutlet
    UITableView *tableView;

@property(nonatomic, strong)UIRefreshControl *refreshControl;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.activityIndicator = [[UIActivityIndicatorView alloc]init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    [_refreshControl setTintColor:[UIColor redColor]];
    
    
   
    
  
}



-(void) fetchMovies{
    [self.activityIndicator startAnimating];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
      NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
      NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
      NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          
             if (error != nil) {
                 
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Movie Not Found" preferredStyle:(UIAlertControllerStyleAlert)];
                 UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                     
                 }];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [self.tableView reloadData];
                 }];
                 
                 [alert addAction:okAction];
                 [alert addAction:cancelButton];
                 [self presentViewController:alert animated:YES completion:^{
                     
                 }];
                 
                 
                 NSLog(@"%@", [error localizedDescription]);
             }
             else {
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                 
                 NSLog(@"%@", dataDictionary);
                 // TODO: Get the array of movies
     
                 self.movies = dataDictionary[@"results"];
                 [self.activityIndicator stopAnimating];

                 for (NSDictionary *movie in self.movies) {
                     
                     NSLog(@"%@", movie[@"title"]);
                    // NSLog(@"")
                 }
                
                 [self.tableView reloadData];
                 
                 
                 
                 // TODO: Store the movies in a property to use elsewhere
                 // TODO: Reload your table view data
             }
          [self.refreshControl endRefreshing];
          
          
      }];
      [task resume];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.movies.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
        
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    
//    NSLog(@"%@",[NSString stringWithFormat:@"row: %d, section %d", indexPath.row,indexPath.section]);
    
    
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLStrring = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL * posterURL = [NSURL URLWithString:fullPosterURLStrring];
    
    
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
   DetailsViewController *detailsViewController =[segue destinationViewController];
    detailsViewController.movie = movie;
    
    
  //  NSLog(@"%@", tappedCell );

}
//*/

@end
