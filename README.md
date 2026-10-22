# DocuSign Integration for Salesforce — AppExchange Packaging Guide

## Overview

This guide explains how to package existing Salesforce components into a Second-Generation Managed Package (2GP) and prepare the application for distribution through Salesforce AppExchange.

The existing project contains Salesforce metadata, including Apex classes, Lightning Web Components (LWC), custom objects, and related components.

## 1. Verify Existing Salesforce Components

Ensure the existing Salesforce source code is available in the project directory.

```text
Salesforce-Project-Demo/
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/
│           ├── lwc/
│           ├── objects/
│           └── ...
├── sfdx-project.json
└── README.md
```

Verify the project:

```bash
sf project list
sf org list
```

Check `sfdx-project.json` and confirm that the correct package directory and namespace configuration are present.

## 2. Configure the Salesforce Dev Hub

1. Open Salesforce Setup.
2. Enable Dev Hub in the intended packaging org.
3. Register and configure the namespace required for the managed package.
4. Authorize the Dev Hub using Salesforce CLI.

```bash
sf org login web --alias Demo --set-default-dev-hub
```

Verify authentication:

```bash
sf org display --target-org Demo
sf org list
```

## 3. Create a Managed 2GP Package

Create the package from the existing Salesforce source:

```bash
sf package create --name "DocuSign Integration" --package-type Managed --path force-app --target-dev-hub Demo
```

Save the generated package ID.

If the package already exists, use the existing package ID instead of creating another package.

## 4. Create a Package Version

Create an installable snapshot of the existing components:

```bash
sf package version create --package <PACKAGE_ID> --installation-key-bypass --wait 30 --target-dev-hub Demo
```

Record the package version creation request ID returned by the command.

Check its status:

```bash
sf package version create report --package-create-request-id <08c_REQUEST_ID> --target-dev-hub Demo
```

List the package versions:

```bash
sf package version list --packages <PACKAGE_ID> --target-dev-hub Demo
```

Record the subscriber package version ID beginning with `04t`.

## 5. Validate and Test the Package

Install the package in a separate test org:

```bash
sf package install --package <04t_VERSION_ID> --target-org TestOrg --wait 30
```

Verify the installation:

```bash
sf package installed list --target-org TestOrg
```

Test all packaged components, permissions, authentication configuration, and application functionality.

Run Apex tests and confirm the required code coverage. Before distribution, review the managed package requirements, including the 75% Apex coverage minimum and coverage for every Apex trigger.

## 6. Release the Package Version

After successful testing, promote the eligible package version:

```bash
sf package version promote --package <04t_VERSION_ID> --target-dev-hub Demo
```

Only promote a version that is ready for distribution. Review the installation-key configuration and other release requirements before releasing the package.

## 7. Connect the Package to AppExchange

1. Sign in to Salesforce Partner Community.
2. Open the Partner Console.
3. Complete the applicable partner onboarding requirements.
4. Link the Dev Hub org to the Partner Console as required.
5. Open **Technologies → Solutions**.
6. Verify that the released managed 2GP package is available.
7. Open the existing AppExchange listing.
8. Select **Link Your Solution** and associate the appropriate package version.

For managed 2GP, linking the Dev Hub to the Partner Console makes eligible released package versions available to the publishing workflow.

## 8. Complete Security Review

1. Review Apex, LWC, authentication, and authorization.
2. Run Salesforce Code Analyzer.
3. Fix applicable security findings.
4. Prepare installation instructions and documentation.
5. Document the application's data flow and DocuSign API usage.
6. Submit the required security review materials when eligible.
7. Resolve review findings and obtain approval.

## 9. Complete and Publish the Listing

1. Complete the listing description, highlights, support information, and pricing.
2. Confirm the correct package and released version are linked.
3. Complete the required partner and business approvals.
4. Complete the required security review.
5. Submit the listing through the available Partner Console workflow.
6. Verify public availability and test the customer installation process.

## Important Notes

- Existing components must be included in the package directory and supported by the package configuration.
- Creating a package does not automatically create a released version.
- Creating a package version does not automatically release or publish it.
- Only eligible released package versions can be distributed through AppExchange.
- Public listing publication requires the applicable partner, security, and listing approvals.
- Never commit DocuSign credentials, access tokens, or client secrets to the repository.



