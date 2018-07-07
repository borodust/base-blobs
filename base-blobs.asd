(asdf:defsystem base-blobs
  :author "Pavel Korolev"
  :description "Base system foreign library collection"
  :license "MIT"
  :defsystem-depends-on (:bodge-blobs-support)
  :class :bodge-blob-system
  :libraries (((:darwin :x86-64) "libc++.1.dylib" "x86_64/")
              ((:darwin :x86) "libc++.1.dylib" "x86/")
              ((:unix (:not :darwin) :x86-64) "libstdc++.so.6" "x86_64/")
              ((:unix (:not :darwin) :x86) "libstdc++.so.6" "x86/")
              ((:windows :x86-64) "libwinpthread-1.dll" "x86_64/")
              ((:windows :x86-64) "libgcc_s_seh-1.dll" "x86_64/")
              ((:windows :x86-64) "libstdc++-6.dll" "x86_64/")
              ((:windows :x86) "libwinpthread-1.dll" "x86/")
              ((:windows :x86) "libgcc_s_seh-1.dll" "x86/")
              ((:windows :x86) "libstdc++-6.dll" "x86/")))
