    signingConfigs{
        release {
            storeFile file('../mca_jks/apk-key.jks')
            storePassword "2willpass"
            keyAlias "key0"
            keyPassword "2willpass"
        }
        debug {
            storeFile file('../mca_jks/debug_key.jks')
            storePassword 'androiddebugkeypassword'
            keyAlias 'androiddebugkey'
            keyPassword 'androiddebugkeypassword'
        }
    }