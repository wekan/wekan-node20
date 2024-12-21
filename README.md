## FerretDB

Related:
- OpLog: https://docs.ferretdb.io/configuration/oplog-support/
  - https://github.com/FerretDB/FerretDB/issues/76
- Achieve compatibility with WeKan
  - https://github.com/FerretDB/FerretDB/issues/1752
- Improve compatibility with real specific apps and libraries
  - https://github.com/FerretDB/FerretDB/issues/5 
- High level Roadmap to end of Q4 2024:
  - https://github.com/orgs/FerretDB/projects/2/views/1
  - There is "No Stage" mention of Change Streams as a wish sometime:
    - https://github.com/FerretDB/FerretDB/issues/175


#### 1) Starting this FerretDB/SQLite with:

```
git clone https://github.com/wekan/wekan-node20

cd wekan-node20

docker compose up -d
```

#### 2) Manually create oplog collection:

```
mongosh

use local

db.createCollection('oplog.rs', { capped: true, size: 536870912 })
```

#### 3) Build wekan:

```
git clone https://github.com/wekan/wekan

cd wekan

./rebuild-wekan.sh

1

./rebuild-wekan.sh

2

./rebuild-wekan.sh

3
```

#### 4) Edit start-wekan.sh have these settings for oplog:

```
cd .build/bundle

export MONGO_OPLOG_URL=mongodb://127.0.0.1:27017/local?replicaSet=rs0&authSource=admin

export MONGO_URL=mongodb://127.0.0.1:27017/wekan

export ROOT_URL=http://localhost:2000

export PORT=2000

node main.js

cd ..
```

#### 5) Start wekan bundle:

```
./start-wekan.sh
```

#### 6) Look that there is something at oplog:

```
mongosh

use local

db.oplog.rs.countDocuments()

db.oplog.rs.find()
```

#### 7) Look what has been able to write to database:

```
mongosh

use wekan

show collections

db.boards.countDocuments()

db.boards.find()

db.cards.find()
```

#### 8) Currently working is:

- Registering new user at https://localhost:2000/sign-up
- Login at https://localhost:2000/sign-in
- Add new user at right top username / Admin Panel / People / People

#### 9) Currently not working is:

- Adding attachments related collections to GridFS
- Adding new board, errors about matchElement and userId
#    

#### Later, try to fix to create oplog at start:

docker-compose.yml
```
ferretdb-sqlite-setup:
 image: ghcr.io/ferretdb/all-in-one
 restart: no
 depends_on:
   - ferretdb-sqlite
 entrypoint: [ "bash", "-c", "sleep 10 && /usr/bin/mongosh --host ferretdb-postgresql:27017 --eval 'use local;db.createCollection('oplog.rs', { capped: true, size: 536870912 });'"]
```

## Node.js, Bun and Deno tests

#### Description of this database connecting test

- main.js runs database connecting test to:
  - MongoDB 3.x
  - MongoDB 6.x
  - FerretDB PostgreSQL
  - FerretDB SQLite
- At package.json is many packages, that are also used at https://github.com/wekan/wekan
- main.js and npm packages are compiled to single executeables with Bun and Deno.
  - Not possible yet with Node.js, because Node.js can not yet include npm packages to executeable.
- This test is to see, what works at each CPU/OS. This is only database connect test, not yet any other features.

#### Code differences between Node.js, Bun and Deno

- Only difference is, how to do imports. Other Javascript code is exactly same in Node.js 20, Bun and Deno.
- Node.js and Bun use this syntax for imports at `main.js` https://github.com/wekan/wekan-node20/blob/main/main.js#L7-L9

```
// Node.js and Bun imports using package.json
const { MongoClient } = require("mongodb");
const { MongoClient: MongoClientLegacy } = require("mongodb-legacy");
```

- Deno uses different syntax for imports at `main-deno.js` https://github.com/wekan/wekan-node20/blob/main/main-deno.js#L2-L4

```
// Deno imports using deno.json
import { MongoClient } from "mongodb";
import { MongoClient as MongoClientLegacy } from "mongodb-legacy";
```

#### WeKan Node.js 20, Bun and Deno

- SE = Single Executeable at https://github.com/wekan/wekan-node20/releases
- Runs = Does run, but no Single Executeable

