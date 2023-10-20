# Compiler settings
CC = gcc
CFLAGS = -Wall -Wextra -O2
LIBS = -lSDL2 -lSDL2_ttf
OUT = text-to-img

# Docker image names
DOCKER_IMG_NAME1 = text-to-img
DOCKER_IMG_NAME2 = plantuml

# Compile the main application
$(OUT): src/text-to-img.c
	$(CC) $(CFLAGS) src/text-to-img.c -o $(OUT) $(LIBS)

# Remove compiled binaries
clean:
	rm -f $(OUT)

# Build the text-to-img Docker image
docker-text-to-img:
	docker build -f docker/Dockerfile-text-to-img -t ${DOCKER_IMG_NAME1} .
	docker image ls ${DOCKER_IMG_NAME1}

# Build the PlantUML Docker image
docker-plantuml:
	docker build -f docker/Dockerfile-plantuml -t ${DOCKER_IMG_NAME2} .
	docker image ls ${DOCKER_IMG_NAME2}

# Specifying phony targets to prevent conflicts
.PHONY: clean docker-text-to-img docker-plantuml
