pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    // משתמשים במשתנה הפנימי של פלאטר במקום במספר גרסה קשיח
    val agpVersion = providers.gradleProperty("agpVersion").getOrElse("8.1.0")
    id("com.android.application") version agpVersion apply false

    val kotlinVersion = providers.gradleProperty("kotlinVersion").getOrElse("1.8.22")
    id("org.jetbrains.kotlin.android") version kotlinVersion apply false
}

include(":app")