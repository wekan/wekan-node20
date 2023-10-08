# Linux x64
deno compile --target x86_64-unknown-linux-gnu --output wekan-deno-linux-x64 main-deno.js

# Linux arm64
#deno compile --target aarch64-unknown-linux-gnu --output wekan-deno-linux-arm64 main-deno.js

# Windows x64
deno compile --target x86_64-pc-windows-msvc --output wekan-deno-windows-x64.exe main-deno.js

# Mac arm64
deno compile --target aarch64-apple-darwin --output wekan-deno-mac-arm64 main-deno.js

# Mac x64
deno compile --target x86_64-apple-darwin --output wekan-deno-mac-x64 main-deno.js
