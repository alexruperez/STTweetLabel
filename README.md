# STTweetLabel

A custom UILabel view controller for iOS with certain words tappable like Twitter (#Hashtag, @People and http://www.link.com/page)

![STTweetLabel screenshot](https://raw.github.com/alexruperez/STTweetLabel/master/screenshot.png "STTweetLabel Screenshot")

## Documentation

You need only 2 files:

- `STTweetLabel.h`
- `STTweetLabel.m`

You can change the fonts and colors for the different words (#Hashtag/@People AND http://link.com) via the `STTweetLabel` attributes.

## Demo

Build and run the project STTweetLabelExample in Xcode to see `STTweetLabel` in action. 

## Example Usage

``` objective-c
    STTweetLabel *tweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(20.0, 60.0, 280.0, 200.0)];
    
    [tweetLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
    [tweetLabel setTextColor:[UIColor blackColor]];
    [tweetLabel setText:@"Hi. This is a new tool for @you! Developed by->@SebThiebaud for #iPhone #ObjC... ;-) My GitHub page: https://t.co/pQXDoiYA"];
    [self.view addSubview:tweetLabel];
```

Don't forget to implement the `STLinkCallbackBlock`. Without implementing the callback block, you won't be able to detect if somebody has clicked on the hashtag, user account or even a website.
Blocks are easy. All you need to do is add a few lines of code:

``` objective-c
    STLinkCallbackBlock linkCallbackBlock = ^(STLinkActionType actionType, NSString *link) {
	        
        NSString *displayString = NULL;
        
        // determine what the user clicked on
        switch (actionType) {
                
            // if the user clicked on an account (@_max_k)    
            case STLinkActionTypeAccount:
                displayString = [NSString stringWithFormat:@"Twitter account:\n%@", link];
                break;
            
            // if the user clicked on a hashtag (#thisisreallycool)
            case STLinkActionTypeHashtag:
                displayString = [NSString stringWithFormat:@"Twitter hashtag:\n%@", link];
                break;
            
            // if the user clicked on a website (http://github.com/SebastienThiebaud)
            case STLinkActionTypeWebsite:
                displayString = [NSString stringWithFormat:@"Website:\n%@", link];
                break;
        }
        
        [_displayLabel setText:displayString];
        
    };
```

Once you have added those few lines of code (depending on what you want to do when the user taps on something), make sure to tell your instance of STTweetLabel to call this block:

``` objective-c
    [_tweetLabel setLinkCallbackBlock:linkCallbackBlock];
```

Optionally, you can store the hot word and its range for autocomplete or statistics. Don't forget to implement the storeBlock before setting the text.

``` objective-c
	STStoreCallbackBlock storeCallbackBlock = ^(STLinkActionType actionType, NSString *link) {
	    // Do something
	}];
	[_tweetLabel setStoreCallbackBlock:storeCallbackBlock];
```

## Credits

Inspired by the original Twitter application.

Ready to work with [alexruperez/ARAutocompleteTextView](https://github.com/alexruperez/ARAutocompleteTextView).

## Contact

Alejandro Rupérez

- http://alexruperez.com
- http://github.com/alexruperez
- http://twitter.com/alexruperez

## License

STTweetLabel is available under the MIT license.

