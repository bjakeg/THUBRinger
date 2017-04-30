//
//  NetworkHandler.m
//  Phone
//
//  Created by Jake Graham on 4/24/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "NetworkHandler.h"
#import "GCDAsyncUdpSocket.h"

const char kFromAddressByteArray[] = {0x0a,0x01,0x01,0x0a};

@interface NetworkHandler () <GCDAsyncUdpSocketDelegate>
@end

@implementation NetworkHandler {
    GCDAsyncUdpSocket *socket;
    uint8_t count;
    NSMutableArray *packetArray;
    NSString *port;
}

- (id)init {
    self = [super init];
    if (self) {
        count = 0;
        packetArray = [NSMutableArray arrayWithCapacity:255];
    }
    return self;
}

- (void)initNetworkCommunication {

    socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if (![socket bindToPort:3010 error:&error]) {
        NSLog(@"Error binding: %@",error);
        return;
    }
    
    if (![socket beginReceiving:&error]) {
        NSLog(@"Error receiving: %@",error);
        return;
    }
    
    if (![socket enableBroadcast:YES error:&error]) {
        NSLog(@"Error enableBroadcast: %@",error);
        return;
    }
    
    NSData *header = [self headerToAdress:@"ffffffff" format:@"02"];
    NSMutableData *packetToSend = [NSMutableData dataWithData:header];
    NSData *payload = [self dataFromHexString:@"0a 01 01 0a b0 01 9d bf 67 01 08 06 00 09 00 00 00 5d 00 01 00 05 00 01 00 00 00 1b 00 0a 00 00 00"];
    [packetToSend appendData:payload];
    NSLog(@"%@", packetToSend);
    //[packetArray insertObject:packetToSend atIndex:count-1];
    [socket sendData:packetToSend toHost:@"255.255.255.255" port:3010 withTimeout:-1 tag:1];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock
           didReceiveData:(NSData *)data
              fromAddress:(NSData *)address
        withFilterContext:(id)filterContext {
    NSString* string = [self hexStringFromData:data];
    NSLog(@"%@", string);
    
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        // Perform long running process
        [self respondToPacket:string];
        
    });
    
}

- (void)respondToPacket:(NSString *)packet {
    NSData *header;
    NSMutableData *packetToSend;
    NSString *format = [packet substringWithRange:NSMakeRange(20, 2)];
    NSString *fromCount = [packet substringWithRange:NSMakeRange(22, 2)];
    NSString *fromAddress = [packet substringWithRange:NSMakeRange(8,8)];
    NSString *toAddress = [packet substringWithRange:NSMakeRange(0, 8)];
    NSLog(@"Format:%@   Count:%@   From:%@   To:%@", format, fromCount,[self IPAddressFromHexString:fromAddress], [self IPAddressFromHexString:toAddress]);
    
    if ([fromAddress isEqualToString:@"0A01010A"]) {
        return;
    }
    // Send 12 receipt packet for all directed packets
    if (![toAddress isEqualToString:@"FFFFFFFF"] && ![format isEqualToString:@"12"]) {
        header = [self headerToAdress:fromAddress format:@"12"];
        packetToSend = [NSMutableData dataWithData:header];
        NSData *payload = [self dataFromHexString:fromCount];
        [packetToSend appendData:payload];
        NSLog(@"%@", packetToSend);
        //[packetArray insertObject:packetToSend atIndex:count-1];
        [socket sendData:packetToSend toHost:[self IPAddressFromHexString:fromAddress] port:3010 withTimeout:-1 tag:1];
        
        // Rule #2
        if ([format isEqualToString:@"02"]) {
            header = [self headerToAdress:fromAddress format:@"02"];
            packetToSend = [NSMutableData dataWithData:header];
            NSData *payload = [self dataFromHexString:@"0a 01 01 0a b1 01 9d bf 67 01 08 06 00 09 00 00 00 5d 00 01 00 05 00 01 00 00 00 1b 00 0a 00 00 00"];
            [packetToSend appendData:payload];
            NSLog(@"%@", packetToSend);
            //[packetArray insertObject:packetToSend atIndex:count-1];
            [socket sendData:packetToSend toHost:[self IPAddressFromHexString:fromAddress] port:3010 withTimeout:-1 tag:1];
        }
    }
    
    // Rule #5
    if ([format isEqualToString:@"01"]) {
        header = [self headerToAdress:fromAddress format:@"02"];
        packetToSend = [NSMutableData dataWithData:header];
        NSData *payload = [self dataFromHexString:@"0a 01 01 0a b1 01 9d bf 67 01 08 06 00 09 00 00 00 5d 00 01 00 05 00 01 00 00 00 1b 00 0a 00 00 00"];
        [packetToSend appendData:payload];
        NSLog(@"%@", packetToSend);
        //[packetArray insertObject:packetToSend atIndex:count-1];
        [socket sendData:packetToSend toHost:[self IPAddressFromHexString:fromAddress] port:3010 withTimeout:-1 tag:1];
    }
    
    if ([format isEqualToString:@"2B"]) {
        header = [self headerToAdress:fromAddress format:@"2c"];
        packetToSend = [NSMutableData dataWithData:header];
        NSString *packetString = [NSString stringWithFormat:@"0a 01 01 0a %@ 01 00 ff 01 00 00", port];
        NSData *payload = [self dataFromHexString:packetString];
        [packetToSend appendData:payload];
        NSLog(@"%@", packetToSend);
        //[packetArray insertObject:packetToSend atIndex:count-1];
        [socket sendData:packetToSend toHost:[self IPAddressFromHexString:fromAddress] port:3010 withTimeout:-1 tag:1];
        
        header = [self headerToAdress:fromAddress format:@"51"];
        packetToSend = [NSMutableData dataWithData:header];
        packetString = [NSString stringWithFormat:@"01 %@ 2200801f01083031303130303031020331393107 0e 4a414b45414e4444414e49454c4c4c", port];
        payload = [self dataFromHexString:packetString];
        [packetToSend appendData:payload];
        NSLog(@"%@", packetToSend);
        //[packetArray insertObject:packetToSend atIndex:count-1];
        [socket sendData:packetToSend toHost:[self IPAddressFromHexString:fromAddress] port:3010 withTimeout:-1 tag:1];
    }
    
    if ([format isEqualToString:@"0A"]) {
        header = [self headerToAdress:fromAddress format:@"0b"];
        packetToSend = [NSMutableData dataWithData:header];
        NSData *payload = [self dataFromHexString:@"0a 01 01 0a 01 01 bf000000010a060c000000"];
        [packetToSend appendData:payload];
        NSLog(@"%@", packetToSend);
        //[packetArray insertObject:packetToSend atIndex:count-1];
        [socket sendData:packetToSend toHost:[self IPAddressFromHexString:fromAddress] port:3010 withTimeout:-1 tag:1];
        
    }
    
}

