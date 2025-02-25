#!/bin/bash

PACKAGE_NAME="table"
OUTPUT_DIR="build"

# Define OS and architecture combinations
declare -A targets=(
  ["linux_amd64"]="linux amd64"
  ["linux_arm64"]="linux arm64"
  ["windows_amd64"]="windows amd64"
  ["windows_arm64"]="windows arm64"
  ["darwin_amd64"]="darwin amd64"
  ["darwin_arm64"]="darwin arm64"
)

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through each target and build
for target in "${!targets[@]}"; do
  os=$(echo "${targets[$target]}" | awk '{print $1}')
  arch=$(echo "${targets[$target]}" | awk '{print $2}')

  # Set the GOOS and GOARCH environment variables
  export GOOS="$os"
  export GOARCH="$arch"

  # Determine the output file name
  output_file="$OUTPUT_DIR/$os/$arch/$PACKAGE_NAME"
  if [[ "$os" == "windows" ]]; then
    output_file="$output_file.exe"
  fi

  # Build the application
  echo "Building for $os/$arch"
  go build -o "$output_file" .
done

echo "Build complete!"