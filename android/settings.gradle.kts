pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        // Add this repository to allow downloading the NUNAV SDK dependency
        maven { url = uri("https://artifactory.graphmasters.net/artifactory/libs-release") }
    }
}

rootProject.name = "NUNAV SDK Example"
include(":app")
 