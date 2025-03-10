IMAGE := emrahbillur/sdkmanager-nvidia
TAG   ?= latest

.PHONY: all image lint run

all: image

image:
# If the image build stage causes 403 not found issues please replace the docker build line with the commented below line
#	docker build --no-cache $(ARGS) -t $(IMAGE):$(TAG) .
	docker build $(ARGS) -t $(IMAGE):$(TAG) .


lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

run:
	xhost +
	sudo docker run -it --rm \
	-e WAYLAND_DISPLAY=$(WAYLAND_DISPLAY) --privileged \
        -e DISPLAY=$(DISPLAY) -e XSOCK=$(XSOCK) -e XAUTH=$(XAUTH) \
	--ipc=host -userns=keep-id \
        --volume="$(HOME)/.Xauthority:/root/.Xauthority:rw" \
        --volume="/tmp/.X11-unix/:/tmp/.X11-unix:rw" \
	--user=nvidia:nvidia \
	-v $(pwd)/sdkm_downloads:/home/nvidia/Downloads/nvidia/sdkm_downloads \
        -v /dev/bus/usb:/dev/bus/usb -v /dev:/dev \
	--net=host $(ARGS) \
	$(IMAGE):$(TAG)
	xhost -

#	-v $(XDG_RUNTIME_DIR)/$(WAYLAND_DISPLAY)=/tmp/$(WAYLAND_DISPLAY) \

#	-v /media/$(USER):/media/nvidia:slave -v /dev:/dev\

#	xhost +
#	sudo docker run -it --rm  -e DISPLAY=$DISPLAY -e XSOCK=$XSOCK -e XAUTH=$XAUTH --privileged \
#         --ipc=host -v /dev:/dev \
#	 --volume="$(HOME)/.Xauthority:/root/.Xauthority:rw" \
#	 --volume="/tmp/.X11-unix/:/tmp/.X11-unix:rw" \
#         -v $(pwd)/sdkm_downloads:/home/nvidia/Downloads/nvidia/sdkm_downloads \
#         -v /media/$USER:/media/nvidia:slave \
#                --net=host $(ARGS) \
#		-ti --rm $(IMAGE):$(TAG)
#	xhost -
