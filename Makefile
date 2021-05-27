build: libs/libwebrtc-m87.aar
	docker run \
	  -v "$$PWD":/src/build:rw \
	  -v "$$PWD/build":/src/build/build:rw \
	  -v "$${ANDROID_HOME:-$$HOME/android}":/usr/local/lib/android:ro \
	  -v "$$HOME/.android":/opt/android:ro \
	  -v "$$PWD/build-scratch":/root \
	  -e "ANDROID_SDK_ROOT=/usr/local/lib/android" \
	  snikket-builder assembleConversationsFreeCompatDebug

build-image:
	docker build -f docker/Dockerfile -t snikket-builder docker

libs/libwebrtc-m87.aar:
	test -d libs || mkdir libs
	wget -O "$@" "https://gultsch.de/files/$(@F)"

signing.properties:
	echo "keystore=/opt/android/snikket-ci-android.keystore" > "$@"
	echo "keystore.alias=ci-signing-key" >> "$@"
	echo "keystore.password=$(APK_SIGNING_KEY_PASSWORD)" >> "$@"

.PHONY: build build-image
