# Compiler
CXX = g++
CXXFLAGS = -std=c++17 -Iinclude -Iinclude/imgui -Iinclude/glm -Iinclude/glad

# Source files
SRCS = src/main.cpp src/Camera.cpp src/ShaderProgram.cpp src/Mesh.cpp src/Texture2D.cpp include/glad/glad.c
OBJS = src/main.o src/Camera.o src/ShaderProgram.o src/Mesh.o src/Texture2D.o src/glad.o

# Output directory and executable
BIN_DIR = bin
TARGET = $(BIN_DIR)/main

# Libraries
LIBS_MAC = -L/opt/homebrew/lib -lSDL2 -lSDL2_image

# Platform detection
ifeq ($(OS),Windows_NT)
    PLATFORM_LIBS = -Llib -lmingw32 -lSDL2main -lSDL2 -lSDL2_image
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        PLATFORM_LIBS = -Llib `pkg-config --libs sdl2 SDL2_image`
    else ifeq ($(UNAME_S),Darwin)
        PLATFORM_LIBS = $(LIBS_MAC)
    endif
endif


# Build target
$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $(OBJS) $(PLATFORM_LIBS) -o $(TARGET)

# Compile source files into object files
src/%.o: src/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

src/glad.o: include/glad/glad.c
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean up
clean:
	rm -f $(TARGET) $(OBJS)