Features | Node.js 20 | Bun | Deno | Details
------------ | ------------- | ------------- | ------------- | -------------
Single Executeable | [No](https://nodejs.org/dist/latest-v20.x/docs/api/single-executable-applications.html). Can not include npm modules yet. | [Yes](https://bun.sh/docs/bundler/executables) | [Yes](https://docs.deno.com/runtime/manual/tools/compiler). Deno can crosscompile some binaries. |
Production use | Yes, has [traceability](https://changelog.com/jsparty/294) and [many CPU/OS](https://nodejs.org/dist/) | No | No | 
Linux amd64 | Runs | SE 92.1 MB | SE 365 MB. "Node.js compatibility layer" [includes Node.js](https://changelog.com/jsparty/294), so binaries are bigger. |
Linux arm64 | Runs | SE 84.4 MB | SE 1.35 GB [Too big size is bug](https://github.com/denoland/deno/issues/1846) | https://github.com/wekan/wekan/wiki/Raspberry-Pi
Linux s390x | 20 Runs. [14 has Segmentation fault](https://github.com/wekan/wekan/issues/5142#issuecomment-1740573924) | [No](https://github.com/oven-sh/bun/issues/2632) | [No](https://github.com/denoland/deno/issues/20212) | https://github.com/wekan/wekan/wiki/s390x
Windows amd64 | Runs | No | SE 324 MB | https://github.com/wekan/wekan/wiki/Offline
Mac amd64 | Runs | No. "Your shell is running in Rosetta 2. Downloading bun for darwin-aarch64 instead" | SE 348 MB | https://github.com/wekan/wekan/wiki/Mac
Mac arm64 | Runs | SE 49.9 MB | SE 345 MB | https://github.com/wekan/wekan/wiki/Mac

#### Trying to compile LLVM (for Zig and Bun) at s390x fails

- There is no precompiled binaries of Zig and Bun https://github.com/oven-sh/bun/issues/2632
- Trying: [Compile LLVM](https://github.com/ziglang/zig/wiki/How-to-build-LLVM,-libclang,-and-liblld-from-source#release), to [compile Zig](https://github.com/ziglang/zig/wiki/Building-Zig-From-Source#instructions), to [compile Bun](https://bun.sh/docs/project/development).
- Trying to compile LLVM (for Zig and Bun) ends with this error at s390x VM that has 8 GB RAM:

```
    inlined from ‘std::__cxx11::basic_string<_CharT, _Traits, _Allocator>& std::__cxx11::basic_string<_CharT, _Traits, _Alloc>::_M_replace(size_type, size_type, const _CharT*, size_type) [with _CharT = char; _Traits = std::char_traits<char>; _Alloc = std::allocator<char>]’ at /usr/include/c++/12/bits/basic_string.tcc:532:22,
    inlined from ‘std::__cxx11::basic_string<_CharT, _Traits, _Alloc>& std::__cxx11::basic_string<_CharT, _Traits, _Alloc>::replace(size_type, size_type, const _CharT*, size_type) [with _CharT = char; _Traits = std::char_traits<char>; _Alloc = std::allocator<char>]’ at /usr/include/c++/12/bits/basic_string.h:2179:19,
    inlined from ‘std::__cxx11::basic_string<_CharT, _Traits, _Alloc>& std::__cxx11::basic_string<_CharT, _Traits, _Alloc>::insert(size_type, const _CharT*) [with _CharT = char; _Traits = std::char_traits<char>; _Alloc = std::allocator<char>]’ at /usr/include/c++/12/bits/basic_string.h:1936:22,
    inlined from ‘std::__cxx11::basic_string<_CharT, _Traits, _Allocator> std::operator+(const _CharT*, __cxx11::basic_string<_CharT, _Traits, _Allocator>&&) [with _CharT = char; _Traits = char_traits<char>; _Alloc = allocator<char>]’ at /usr/include/c++/12/bits/basic_string.h:3549:36,
    inlined from ‘virtual void {anonymous}::UnsafeBufferUsageReporter::handleUnsafeVariableGroup(const clang::VarDecl*, const clang::DefMapTy&, clang::UnsafeBufferUsageHandler::FixItList&&)’ at /home/linux1/repos/llvm-project-17/clang/lib/Sema/AnalysisBasedWarnings.cpp:2255:36:
/usr/include/c++/12/bits/char_traits.h:435:56: warning: ‘void* __builtin_memcpy(void*, const void*, long unsigned int)’ accessing 9223372036854775810 or more bytes at offsets [2, 9223372036854775807] and 1 may overlap up to 9223372036854775813 bytes at offset -3 [-Wrestrict]
  435 |         return static_cast<char_type*>(__builtin_memcpy(__s1, __s2, __n));
      |                                        ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
[3640/4949] Building CXX object tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o
FAILED: tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o
/usr/bin/c++ -DGTEST_HAS_RTTI=0 -D_DEBUG -D_GLIBCXX_ASSERTIONS -D_GNU_SOURCE -D_LIBCPP_ENABLE_HARDENED_MODE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -I/home/linux1/repos/llvm-project-17/build-release/tools/clang/lib/ASTMatchers/Dynamic -I/home/linux1/repos/llvm-project-17/clang/lib/ASTMatchers/Dynamic -I/home/linux1/repos/llvm-project-17/clang/include -I/home/linux1/repos/llvm-project-17/build-release/tools/clang/include -I/home/linux1/repos/llvm-project-17/build-release/include -I/home/linux1/repos/llvm-project-17/llvm/include -fPIC -fno-semantic-interposition -fvisibility-inlines-hidden -Werror=date-time -fno-lifetime-dse -Wall -Wextra -Wno-unused-parameter -Wwrite-strings -Wcast-qual -Wno-missing-field-initializers -pedantic -Wno-long-long -Wimplicit-fallthrough -Wno-maybe-uninitialized -Wno-nonnull -Wno-class-memaccess -Wno-redundant-move -Wno-pessimizing-move -Wno-noexcept-type -Wdelete-non-virtual-dtor -Wsuggest-override -Wno-comment -Wno-misleading-indentation -Wctad-maybe-unsupported -fdiagnostics-color -ffunction-sections -fdata-sections -fno-common -Woverloaded-virtual -fno-strict-aliasing -O3 -DNDEBUG  -fno-exceptions -funwind-tables -fno-rtti -UNDEBUG -std=c++17 -MD -MT tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o -MF tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o.d -o tools/clang/lib/ASTMatchers/Dynamic/CMakeFiles/obj.clangDynamicASTMatchers.dir/Registry.cpp.o -c /home/linux1/repos/llvm-project-17/clang/lib/ASTMatchers/Dynamic/Registry.cpp
c++: fatal error: Killed signal terminated program cc1plus
compilation terminated.
[3645/4949] Building CXX object tools/clang/lib/Sema/CMakeFiles/obj.clangSema.dir/SemaCodeComplete.cpp.o
ninja: build stopped: subcommand failed.
```

#### Trying to compile Deno for s390x fails

- There is no ninja_gn binaries for s390x https://github.com/denoland/ninja_gn_binaries
- Rust ring (a crypto dependency) does not support s390x.
- https://github.com/denoland/deno/issues/20212#issuecomment-1756663943

#### Database servers

- FerretDB Linux amd64/armv7/arm64 https://github.com/ferretdb/FerretDB/pkgs/container/ferretdb
- Some not checked yet, does it exist?

Features | MongoDB 3.x | MongoDB 6.x | FerretDB
------------ | ------------- | ------------- | -------------
Linux amd64 | Yes | Yes | Yes
Linux armv7 | ? | No | Yes
Linux arm64 | ? | Yes | Yes
Linux s390x | ? | ? | ?
Windows amd64 | ? | Yes | ?
Mac amd64 | ? | Yes | ?
Mac arm64 | ? | Yes | ?

#### Database drivers at main.js

- MongoDB 3.x, to be compatible with WeKan Snap Stable migrations, and https://sandstorm.io MongoDB 3.0
- MongoDB 6.x, to be compatible with newest Meteor
- FerretDB
  - Website https://www.ferretdb.io
  - FerretDB is MongoDB 6.x wire protocol compatible proxy to PostgreSQL or SQLite. Replaces MongoDB.
  - https://blog.ferretdb.io/ferretdb-v1-10-production-ready-sqlite/
  - Improve compatibility with real specific apps and libraries https://github.com/FerretDB/FerretDB/issues/5
  - FerretDB WeKan issue https://github.com/FerretDB/FerretDB/issues/1752
  - At this repo docker-compose.yml:
    - FerretDB PostgreSQL
    - FerretDB SQLite
- PostgreSQL
- SQLite

#### Database drivers, maybe later

- MySQL
- MSSQL
- Oracle

#### DAL and ORM

- DAL (Database Access Layer) and ORM (Object Relational Mapper)
- Generating database queries from same syntax to many different database syntax
- If using DAL/ORM is improvement, not too much size or slowness added
- Those that also support CloudFlare D1 SQLite database
  - Kysely, at bottom of page https://github.com/wekan/wekan/wiki/WeKan-Multiverse-Roadmap
  - Feathers-kysely
  - Drizzle ORM
  - Or others at https://developers.cloudflare.com/d1/platform/community-projects/
- Or maybe:
  - TypeORM https://www.npmjs.com/package/typeorm
  - Sequelize https://www.npmjs.com/package/sequelize
