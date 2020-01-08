include properties.mk

appName = `grep entry manifest.xml | sed 's/.*entry="\([^"]*\).*/\1/'`
devices = `grep 'iq:product id' manifest.xml | sed 's/.*iq:product id="\([^"]*\).*/\1/'`
JAVA_OPTIONS = JDK_JAVA_OPTIONS="--add-modules=java.xml.bind"

build:
	cat ./monkey.jungle ./barrels.jungle > ./build.jungle &&\
	$(SDK_HOME)/bin/monkeyc \
	--jungles ./build.jungle \
	--output bin/$(appName).prg \
	--device $(DEVICE) \
	--private-key $(PRIVATE_KEY) \
	--warn &&\
	rm ./build.jungle

buildall:
	cat ./monkey.jungle ./barrels.jungle > ./build.jungle
	@for device in $(devices); do \
		echo "-----"; \
		echo "Building for" $$device; \
    $(SDK_HOME)/bin/monkeyc \
		--jungles ./build.jungle \
		--device $$device \
		--output bin/$(appName)-$$device.prg \
		--private-key $(PRIVATE_KEY) \
		--warn; \
	done
	rm ./build.jungle

run: build
	$(SDK_HOME)/bin/connectiq &
	sleep 3 
	$(SDK_HOME)/bin/monkeydo bin/$(appName).prg $(DEVICE)

deploy: build
	@cp bin/$(appName).prg $(DEPLOY)

package:
	cat ./monkey.jungle ./barrels.jungle > ./build.jungle
	@$(SDK_HOME)/bin/monkeyc \
	--jungles ./build.jungle \
	--package-app \
	--release \
	--output bin/$(appName).iq \
	--private-key $(PRIVATE_KEY) \
	--warn
	rm ./build.jungle
