# Salesforce-Project-Demo

Salesforce projects covering Apex, LWC, integrations, Salesforce Files, and Git/GitHub.

## Projects


### 1. Salesforce SOQL Smart Assistant

**Branch:** `feature/SOQL-Smart-Assistant`

An AI-powered Salesforce tool that converts user requirements written in simple English into SOQL queries using Gemini AI.

**Key Components:**
- `soqlAssistant` (LWC)
- `SoqlQueryController` (Apex)
- `SoqlGeneratorController` (Apex)

**Technologies:**
- Lightning Web Components (LWC)
- Apex
- SOQL
- Gemini AI API
- Salesforce Named Credentials

## Setup
### 1. Clone Repository
```bash
git clone https://github.com/rohankza/Salesforce-Project-Demo.git
cd Salesforce-Project-Demo
```

### 2. Create Feature Branch
```bash
git switch -c feature/my-feature
```

### 3. Salesforce Login

```bash
sf org login web
sf config set target-org=your-org@example.com
```

### 4. Deploy Metadata
```bash
sf project deploy start
```

### 5. Git Workflow
```bash
git add .
git commit -m "Added new feature"
git push -u origin feature/my-feature
```

## Branches
* `main` – Main branch
* `feature/PDFGenerator` – PDF Viewer
* `feature/rs/docusign` – DocuSign Integration
* `feature/train-Live-Status` – Train Live Status API

## Author
Rohan sharma

**Rohan Sharma**
