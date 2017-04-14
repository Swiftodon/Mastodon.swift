.PHONY: ios
ios:
	TOOLCHAINS=com.apple.dt.toolchain.Swift_3_1 carthage bootstrap --platform ios --no-use-binaries
