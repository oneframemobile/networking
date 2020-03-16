
# networking

[![support](https://img.shields.io/badge/platform-flutter%7Cflutter%20web%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/flutterchina/dio)

Http client for Dart also Flutter. Networking supports Serilazation, Global Configuration, Learning, Timeout etc.

## Get started

### Add dependency

```yaml
dependencies:
  networking: x #latest version
```

### Requirement

1. We define global configiration class.
2. If you have complex scenario, you can define Learning class.
3. And finally define model class but you dont't forget model class must be extends Serialable Object or List

# Index


* Introduction
* Getting Started
* Parse
* Requesting
* GET
* POST
* PUT
* Properties
* Advanced
* Learning
* Manager
* Configuration
* URL
* Connection Timeout
* Headers
* SSL Pinning

## Introduction

Framework supports a networking component that works with a variety of networking providers. This article shows how to use Framework networking component API
in your code.

## Getting Started

Following lines need to be added in pubspec.yaml. Make sure to call ``get dependencies`` command.

```
pubspec.yaml
```
```
dependencies:
networking:
path: /networking
git:
url: http://bellatrix:8080/tfs/ArgeMimariCollection/OneFrameCross/_git/Networking
```
## Parse

Each request or response body must implement SerializationObject<T> or SerializationList<T>. So that it can be mappable from JSON to Model or vice versa.

```
class MyResponse implements SerializableObject<MyResponse> {
String username;
```
```
MyResponse.fromJsonMap(Map<String, dynamic> map) : username = map["username"];
```
```
Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['username'] = username;
return data;
}
```
```
@override
MyResponse fromJson(Map<String, dynamic> json) {
return MyResponse.fromJsonMap(json);
}
}
```

```
class MyResponseList implements SerializableList<MyResponse> {
@override
List<MyResponse> list;
```
```
@override
List<MyResponse> fromJsonList(List json) {
return json.map((fields) => MyResponse.fromJsonMap(fields)).toList();
}
```
```
@override
List<Map<String, dynamic>> toJsonList() {
throw new UnsupportedError("Not needed");
}
}
```
## Requesting

These requests need no configuration. Designed for quick usage.

### GET

Result type is ResultModel<dynamic> as default.

```
NetworkManager manager = NetworkingFactory.create();
manager
.get<PostResponse, ReqResInError>(
url: "https://jsonplaceholder.typicode.com/posts",
type: new PostResponse(),
asList: true,
error: new ReqResInError(),
asList: true,
listener: new NetworkListener()
..onSuccess((dynamic result) {
print("hello");
})
..onError((dynamic error) {
print("world");
}))
.fetch();
```
### POST

Parsing given model to concrete object. Also error model must be defined. Aware of called function which is named post.

```
NetworkManager manager = NetworkingFactory.create();
manager
.post<RegisterRequest, RegisterResponse, ReqResInError>(
url: "https://reqres.in/api/register",
body: request,
type: new RegisterResponse(),
listener: new NetworkListener()
..onSuccess((dynamic result) {
print("success");
})
..onError((dynamic error) {
print("fail");
}))
.fetch();
```

### PUT

```
NetworkManager manager = NetworkingFactory.create();
manager
.put<User, NoResponse, ReqResInError>(
url: "https://reqres.in/api/register",
body: request,
type: new RegisterResponse(),
listener: new NetworkListener()
..onSuccess((dynamic result) {
print("success");
})
..onError((dynamic error) {
print("fail");
}))
.fetch();
```
## Properties

You are able to customize each request with chain methods.

```
await _manager
.post<RegisterRequest, RegisterResponse, ReqResInError>(
url: "https://reqres.in/api",
body: request,
type: new RegisterResponse(),
listener: new NetworkListener()
..onSuccess((dynamic result) {
print("success");
})
..onError((dynamic error) {
print("fail");
}))
.path("register")
.query("userId", "10")
.addHeader(new Header("My", "Header"))
.timeout(new Duration(mins : 1))
.setContentType("application/json")
.fetch();
```
## Advanced

Advanced implementation lets you to change behavior. By implementing learning module you can define success and error cases, or you can customize custom error
codes like 400~500. Manager class will be declared which effects url, header and timeout values in all the other requests.

### Learning

Following example demonstrates scenario likewise isSucceed is true. Custom error codes are added for fail cases. CheckCustomError function will be called whenever
HTTP error codes comes like 400, 401 and etc.


```
Learning
```
```
class MyLearning extends NetworkLearning {
@override
void checkCustomError(NetworkListener listener, ErrorModel error) {
// TODO: implement checkCustomError
}
```
```
@override
void checkSuccess(NetworkListener listener, ResultModel result) {
try {
if (result.data.errorMessage == null) {
sendSuccess(listener, result);
} else {
ErrorModel<String> error = new ErrorModel();
error.description = "Hata!";
sendError(listener, error);
}
} on NoSuchMethodError catch (e) {
print(e.toString());
}
}
}
```
Then you can use manager instance for following operations.

```
MyLearning _learning = new Learning();
NetworkManager manager = NetworkingFactory.create(learning: _learning);
```
### Configuration

Config class is kind of parameters class for managers.

```
NetworkConfig _config = new NetworkConfig();
config.setBaseUrl("www.google.com");
NetworkManager manager = NetworkingFactory.create(config: _config);
```
This one shows how to add base URL.

### Connection Timeout

Connection timeouts are critical for slow network cases. Make sure implement them.

```
NetworkConfig _config = new NetworkConfig();
config.setTimeout(60000);
NetworkManager manager = NetworkingFactory.create(config: _config);
```
### Headers

You can set default headers for every request that created from manager with given config.


```
NetworkConfig _config = new NetworkConfig();
_config
.addHeader(new Header("hello", "wold"))
.addHeader(new Header("its a new", "world"));
```
```
_config.addHeaders([
Header("CompanyId", "1"),
Header("UserId", "2"),
]);
```
```
_config
.addHeaderWithParameters("Nice", "Easy")
.addHeaderWithParameters("John", "Doe");
```
```
NetworkManager manager = NetworkingFactory.create(config: _config);
```
### SSL Pinning

You can use certificates which has .cer extension. Make sure put your .cer file in assets resource folder.

```
SecurityContext _context = new SecurityContext();
context.setTrustedCertificates(file);
HttpClient _client = new HttpClient(context: _context);
```
```
NetworkManager manager = NetworkingFactory.create(client: _client);
```

