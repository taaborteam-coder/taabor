# Windows Build Guide

## Prerequisites

Building for Windows requires specific C++ tools and SDKs that may not be present in all environments.

1. **Visual Studio 2022**: Install "Desktop development with C++" workload.
2. **Agora SDK**: The video calling feature (`agora_rtc_engine`) requires the Iris SDK DLLs to be in the `windows/` folder or system path.
    - If you encounter `IRIS_INCLUDE_DIR` errors, you need to manually download the Agora Windows SDK and configure `windows/CMakeLists.txt`.

## Build Command

```powershell
flutter build windows
```

## Known Issues

- If the build fails due to `agora_rtc_engine`, you may need to temporarily comment out video call features for the Windows build context or define `IRIS_INCLUDE_DIR` in your environment variables.
