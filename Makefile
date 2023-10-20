# Compiler settings
CC = gcc
CFLAGS = -Wall -Wextra -O2
LIBS = -lSDL2 -lSDL2_ttf
OUT = text-to-bmp

# Docker image names
DOCKER_IMG_NAME1 = text-to-bmp
DOCKER_IMG_NAME2 = plantuml

# Compile the main application
$(OUT): src/text-to-bmp.c
	$(CC) $(CFLAGS) src/text-to-bmp.c -o $(OUT) $(LIBS)

# Remove compiled binaries
clean:
	rm -f $(OUT)

# Build the text-to-bmp Docker image
docker-text-to-bmp:
	docker build -f docker/Dockerfile-text-to-bmp -t ${DOCKER_IMG_NAME1} .
	docker image ls ${DOCKER_IMG_NAME1}

# Build the PlantUML Docker image
docker-plantuml:
	docker build -f docker/Dockerfile-plantuml -t ${DOCKER_IMG_NAME2} .
	docker image ls ${DOCKER_IMG_NAME2}

# Specifying phony targets to prevent conflicts
.PHONY: clean docker-text-to-bmp docker-plantuml
