#import "RNCloudPayments.h"
#import "SDK/Card.m"

@implementation RNCloudPayments

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(isValidNumber: (NSString *)cardNumber
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    if([Card isCardNumberValid: cardNumber]) {
        resolve(@YES);
    } else {
        resolve(@NO);
    }
};

RCT_EXPORT_METHOD(isValidExpired: (NSString *)cardExp
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    if([Card isExpiredValid: cardExp]) {
        resolve(@YES);
    } else {
        resolve(@NO);
    }
};

RCT_EXPORT_METHOD(getType: (NSString *)cardNumber
                  cardExp: (NSString *)cardExp
                  cardCvv: (NSString *)cardCvv
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    CardType cardType = [Card cardTypeFromCardNumber: cardNumber];
    NSString *cardTypeString = [Card cardTypeToString: cardType];

    resolve(cardTypeString);
}

RCT_EXPORT_METHOD(createCryptogram: (NSString *)cardNumber
                  cardExp: (NSString *)cardExp
                  cardCvv: (NSString *)cardCvv
                  publicId: (NSString *)publicId
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    Card *_card = [[Card alloc] init];

    NSString *cryptogram = [_card makeCardCryptogramPacket: cardNumber andExpDate:cardExp andCVV:cardCvv andMerchantPublicID:publicId];

    resolve(cryptogram);
}

RCT_EXPORT_METHOD(show3DS: (NSString *)url
                  transactionId: (NSString *)transactionId
                  token: (NSString *)token
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:url transactionId:transactionId token:token];
    webViewController.m_delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:navigationController animated:YES completion:NULL];
}

#pragma MARK: - SDWebViewDelegate

- (void)onWebViewWillClose:(UIWebView *)webView {
    
}

- (void)onWebViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)onWebViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewFailToLoad:(NSError *)error {
    
}


@end
