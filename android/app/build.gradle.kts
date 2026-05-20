import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Load key.properties
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}


android {
    namespace = "com.care.pooch"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.care.pooch"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {

        create("dev") {
            storeFile = file(keystoreProperties["storeFileDev"] as String)
            storePassword = keystoreProperties["storePasswordDev"] as String
            keyAlias = keystoreProperties["keyAliasDev"] as String
            keyPassword = keystoreProperties["keyPasswordDev"] as String
        }

        create("prod") {
            storeFile = file(keystoreProperties["storeFileProd"] as String)
            storePassword = keystoreProperties["storePasswordProd"] as String
            keyAlias = keystoreProperties["keyAliasProd"] as String
            keyPassword = keystoreProperties["keyPasswordProd"] as String
        }
    }

    flavorDimensions += "app"

    productFlavors {
        create("dev") {
            dimension = "app"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            signingConfig = signingConfigs.getByName("dev")
        }
        create("alpha") {
            dimension = "app"
            applicationIdSuffix = ".alpha"
            versionNameSuffix = "-alpha"
            signingConfig = signingConfigs.getByName("dev") // share dev key
        }
        create("prod") {
            dimension = "app"
            // no suffix for production
            signingConfig = signingConfigs.getByName("prod")
        }
    }

    buildTypes {

        getByName("debug") {
            signingConfig = signingConfigs.getByName("dev")
        }
        
        getByName("release") {
            signingConfig = signingConfigs.getByName("prod")
            isMinifyEnabled = true 
            isShrinkResources = true
        }
    }
}


dependencies {

    // 🔥 Firebase BOM (IMPORTANT)
    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))

    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-analytics")

    // ⚡ Required for Java 8+ APIs used by Firebase / Google Sign-In
    // coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    implementation("com.google.firebase:firebase-messaging") // 👈 ADDED THIS FOR NOTIFICATIONS
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
