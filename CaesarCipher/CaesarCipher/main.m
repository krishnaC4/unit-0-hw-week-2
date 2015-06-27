//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>


/*---------------------------------------------------------------- START INTERFACE  -----------------------------------------------------*/




@interface CaesarCipher : NSObject

- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;


@end





/*---------------------------------------------------------------- START IMPLEMENTATION  -----------------------------------------------------*/




@implementation CaesarCipher



/*---------------------------------------------------------------- START ENCODING FUNCTION-----------------------------------------------------*/



NSString *_encode;
-(void)setEncode:(NSString *)encode {
    _encode = encode;
}

-(NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";
    
    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);
        
        result[i] = allchars[new_idx];
    }
    
    return [NSString stringWithCharacters:result length:count];
}


/*---------------------------------------------------------------- DECODING FUNCTION -----------------------------------------------------*/

NSString *_decode;
-(void)setDecode:(NSString *)decode {
    _decode = decode;
}



-(NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}

@end




/*---------------------------------------------------------------- START MAIN PROGRAM -----------------------------------------------------*/




int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        CaesarCipher *homeWorkCipher= [[CaesarCipher alloc] init];
        
        
        /*conversion code from forums.macrumors.com/threads/newbie-question-how-to-get-input-from-a-user-for-an-object-such-as-nsstring.1019370 */
        
        //Declare Variables
        
        char cString[100]; //cString is a string of 100 characters (technically an array of 100 characters)
        char ccString[100]; //cString is a string of 100 characters (technically an array of 100 characters)
        NSNumber *options;
        NSNumber *selectOffset;
        NSString *nsConversion;
        NSString *encodedString;
        NSString *decodedString;
        NSString *stringToCompare;
        
        
        /*---------------------------------------------------------------- user interaction -----------------------------------------------------*/
        
        NSLog(@"\n\n to generate an encoded word PRESS 1 and ENTER \n\n to decode a word PRESS 2 and ENTER \n\n to compare encoded words PRESS 3 and ENTER");
        scanf("%i", &options);
        
        
        if (options == 1){
            NSLog(@"Enter a word for enconding...");
            scanf("%s", cString);
            NSLog(@"Please enter an offset");
            scanf("%i", &selectOffset);
            
            //selectOffset = [NSString stringWithCString: numString encoding: NSASCIIStringEncoding];
            nsConversion = [NSString stringWithCString: cString encoding: NSASCIIStringEncoding];
            encodedString = [homeWorkCipher encode: nsConversion offset:(selectOffset)];
            
            NSLog(@"You entered: %@", nsConversion);
            NSLog(@"your encoded string is >> %@",  encodedString);
            return 0;
            
        }
        
        else if (options == 2){
            NSLog(@"%s","enter a word to be decoded...");
            scanf("%s", cString);
            
            NSLog(@"%s","enter the offset you want to use...");
            scanf("%i", &selectOffset);
            
            nsConversion = [NSString stringWithCString: cString encoding: NSASCIIStringEncoding];
            decodedString = [homeWorkCipher decode: nsConversion offset:(selectOffset)];
            
            
            NSLog(@"You entered: %@", nsConversion);
            NSLog(@"your encoded string is >> %@s",  decodedString);
            
        }
        else
        {
            NSLog(@"You slected option #3, enter two encoded values for comparasion:\n\n" "Please enter your first word for comparision...");
            scanf("%s", cString );
            
            NSLog(@"%s","Please enter your second word for comparision...");
            scanf("%s", ccString);
            
            
            nsConversion = [NSString stringWithCString: cString encoding: NSASCIIStringEncoding];
            stringToCompare = [NSString stringWithCString: ccString encoding: NSASCIIStringEncoding];
            
            
            for (int i = 0; i < 25; i++){
                if (nsConversion ==  [homeWorkCipher encode: stringToCompare offset:(i)]){
                    NSLog(@"they are the same");
                    break;
                    
                } else {
                    NSLog(@"They are not the same");
                    
                    
                }
                
            }
        }
    }
    return 0;
    
    
}
