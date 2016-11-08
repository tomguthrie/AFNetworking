// AFHTTPOperationSessionManager.m
// Copyright (c) 2016 Leszek S
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFHTTPOperationSessionManager.h"

@interface AFHTTPOperationSessionManager ()
@property (readwrite, nonatomic, strong) NSOperationQueue *requestsOperationQueue;
@end

@implementation AFHTTPOperationSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    
    if (!self) {
        return nil;
    }
    
    self.requestsOperationQueue = [[NSOperationQueue alloc] init];
    self.requestsOperationQueue.maxConcurrentOperationCount = 4;
    
    return self;
}

- (nullable NSOperation *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (nullable NSOperation *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [super GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task, responseObject);
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task, error);
            }
            dispatch_group_leave(dispatchGroup);
        }];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)HEAD:(NSString *)URLString
                    parameters:(nullable id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask *task))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [super HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask *task) {
            if (success) {
                success(task);
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task, error);
            }
            dispatch_group_leave(dispatchGroup);
        }];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE
{
    return [self POST:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (nullable NSOperation *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
                      progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [super POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task, responseObject);
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task, error);
            }
            dispatch_group_leave(dispatchGroup);
        }];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE
{
    return [self POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:success failure:failure];
}

- (nullable NSOperation *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [super POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task, responseObject);
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task, error);
            }
            dispatch_group_leave(dispatchGroup);
        }];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)PUT:(NSString *)URLString
                   parameters:(nullable id)parameters
                      success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [super PUT:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task, responseObject);
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task, error);
            }
            dispatch_group_leave(dispatchGroup);
        }];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)PATCH:(NSString *)URLString
                     parameters:(nullable id)parameters
                        success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [super PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task, responseObject);
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task, error);
            }
            dispatch_group_leave(dispatchGroup);
        }];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)DELETE:(NSString *)URLString
                      parameters:(nullable id)parameters
                         success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [super DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(task, responseObject);
            }
            dispatch_group_leave(dispatchGroup);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(task, error);
            }
            dispatch_group_leave(dispatchGroup);
        }];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)downloadOperationWithRequest:(NSURLRequest *)request
                                              progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                           destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                     completionHandler:(nullable void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [[super downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination
                      completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                          dispatch_group_leave(dispatchGroup);
                          if (completionHandler) {
                              completionHandler(response, filePath, error);
                          }
                      }] resume];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

- (nullable NSOperation *)dataOperationWithRequest:(NSURLRequest *)request
                                    uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                  downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                 completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler
{
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_t dispatchGroup = dispatch_group_create();
        dispatch_group_enter(dispatchGroup);
        [[super dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            dispatch_group_leave(dispatchGroup);
            if (completionHandler) {
                completionHandler(response, responseObject, error);
            }
        }] resume];
        dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    }];
    
    [self.requestsOperationQueue addOperation:operation];
    
    return operation;
}

@end