- (void)dial:(NSString *)extension {
    NSData *header;
    NSString *toAddress;
    if ([extension isEqualToString:@"1095"]) {
        toAddress = @"10.1.1.216";
        header = [self headerToAdress:@"0a0101d8" format:@"29"];
        port = @"05";
    } else if ([extension isEqualToString:@"1092"]) {
        toAddress = @"10.1.1.216";
        header = [self headerToAdress:@"0a0101d8" format:@"29"];
        port = @"02";
    } else if ([extension isEqualToString:@"191"]) {
        toAddress = @"10.1.1.16";
        header = [self headerToAdress:@"0a010110" format:@"29"];
        port = @"01";
    } else if ([extension isEqualToString:@"198"]) {
        toAddress = @"10.1.1.16";
        header = [self headerToAdress:@"0a010110" format:@"29"];
        port = @"08";
    } else {
        NSLog(@"Not an extension");
        return;
    }
    NSMutableData *packet = [NSMutableData dataWithData:header];
    NSString *packetString = [NSString stringWithFormat:@"0a 01 01 0a %@ 01 00 00 00 00 00 00", port];
    NSData *payload = [self dataFromHexString:packetString];
    [packet appendData:payload];
    //[packetArray insertObject:packet atIndex:count-1];
    NSLog(@"%@", packet);
    [socket sendData:packet toHost:toAddress port:3010 withTimeout:-1 tag:1];
}

#pragma mark - Private

- (NSData *)headerToAdress:(NSString *)address format:(NSString *)format {
    NSMutableData *header = [[NSMutableData alloc] init];
    NSData *toAddress = [self dataFromHexString:address];
    [header appendData:toAddress];
    NSData *fromAddress = [NSData dataWithBytes:kFromAddressByteArray length:4];
    [header appendData:fromAddress];
    [header appendData:[self sizeFromFormat:format]];
    [header appendData:[self dataFromHexString:format]];
    [header appendData:[NSData dataWithBytes:&count length:1]];
    count++;
    uint8_t sep[] = {0xff, 0xff, 0xff, 0xff};
    [header appendData:[NSData dataWithBytes:sep length:4]];
    return header;
}

- (NSData *)sizeFromFormat:(NSString *)format {
    if ([format isEqualToString:@"29"]) {
        uint8_t arr[] = {0x1c,0x00};
        return [NSData dataWithBytes:arr length:2];
    } else if ([format isEqualToString:@"12"]) {
        uint8_t arr[] = {0x11,0x00};
        return [NSData dataWithBytes:arr length:2];
    } else if ([format isEqualToString:@"02"]) {
        uint8_t arr[] = {0x31,0x00};
        return [NSData dataWithBytes:arr length:2];
    } else if ([format isEqualToString:@"2c"]) {
        uint8_t arr[] = {0x1b,0x00};
        return [NSData dataWithBytes:arr length:2];
    } else if ([format isEqualToString:@"0b"]) {
        uint8_t arr[] = {0x21,0x00};
        return [NSData dataWithBytes:arr length:2];
    } else if ([format isEqualToString:@"51"]) {
        uint8_t arr[] = {0x36,0x00};
        return [NSData dataWithBytes:arr length:2];
    }
    NSLog(@"Unsupported format!!!!!!!!!!");
    exit(1);
    return nil;
}

- (NSData *)dataFromHexString:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSAssert(0 == string.length % 2, @"Hex strings should have an even number of digits (%@)", string);
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [string length]/2; i++) {
        byte_chars[0] = [string characterAtIndex:i*2];
        byte_chars[1] = [string characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    return commandToSend;
}

- (NSString *)hexStringFromData:(NSData *)data {
    NSUInteger capacity = data.length * 2;
    NSMutableString *sbuf = [NSMutableString stringWithCapacity:capacity];
    const unsigned char *buf = data.bytes;
    NSInteger i;
    for (i=0; i<data.length; ++i) {
        [sbuf appendFormat:@"%02lX", (unsigned long)buf[i]];
    }
    return sbuf;
}

- (NSString *)IPAddressFromHexString:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *ipAddress = [NSMutableString string];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [string length]/2; i++) {
        byte_chars[0] = [string characterAtIndex:i*2];
        byte_chars[1] = [string characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [ipAddress appendString:[NSString stringWithFormat:@"%i.", whole_byte]];
    }

    return [ipAddress substringToIndex:ipAddress.length - 1];
}

@end
