# Salesforce-Project-Demo

Salesforce projects covering Apex, LWC, integrations, Salesforce Files, and Git/GitHub.

## Projects

### 1. PDF Generator / Viewer
**Branch:** `feature/PDFGenerator`
Retrieves Salesforce Files related to an Account and displays PDF files using Apex and LWC.
**Key Components:**
* `AccountFileViewerController`
* `pdfViewer`
* ContentDocument
* ContentVersion
* ContentDocumentLink

### 2. DocuSign Integration
**Branch:** `feature/rs/docusign`
Demonstrates Salesforce integration with DocuSign for sending documents, tracking envelope status, and storing signed documents in Salesforce.
**Technologies:**
* Apex
* LWC
* Named Credential
* External Credential
* DocuSign API

### 3. Train Live Status
**Branch:** `feature/train-Live-Status`
Calls an external train-status API from Apex and displays train details in an LWC.
**Technologies:**
* Apex HTTP Callout
* JSON
* LWC
* REST API

### 4. Salesforce SOQL Smart Assistant

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
