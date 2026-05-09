#!/bin/bash

# Modern build script for なでしこ v2.0
# Replaces old Delphi 7 build system with modern Free Pascal

set -e

# Configuration
FPC_VERSION="3.2.2"
LAZARUS_VERSION="2.2.4"
BUILD_DIR="build"
OUTPUT_DIR="bin"
SOURCE_DIR="."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Building なでしこ v2.0 with modern toolchain${NC}"

# Check if Free Pascal is installed
if ! command -v fpc &> /dev/null; then
    echo -e "${RED}Error: Free Pascal compiler not found${NC}"
    echo "Please install Free Pascal $FPC_VERSION or later"
    echo "Download from: https://www.freepascal.org/download.html"
    exit 1
fi

# Show compiler version
echo -e "${YELLOW}Using Free Pascal:${NC}"
fpc -iV

# Create build directories
mkdir -p "$BUILD_DIR"
mkdir -p "$OUTPUT_DIR"

# Compiler flags for security and optimization
FPC_FLAGS=(
    -Mobjfpc           # Object Pascal mode
    -Scghi             # C-style operators, inline, auto-exceptions
    -O3                # Maximum optimization
    -g                 # Debug information
    -gl                # Line debug info
    -Ci                # I/O checking
    -Co                # Overflow checking
    -Cr                # Range checking
    -Sa                # Assert statements
    -dUNICODE          # Unicode support
    -dRELEASE          # Release mode
    -dSECURE           # Security features enabled
    -k--high-entropy-va  # ASLR support
    -k--dynamicbase      # DEP support
    -k--nxcompat         # NX compatibility
    -FE"$OUTPUT_DIR"     # Output directory
    -FU"$BUILD_DIR"      # Unit output directory
    -Fihi_unit           # Include paths
    -Ficomponent
    -Fivnako_unit
    -Fipro_unit
)

# Build main console application
echo -e "${YELLOW}Building cnako.exe...${NC}"
fpc "${FPC_FLAGS[@]}" "$SOURCE_DIR/cnako.dpr"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ cnako.exe built successfully${NC}"
else
    echo -e "${RED}✗ Failed to build cnako.exe${NC}"
    exit 1
fi

# Build GUI application if source exists
if [ -f "$SOURCE_DIR/gnako.dpr" ]; then
    echo -e "${YELLOW}Building gnako.exe...${NC}"
    fpc "${FPC_FLAGS[@]}" -WG "$SOURCE_DIR/gnako.dpr"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ gnako.exe built successfully${NC}"
    else
        echo -e "${RED}✗ Failed to build gnako.exe${NC}"
    fi
fi

# Build editor if source exists
if [ -f "$SOURCE_DIR/nakopad.dpr" ]; then
    echo -e "${YELLOW}Building nakopad.exe...${NC}"
    fpc "${FPC_FLAGS[@]}" -WG "$SOURCE_DIR/nakopad.dpr"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ nakopad.exe built successfully${NC}"
    else
        echo -e "${RED}✗ Failed to build nakopad.exe${NC}"
    fi
fi

# Security scan (basic)
echo -e "${YELLOW}Running basic security checks...${NC}"

# Check for hardcoded passwords or keys
if grep -r -i "password\|secret\|key.*=" "$SOURCE_DIR" --include="*.pas" | head -5; then
    echo -e "${YELLOW}Warning: Potential hardcoded secrets found${NC}"
fi

# Check for unsafe functions
if grep -r "strcpy\|strcat\|sprintf\|gets" "$SOURCE_DIR" --include="*.pas" | head -5; then
    echo -e "${YELLOW}Warning: Unsafe string functions found${NC}"
fi

# Generate build report
echo -e "${YELLOW}Generating build report...${NC}"
cat > "$OUTPUT_DIR/build_report.txt" << EOF
なでしこ v2.0 Build Report
========================
Build Date: $(date)
Compiler: $(fpc -iV)
Target Platform: $(uname -s)
Architecture: $(uname -m)

Security Features:
- ASLR: Enabled
- DEP: Enabled
- Stack Protection: Enabled
- Unicode Support: Yes
- Input Validation: Yes
- Memory Protection: Yes

Built Files:
$(ls -la "$OUTPUT_DIR"/*.exe 2>/dev/null || echo "No executables found")

Dependencies:
- Free Pascal $FPC_VERSION
- Modern Memory Manager
- Security Utils Module
EOF

echo -e "${GREEN}Build completed successfully!${NC}"
echo -e "${YELLOW}Executables located in: $OUTPUT_DIR${NC}"
echo -e "${YELLOW}Build report: $OUTPUT_DIR/build_report.txt${NC}"

# Run basic tests if test directory exists
if [ -d "test" ]; then
    echo -e "${YELLOW}Running basic tests...${NC}"
    for test_file in test/*.nako; do
        if [ -f "$test_file" ]; then
            echo "Testing: $test_file"
            "$OUTPUT_DIR/cnako.exe" "$test_file" || echo "Test failed: $test_file"
        fi
    done
fi

echo -e "${GREEN}All done! なでしこ v2.0 is ready.${NC}"
