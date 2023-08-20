# Linux x64
deno compile main.js --target x86_64-unknown-linux-gnu
mv wekan-node20 wekan-linux-x64

# Windows x64
deno compile main.js --target x86_64-pc-windows-msvc
mv wekan-node20.exe wekan-windows-x64.exe

# Mac arm64
deno compile main.js --target aarch64-apple-darwin
mv wekan-node20 wekan-mac-arm64

# Mac x64
deno compile main.js --target x86_64-apple-darwin
mv wekan-node20 wekan-mac-x64


