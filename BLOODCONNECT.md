# BloodConnect

BloodConnect is a premium Flutter Phase 1 foundation for a donation and health companion. It is intentionally a polished, interactive mock experience: the user journeys work locally, but external services such as identity verification, maps, payments, Firebase storage, and AI analysis are not connected yet.

## Included

- Welcome, onboarding, sign-in, registration, OTP, role selection, and biometric opt-in flows
- Donor dashboard, eligibility pre-check, appointment booking, donation history, badges, and certificates
- Blood-support search, nearby-support map placeholder, emergency SOS coordination, and emergency contacts
- Health-report upload placeholder, easy-to-read mock report analysis, trends, and clear medical disclaimers
- Notifications, edit profile, settings, and light/dark themes
- Responsive Material 3 layout for mobile and wider web/tablet screens
- GitHub Actions workflow that analyses, builds, and deploys the web release to GitHub Pages

## Run locally

Install the latest stable Flutter SDK, then run these commands in this folder:

```bash
flutter pub get
flutter run -d chrome
```

For a production-style browser build:

```bash
flutter build web --release
```

## Publish through GitHub Pages

1. Create an empty GitHub repository named `blood-connect` (or choose another name).
2. Push this project to its `main` branch.
3. In the repository, open **Settings → Pages** and set the source to **GitHub Actions**.
4. The included workflow runs on every push to `main`. Its successful deployment appears at:

   ```
   https://YOUR_GITHUB_USERNAME.github.io/REPOSITORY_NAME/
   ```

The workflow supplies the correct repository base path at build time, so it works for a project page without editing the app.

## GitHub commands

After creating your remote repository, use:

```bash
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/REPOSITORY_NAME.git
git branch -M main
git push -u origin main
```

## Phase 1 boundaries

The app contains mock data only. Before handling real users or health information, implement Firebase authentication and security rules, consent management, secure storage, privacy review, server-side audit logging, verified emergency escalation, and clinician-reviewed AI workflows. AI health output must always remain non-diagnostic.

See the supplied implementation plan for the longer Phase 2–4 roadmap.
