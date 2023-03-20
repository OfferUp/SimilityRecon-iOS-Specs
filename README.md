# SimilityRecon-iOS-Specs

## How to re-package the SimilityRecon binary to support ARM64 Simulator

Details can be found <https://bogo.wtf/arm64-to-sim.html>
Tool used <https://github.com/bogo/arm64-to-sim>

Prerequisites:
Build locally arm64-to-sim tool

```bash
git clone git@github.com:bogo/arm64-to-sim.git
cd arm64-to-sim
swift build -c release --arch arm64 --arch x86_64
```

This will output the executable into the `.build/apple/Products/Release` directory.
Save absolute path to the executable.

Steps:

1. Dowload the target version SimilityRecon binary

```bash
wget https://storage.googleapis.com/simility-beacon-bins/ios/ios_recon_v1.614.zip
```

1. Unzip the binary

```bash
unzip ios_recon_v1.614.zip
cd ios_recon_v1.614
```

1. List current architectures

```bash
lipo -info libSimilityRecon.a
```

1. For each architecture, extract the archive file and store it in a separate file

```bash
lipo libSimilityRecon.a -thin armv7 -output libSimilityRecon-armv7.a
lipo libSimilityRecon.a -thin armv7s -output libSimilityRecon-armv7s.a
lipo libSimilityRecon.a -thin i386 -output libSimilityRecon-i386.a
lipo libSimilityRecon.a -thin x86_64 -output libSimilityRecon-x86_64.a
lipo libSimilityRecon.a -thin arm64 -output libSimilityRecon-arm64.a
```

1. unarchive the arm64 file into new folder `arm64`

```bash
mkdir arm64
cd arm64
ar -x ../libSimilityRecon-arm64.a
```

1. Convert all the object files to arm64 simulator

```bash
for file in *.o; do path/to/arm64-to-sim $file; done;
```

1. Archive the converted files into new archive file

```bash
ar crv ../libSimilityRecon-arm64-sim.a *.o
```

1. Create a new archive file with all the architectures

```bash
cd ..
rm libSimilityRecon.a
lipo -create libSimilityRecon-armv7.a libSimilityRecon-armv7s.a libSimilityRecon-i386.a libSimilityRecon-x86_64.a libSimilityRecon-arm64-sim.a -output libSimilityRecon.a
```

1. Verify the new archive file

```bash
lipo -info libSimilityRecon.a
```

1. Create a new zip file with the new archive file

```bash
zip -r ios_recon_v1.614_arm64_sim.zip libSimilityRecon.a SimilityRecon.h
```

1. Cleanup

```bash
mv ios_recon_v1.614_arm64_sim.zip ../
cd ..
rm -rf ios_recon_v1.614
rm ios_recon_v1.614.zip
```

1. Upload the new zip file to the github release page

```bash
gh release create v1.614 -t "v1.614" -n "v1.614"
gh release upload v1.614 ios_recon_v1.614_arm64_sim.zip
```
