# GoFast iOS - GitHub Actions Build Guide

Build your iOS IPA in the cloud without owning a Mac!

## Quick Start

### Step 1: Create GitHub Repository

```bash
cd gofast-ios
git init
git add .
git commit -m "Initial commit"
```

### Step 2: Push to GitHub

1. Go to https://github.com/new
2. Create a new repository (can be private)
3. Follow the push instructions:

```bash
git remote add origin https://github.com/YOUR_USERNAME/gofast-ios.git
git branch -M main
git push -u origin main
```

### Step 3: Trigger the Build

**Option A - Automatic:**
- Every push to `main` branch triggers a build

**Option B - Manual:**
1. Go to your repo → **Actions** tab
2. Click **"Build iOS IPA"** workflow
3. Click **"Run workflow"** → **"Run workflow"**

### Step 4: Download the IPA

1. Wait for the build to complete (~5-10 minutes)
2. Click on the workflow run
3. Scroll to **"Artifacts"** section
4. Download **GoFast-Driver** → Contains `GoFast.ipa`

### Step 5: Install on iPhone

**Using eSign:**
1. Download eSign from https://esign.mom/ (Safari on iPhone)
2. Transfer the IPA to iPhone (AirDrop, iCloud, etc.)
3. Open eSign → Import IPA → Sign with your Apple ID → Install

**Using Sideloadly:**
1. Download https://sideloadly.io/ on Mac/Windows
2. Drag the IPA → Enter Apple ID → Connect iPhone → Start

**Using AltStore:**
1. Install AltServer on your computer
2. Set up AltStore on iPhone
3. Import IPA via AltStore

---

## Workflow Details

| Item | Value |
|------|-------|
| Build Time | ~5-10 minutes |
| Cost | Free (GitHub Free tier) |
| iOS Version | Latest stable |
| Xcode Version | Latest on macOS-latest |
| Artifact Retention | 90 days |

---

## Troubleshooting

### Build Fails with "Signing Error"
The free signing works for development. The IPA can be installed via eSign/Sideloadly which handles re-signing.

### "No provisioning profile found"
This is expected. The workflow uses automatic signing. Use eSign or Sideloadly to install.

### Workflow Doesn't Show Up
- Go to Actions tab → Enable workflows if needed
- Check if the workflow file is in `.github/workflows/`

---

## Limits

- **Free tier:** 2000 minutes/month (each build ~10 min = 200 builds/month)
- **Storage:** 500MB artifacts (IPA is ~20-50MB)

---

## Alternative: Direct XCArchive

If IPA export fails, download the **GoFast-Archive** artifact and:
1. Transfer `.xcarchive` to a Mac
2. Right-click → Show Package Contents
3. Or use Sideloadly which accepts xcarchive files
