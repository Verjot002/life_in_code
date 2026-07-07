# Verjot Heer - Flutter Developer Portfolio Website & App

This is a premium, highly responsive, and animated portfolio website and cross-platform mobile application built in Flutter for **Verjot Heer**, Mobile Application Developer. It features a tech-themed cyber/obsidian design system with custom-painted interactive particles, smooth transitions, a complete education timeline, a project catalog, and an active project inquiry form.

## Features

- **Responsive Design**: Adapts beautifully to desktop browsers, tablets, and mobile screens.
- **Interactive Particle System**: A custom-drawn Canvas background with glowing floating nodes that react to mouse hover movements.
- **Animated Interface**: Floating nav bars with glassmorphism (backdrop blurs), typing text headers, hover-zoom card interactions, and status transitions.
- **Dynamic Project Inquiry Form**: A validation-capable form with name, email, project category chips, budget selectors, and custom details.
- **Production-Ready**: Configured for simple deployment to free hosts.

---

## Local Setup

### Prerequisites

Ensure you have Flutter SDK installed (tested on Flutter 3.41.7).

### Running Locally

1. Fetch dependencies:
   ```bash
   flutter pub get
   ```
2. Run the application (select Chrome for web testing or a mobile simulator):
   ```bash
   flutter run
   ```

---

## Configuring the Contact Form (Formspree Integration)

By default, the contact form uses a simulated network delay and transitions into a successful submission state. To make it submit actual emails to you for free:

1. Sign up for a free account at [Formspree](https://formspree.io/).
2. Create a new form (e.g., named "Portfolio Contact Form") and copy the 8-character Form ID (e.g., `xpwaqvrd`).
3. Open [contact_section.dart](lib/widgets/contact_section.dart).
4. Locate the variable:
   ```dart
   final String _formspreeId = "YOUR_FORMSPREE_ID";
   ```
5. Replace `"YOUR_FORMSPREE_ID"` with your actual Formspree ID:
   ```dart
   final String _formspreeId = "xpwaqvrd";
   ```
6. Build and deploy! All inquiries will now go directly to your personal email.

---

## Free Domain Hosting Deployment Guide

### Option 1: GitHub Pages (Recommended - Completely Free)

GitHub Pages provides free hosting at `<username>.github.io/<repo-name>`.

1. **Build the Web Bundle**:
   Run the following command to compile a production-ready web build:
   ```bash
   flutter build web --release --base-href "/life_in_code/"
   ```
   *(Note: Replace `/life_in_code/` with your exact repository name on GitHub. If you are deploying to the main username repository e.g. `<username>.github.io`, use `/` instead.)*

2. **Initialize Git and Commit**:
   ```bash
   git init
   git add .
   git commit -m "feat: initial commit of portfolio app"
   ```

3. **Deploy using the `gh-pages` branch**:
   A simple tool like `peanut` or Git subtree can deploy the `build/web` folder to a `gh-pages` branch:
   - Install `peanut` (a Flutter tool for web deployment):
     ```bash
     dart pub global activate peanut
     ```
   - Run peanut to build and push the web directory to a local branch named `gh-pages`:
     ```bash
     peanut
     ```
   - Push to your remote repository:
     ```bash
     git push origin gh-pages
     ```
4. **Enable GitHub Pages**:
   Go to your GitHub repository -> **Settings** -> **Pages**. Under "Build and deployment", select the branch `gh-pages` and folder `/root`, then click Save. Your site will be live shortly!

---

### Option 2: Firebase Hosting (Free Subdomains `.web.app` / `.firebaseapp.com`)

1. **Install Node.js & Firebase CLI**:
   (Ensure Node.js is installed on your machine)
   ```bash
   npm install -g firebase-tools
   ```
2. **Login and Initialize**:
   ```bash
   firebase login
   firebase init hosting
   ```
   - Select **Create a new project** or **Use an existing project**.
   - What do you want to use as your public directory? Enter: `build/web`
   - Configure as a single-page app? Enter: `Yes`
   - Set up automatic builds and deploys with GitHub? Enter: `No` (or Yes if desired).
3. **Build the project**:
   ```bash
   flutter build web --release
   ```
4. **Deploy**:
   ```bash
   firebase deploy
   ```
   Firebase will give you a live URL like `https://<your-project-id>.web.app`!
