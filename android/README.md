# NUNAV SDK Example Android

## About The Project

To serve as a hands on example, this project will demonstrate the integration and usage of the `Nunav SDK` for Android
via a simple example app.

![Preview](docs/navigation.gif)

## Integration

1. Repository
* Add the following repository to your project's `build.gradle` file:

```
maven { url = uri("https://artifactory.graphmasters.net/artifactory/libs-release") }
```

2. Gradle dependency
* Add the following dependency to your app's `build.gradle` file:

```
implementation("net.graphmasters.multiplatform:nunav-sdk-android:{VERSION}")
```

3. Initialize the NunavSdk with your API-Key. This only needs to happen once and must happen before using the SDK.

```
NunavSdk.init((context, "Your API-key")
```

4. To start the navigation you must pass a destination to the SDK. This can be done by calling the `startNavigation`
   method on the `NunavSdk` instance. Use the `Destination.Builder` to create a destination.

```
NunavSdk.startNavigation(
            context = context,
            destination = Destination.Builder()
                .location(52.0, 9.0)
                .label("My destination")
                .build()
        )
```

## Permissions

For the SDK to work properly, the following permissions must be granted by the user before
calling `NunavSdk.startNavigation`:

* ACCESS_FINE_LOCATION
* ACCESS_COARSE_LOCATION
* ACCESS_FOREGROUND_SERVICE (Android 10+)

## Request an API Key

If you wish to request an API key to use the navigation SDK, please contact us via [Mail](mailto:info@graphmasters.net). We will be happy to provide you with further information on obtaining an API key.

