# DigiMindReady

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

DigiMindReady: Enhancing Military Readiness through Edge AI-Driven Wellness, Education, and Digital Discipline through Privacy-First mHealth Innovation

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Background](#background)
- [Functionality](#functionality) 
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Framework & Design](#framework--design)
- [Contributions](#contributions)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Background

Military personnel often need to operate in high-stakes situations. Combating such volatile missions primarily includes control over cognitive overload, reckless mindset, and maintaining concentration amid distractions to sustain operational effectiveness. Military training significantly focuses on human performance, which benefits military readiness. However, the 21st century has introduced unanticipated challenges, such as adverse effects of excessive screen time, external distractions, and over-reliance on technology to the US military, on top of existing issues like anxiety and emotional stability, adversely impacting military readiness and decreasing quality of life. A strategic investigation into these issues and the advancement of effective tools to address these challenges in the military context are called for to improve digital mind readiness. 

This research introduces DigiMindReady, a mobile health (mHealth) application pioneered to counteract these effects through edge AI-driven personalized features, education, and digital discipline innovations. DigiMindReady proposes a tailored solution that operates entirely offline to ensure security, featuring a collection of functionalities to promote digital wellness, enhance learning, and maintain operational readiness without compromising security. The app's main features include personalized wellness recommendations, a digital education hub, screen time management, and a digital rewards system to encourage healthy digital habits.


## Functionality
An iOS prototype of the DigiMindReady mHealth system designed specifically for military personnel to:
* Enhance operational readiness through digital wellness and emotional resilience
* Promote healthy screen habits and personalized wellness routines
* Deliver secure, AI-powered support for cognitive, emotional, and physical well-being
* Function entirely offline to ensure data privacy and meet military cybersecurity standards
* Address the digital discipline gap by balancing screen time and educational engagement


## Features

* [x] **Human Performance Advocator**: AI-driven guidance for sleep improvement, physical activity, and emotional self-regulation
  * [x] **Personalized Sleep Advocator**: Tailored sleep recommendations based on user data and habits, collected locally or via wearables
  * [ ] **Dynamic Activity Advocator**: Personalized and team-based physical and mental activity suggestions, adapted to military environments
  * [ ] **Self-Regulation Advocator**: Interactive emotional intelligence training and decision-making support through chatbot guidance
* [x] **EduScreen Repository**: Offline digital hub offering wellness education, cognitive games, and a digital bookshelf
  * [x] **Digital Bookshelf**: Educational articles, videos, infographics, and audiobooks to build digital wellness awareness
  * [x] **Cognitive Game Suite**: Brain-training games to enhance memory, attention, and problem-solving skills
  * [ ] **Educational Push**: Timely reminders to engage with learning materials and cognitive content
* [x] **Screen Time Tracking & Management**: Empower users with tools to monitor screen time, enforce quality usage, adhere to guidelines, set personal goals, and recognize addictive patterns
* [ ] **Digital Reward System**: Achievement-based rewards (badges, trophies, exclusive content) to motivate healthy digital habits


## Requirements

| Requirement            | Details                                          |
|------------------------|--------------------------------------------------|
| Platform               | iOS 17.0+                                        |
| Swift Version          | Swift 5.10                                       |
| Xcode Version          | Xcode 16.0+                                      |
| Supported Architectures| arm64, x86_64 (Simulator)                        |
| Dependency Managers    | Swift Package Manager                            |
| Third-Party Services   | -                                                |
| Contribution Guidelines| [Contribution Guide](#contributions)             |


### App Development Environment
* IDE and Code Editor: Xcode
* Core programming language: Swift
* UI Frameworks: UIKit & SwiftUI
* Dependency manager: Swift Package Manager
* Version control system: Git
* Backend Infrastructure: Self Hosted Cloud Infrastructure
* Hardware: Mac computer


## Installation

This section provides instructions on setting up the project on your local development environment.

### Step 1: Clone the Repository

Clone the project repository to your local machine by running the following command in the terminal:

```bash
git clone https://github.com/mehediy/DigiMindReady.git
cd DigiMindReady
```

### Step 2: Setting Up the Project in Xcode
1. **Open the Project**: After cloning the repository, open the .xcodeproj file in Xcode:
2. **Install Dependencies**: Xcode should automatically fetch the dependencies with Swift Package Manager. If it doesn't, you can manually fetch and update the packages by navigating to: `Xcode > File > Swift Packages > Update to Latest Package Versions`

### Step 3:  Configuring Signing and Provisioning
Each target in the project (main app and extensions) requires specific signing and provisioning settings:
1. **Select the Team**: In Xcode's General tab for each target, select the appropriate team from the "Team" dropdown.
2. **Manage Signing**:
   - **Automatic**: For automatic signing, check "Automatically manage signing" and ensure the correct team is selected.
   - **Manual**: For manual signing, uncheck "Automatically manage signing" and select the specific provisioning profiles for each target, aligned with their bundle identifiers and capabilities.

### Step 4: Run the Project
Select your target device or simulator from the Xcode toolbar. Then, press the Run button (▶) to build and run the project.

### Step 5: Configure Personalized Sleep Advocator
To configure the Personalized Sleep Advocator, navigate to AI Advocator > Sleep Advocator > ⋮ (Three Dots) > Settings. You can set up the model by either importing a pre-downloaded lightweight LLM (e.g., qauntized version to fit within iPhone's RAM) from Hugging Face saved in your iPhone’s Files, or by downloading a compatible model directly from the app’s settings menu.

## Dependencies

DigiMindReady depends on the following libraries:

- [llama.cpp](https://github.com/ggml-org/llama.cpp)
- [ggml](https://github.com/ggml-org/ggml) 
- [LLMFarm](https://github.com/guinmoon/LLMFarm)
- [swiftui-2048](https://github.com/eleev/swiftui-2048)
- [DateHelper](https://github.com/melvitax/DateHelper)

DigiMindReady uses these free resources materials 
- [The Art of War audiobook](https://librivox.org/the-art-of-war-by-sun-tzu)
- [The Fundamentals of Military Readiness](https://sgp.fas.org/crs/natsec/R46559.pdf)
- [Study on Effects of Sleep Deprivation](https://health.mil/Reference-Center/Reports/2021/02/26/Study-on-Effects-of-Sleep-Deprivation-on-Readiness-of-Members-of-the-Armed-Forces-Final-Report)


## Framework & Design

Taxonomy of Military Readiness

<img width="710" alt="image" src="https://github.com/mehediy/DigiMindReady/Previews/Taxonomy.png">

Military Digital Health Readiness mHealth Application System Framework

<img width="710" alt="image" src="https://github.com/mehediy/DigiMindReady/Previews/Framework.png">

User Interface Flow: Authentication, Personalization Quiz, and Home Screen

<img width="710" alt="image" src="https://github.com/mehediy/DigiMindReady/Previews/UIFlow.png">

EduScreen Repository Overview: Digital Education and Wellness Hub

<img width="710" alt="image" src="https://github.com/mehediy/DigiMindReady/Previews/EduScreenRepository.png">

Illustrations of Screen Time Tracking and Management by DigiMindReady

<img width="710" alt="image" src="https://github.com/mehediy/DigiMindReady/Previews/ScreenTime.png">

AI Advocator, Sleep Advocator, The Profile and Digital Reward sections by DigiMindReady

<img width="710" alt="image" src="https://github.com/mehediy/DigiMindReady/Previews/AIAdvocator.png">



## Contributions
Your contributions are appreciated! Here's how you can help:

1. **Fork** the repository.
2. **Create** a new branch: `git checkout -b feature/your-feature-name`.
3. **Commit** your changes: `git commit -am 'Add some feature'`.
4. **Push** to the branch: `git push origin feature/your-feature-name`.
5. **Open** a pull request.

Thank you for supporting DigiMindReady!



## Troubleshooting
- Ensure all targets have the correct signing team and provisioning profiles, especially if using manual signing.
- For issues related to dependency fetching, verify your internet connection and the configuration of Swift Package Manager within Xcode.

Feel free to report any issues or ask for help by opening an issue on GitHub.



## License

DigiMindReady is released under Apache License 2.0. [See LICENSE](https://github.com/mehediy/DigiMindReady/blob/main/LICENSE) for details.
