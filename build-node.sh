echo "Note: Only one .js file can be included. This does not include npm packages."

### https://nodejs.org/dist/latest-v20.x/docs/api/single-executable-applications.html

echo '{ "main": "main.js", "output": "sea-prep.blob" }' > sea-config.json

node --experimental-sea-config sea-config.json

# On systems other than Windows:
cp $(command -v node) wekan-node-linux-x64

# On Windows
#node -e "require('fs').copyFileSync(process.execPath, 'wekan-node-windows-x64.exe')"

# Remove signature of the binary on macOS only:
#codesign --remove-signature wekan-node-mac-arm64

# Remove signature of the binary on Windows only (optional):
# - with signtool from https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/
#signtool remove /s hello.exe

# On Linux
npx postject wekan-node-linux-x64 NODE_SEA_BLOB sea-prep.blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2

# On Windows - PowerShell:
#npx postject hello.exe NODE_SEA_BLOB sea-prep.blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2

# On Windows - Command Prompt:
#npx postject hello.exe NODE_SEA_BLOB sea-prep.blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2

# On macOS:
#npx postject hello NODE_SEA_BLOB sea-prep.blob \
#    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
#    --macho-segment-name NODE_SEA

# Sign binary on macOS:
#codesign --sign - wekan-node-mac-arm64

# Sign binary on Windows, optional:
#signtool sign /fd SHA256 hello.exe

# Run binary on systems other than Windows
#./wekan-node-linux-amd64

# Run binary on Windows
#.\wekan-node-windows-x64.exe

echo "Note: Only one .js file can be included. This does not include npm packages."

