//
//  KBUser.m
//  Keybase
//
//  Created by Gabriel on 6/18/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import "KBUser.h"
#import "KBPublicKey.h"
#import "KBProof.h"
#import "KBBitcoinAddress.h"

#import <ObjectiveSugar/ObjectiveSugar.h>

@implementation KBUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"identifier": @"id",
           @"userName": @"basics.username",
           @"image": @"pictures.primary",
           @"fullName": @"profile.full_name",
           @"bio": @"profile.bio",
           @"location": @"profile.location",
           
           @"email": @"emails.primary.email",
           @"bitcoinAddresses": @"cryptocurrency_addresses.bitcoin",
           @"proofs": @"proofs_summary.all",
           
           @"KID": @"public_keys.primary.kid",
           @"publicKey": @"public_keys.primary",
           };
}

+ (NSValueTransformer *)primaryImageJSONTransformer {
  return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:KBImage.class];
}

+ (NSValueTransformer *)publicKeyJSONTransformer {
  return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:KBPublicKey.class];
}

+ (NSValueTransformer *)proofsJSONTransformer {
  return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:KBProof.class];
}

+ (NSValueTransformer *)bitcoinAddressesJSONTransformer {
  return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:KBBitcoinAddress.class];
}

- (NSArray *)proofsForType:(KBProofType)type {  
  return [_proofs select:^BOOL(KBProof *proof) { return (proof.proofType == type); }];
}

- (NSUInteger)hash {
  return [_identifier hash];
}

- (BOOL)isEqual:(id)object {
  return ([object isKindOfClass:KBUser.class] && [[object identifier] isEqualToString:_identifier]);
}

@end
