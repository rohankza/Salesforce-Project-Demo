
# Salesforce Revenue Cloud & CPQ – Learning Topics & Summary
**Updated Date:** October 30, 2026
### Salesforce Revenue Cloud – Dynamic Revenue Orchestrator (DRO) Setup
### 1. Introduction
Dynamic Revenue Orchestrator (DRO) is a Salesforce Revenue Cloud feature used to manage and automate order fulfillment activities after an Order is activated.

It helps businesses manage fulfillment tasks such as sending customer emails, generating delivery requests, shipping products, activating services, and integrating with external systems.

Example: When a customer purchases a Headset, DRO manages the activities required to deliver the product to the customer.
### 2. Prerequisites
Before configuring DRO:
1. Enable Dynamic Revenue Orchestrator in Salesforce Setup.
2. Create the required Product (e.g., Headset).
3. Ensure the product has valid pricing.
4. Create an Order with the required Order Product.
5. Configure the Order page with the Decomposition Details tab.
3. Create Step Definition Group
Navigation: App Launcher → Dynamic Revenue Orchestrator → Fulfillment Workspace.

### Steps:
1. Open Fulfillment Workspace.
2. Create a new Step Definition Group.
3. Enter Name: Headset Fulfillment.
4. Save the record.
Purpose: Step Definition Group is used to organize multiple fulfillment activities under one group.

### Example activities:
- Send Customer Email
- Generate Delivery Request
- Confirm Shipment
4. Create Step Definitions
Create individual Step Definitions for each fulfillment activity.

### Example 1: Send Customer Email
1. Open the Headset Fulfillment group.
2. Create a new Step Definition.
3. Enter Name: Send Customer Email.
4. Configure the appropriate Manual Task type.
5. Assign the task to the required user.
6. Save.
### Example 2: Generate Delivery Request
1. Create another Step Definition.
2. Enter Name: Generate Delivery Request.
3. Configure the required task type.
4. Save.
### Example 3: Confirm Shipment
1. Create another Step Definition.
2. Enter Name: Confirm Shipment.
3. Configure the required task type.
4. Save.
Purpose: Step Definitions specify the individual activities that must be performed during order fulfillment.

Note: Creating a Step Definition alone does not execute the activity. Appropriate task configuration, automation, or integration is required.
5. Create Fulfillment Scenario
Navigation: Dynamic Revenue Orchestrator → Fulfillment Scenarios.

### Steps:
1. Open Fulfillment Scenarios.
2. Click New.
3. Enter Name: Headset Scenario.
4. Select Product: Headset.
5. Select the Step Definition Group: Headset Fulfillment.
6. Configure execution rules if required.
7. Save the record.
Purpose: Fulfillment Scenario connects a product with its required fulfillment process.

### Example:
Product	Fulfillment Scenario
Headset	Headset Scenario
Laptop	Laptop Scenario
Mobile	Mobile Scenario

6. Configure Order Submission Flow
Create a Record-Triggered Flow to automatically submit eligible Orders for fulfillment after activation.

### Steps:
1. Navigate to Setup → Flows.
2. Click New Flow.
3. Select Record-Triggered Flow.
4. Select Object: Order.
5. Configure the trigger when a record is updated.
6. Set Entry Condition: Status = Activated.
7. Add the appropriate Submit Order for Fulfillment Apex Action.
8. Pass the Order ID.
9. Configure synchronous execution as required.
10. Save and Activate the Flow.
Purpose: This Flow automatically submits the activated Order to DRO instead of requiring manual submission.
7. Activate and Submit Order
### Steps:
1. Navigate to Orders.
2. Open the required Order.
3. Add the Headset product as an Order Product.
4. Verify Order pricing.
5. Activate the Order.
6. Submit the Order for fulfillment manually or through the configured Flow.
Purpose: Order submission initiates the fulfillment process for eligible Order Lines.
8. Verify Fulfillment Plan
### Steps:
1. Open the submitted Order.
2. Navigate to Decomposition Details.
3. Check the generated fulfillment information.
4. Open the Fulfillment Plan.
5. Open the Orchestration Plan.
6. Verify the generated fulfillment steps.
Purpose: Fulfillment Plan and Orchestration Plan help track and manage the execution of fulfillment activities.
9. Complete Manual Fulfillment Tasks
### Steps:
1. Open the Orchestration Plan.
2. Find the Send Customer Email task.
3. Perform the required activity manually.
4. Mark the task as Completed.
5. Repeat for other manual tasks.
6. Verify the final fulfillment status.
### Expected Result: Once all required fulfillment activities are completed, the fulfillment process should show Completed.

**Updated Date:** October 29, 2026
1. Revenue Cloud Advanced (RCA)
Provides capabilities for product catalog management, pricing, quoting, and order processing.

2. Revenue Lifecycle Management (RLM)
Manages the customer revenue lifecycle, including contracts, amendments, subscription renewals, and cancellations.

3. Salesforce Billing
Handles billing schedules, invoice generation, credit memos, and related billing processes.

4. Product Bundles
Combines multiple products or services into a single package with required components, optional products, and configuration rules.

5. Transaction Management
Manages business transactions such as quotes, orders, and related commercial records throughout the sales process.

6. Payment Systems Integration
Connects Salesforce with external payment gateways to process payments and track transaction statuses.

**Updated Date:** October 28, 2026
### 1-Product Catalog Configuration and Troubleshooting
### Objective
Troubleshoot products not appearing in Browse Catalog in Salesforce Revenue Cloud Advanced.
### Issue
Newly configured products were not visible in the Browse Catalog screen, even though the products had been created.
Steps Performed
1. Verified that the product was active and correctly configured.
2. Checked the product's catalog and category assignments.
3. Verified the relevant selling model, availability settings, and pricing configuration.
4. Navigated to Product Catalog Management → Index and Search Configuration.
5. Opened the index management section and initiated a Partial Index Rebuild.
6. Monitored the rebuild status in Rebuild History.
7. Reopened the Quote and Transaction Line Editor.
8. Tested Browse Catalog to verify product visibility.
  

### 2-Subscription and Non-Subscription Products

### Objective
Understand how subscription and non-subscription products work in Salesforce Revenue Cloud Advanced and how their Asset records are created and managed.
Steps Performed
1. Created and configured subscription and non-subscription products.
2. Configured the required product details, selling models, and pricing.
3. Added products to the appropriate catalog and category.
4. Created a Quote and added products through Browse Catalog.
5. Created an Order from the Quote and activated the Order.
6. Verified the generated Asset records under the Account's Related tab or the Assets list.
7. Checked product details, quantities, status, and applicable subscription or purchase information.


**Updated Date:** October 23, 2026

# Salesforce Revenue Cloud: Order Activation to Invoice Generation

## Overview

This document explains the end-to-end billing process in Salesforce Revenue Cloud, starting from Order Activation and ending with Invoice Generation and Invoice Posting.

## End-to-End Process Flow

```text
Order
  |
  v
Order Activation
  |
  v
Billing Schedule Groups
  |
  v
Billing Schedules
  |
  v
Billing Batch Scheduler
  |
  v
Invoice Batch Run
  |
  v
Invoice
  |
  v
Invoice Lines
  |
  v
Invoice Posting
```

## 1. Order Activation

### Definition

Order Activation confirms the order and allows configured downstream processes, such as billing schedule generation, to proceed.

### Steps

1. Open the Salesforce App Launcher.
2. Search for and open **Orders**.
3. Open the required Order.
4. Verify the Order Products, quantities, prices, dates, and billing configuration.
5. Verify the required Legal Entity, Billing Treatment, Tax Treatment, and Payment Terms, where applicable.
6. Click **Activate**.

### Expected Result

The Order becomes active. Billing Schedule Groups and Billing Schedules are generated when the required billing configuration and automation are in place.

## 2. Billing Schedule Groups

### Definition

A Billing Schedule Group groups related billing schedules associated with order-related billing transactions.

### Steps

1. Open the App Launcher.
2. Search for **Billing Schedule Groups**.
3. Open the relevant group.
4. Verify its relationship with the Order and associated Billing Schedules.

### Purpose

- Organize related billing schedules.
- Review billing information grouped for processing.
- Help verify the billing records generated from an Order.

## 3. Billing Schedules

### Definition

A Billing Schedule represents a scheduled charge associated with an order product and identifies billing timing and amount information.

### Steps

1. Search for **Billing Schedules** in the App Launcher.
2. Open the schedule related to the Order.
3. Verify the billing amount and billing date.
4. Check the next billing date and status, if available.
5. Confirm that the schedule is eligible for invoice generation.

### Purpose

- Track when charges become eligible for invoicing.
- Track scheduled billing amounts.
- Support recurring and scheduled billing processes.

### Example

| Field                | Example Value               |
| -------------------- | --------------------------- |
| Product              | Printer Maintenance Service |
| Monthly Charge       | ₹1,000                      |
| Billing Period       | Monthly                     |
| Subscription Term    | 12 Months                   |
| Total Contract Value | ₹12,000                     |

*The example assumes one unit billed at ₹1,000 per month for 12 months.*

## 4. Billing Batch Scheduler

### Definition

A Billing Batch Scheduler is used to configure and initiate scheduled billing-related batch processing, including invoice generation through an Invoice Scheduler.

### Steps

1. Open the App Launcher.
2. Search for **Billing Batch Schedulers**.
3. Open an existing scheduler or create a new one.
4. Click **New Invoice Scheduler**, if creating a new scheduler.
5. Enter the scheduler name.
6. Configure the start date and other required scheduling fields.
7. Set the target date and invoice date, when requested.
8. Configure the Invoice Billing Criteria.
9. Select **Start Run Now** for a one-time run, if available and appropriate.
10. Keep automatic invoice posting disabled during initial testing.
11. Save or schedule the configuration.

### Purpose

- Configure invoice processing.
- Define which billing schedules should be considered.
- Initiate invoice generation according to the configured criteria.

## 5. Invoice Batch Run

### Definition

An Invoice Batch Run records an execution of the invoice generation process.

### Steps

1. Open the required Billing Batch Scheduler.
2. Navigate to the **Related** tab.
3. Open **Invoice Batch Runs**.
4. Open the latest batch run.
5. Check its status and processing details.
6. Review error logs if the run fails.

### Purpose

- Monitor invoice generation.
- Review batch processing status.
- Investigate errors and confirm whether invoices were generated.

### Important

A `Completed` status indicates that the batch run completed. It does not, by itself, prove that an invoice was generated. Verify the invoice count and related invoice records.

## 6. Invoice Generation

### Definition

An Invoice is a financial document that records the amount payable by a customer for products or services.

### Steps

1. Open the completed Invoice Batch Run.
2. Review its generated invoice records, if available.
3. Alternatively, search for **Invoices** in the App Launcher.
4. Open the invoice associated with the relevant customer or transaction.
5. Verify the invoice number, account, invoice date, due date, subtotal, tax, and total amount.
6. Confirm the invoice status.

### Purpose

- Record the customer's payable amount.
- Track invoice dates and payment due dates.
- Support the billing and accounts receivable process.

## 7. Invoice Lines

### Definition

An Invoice Line represents an individual product, service, or charge included in an invoice.

### Steps

1. Open the generated Invoice.
2. Navigate to the **Related** tab.
3. Open **Invoice Lines**.
4. Verify the product or charge name.
5. Check quantity, unit price, line amount, and tax information, where applicable.
6. Confirm that the line amounts reconcile with the invoice total.

### Example

| Invoice Line        |      Amount |
| ------------------- | ----------: |
| Printer Maintenance |     ₹10,000 |
| Premium Support     |      ₹2,000 |
| Subtotal            |     ₹12,000 |
| Example Tax at 18%  |      ₹2,160 |
| **Total Invoice**   | **₹14,160** |

*Amounts and tax rates are illustrative only.*

## 8. Invoice Posting

### Definition

Invoice Posting moves an eligible invoice from a draft or unposted state into the posted state according to the organization's billing configuration.

### Steps

1. Open the generated Invoice.
2. Verify the customer, invoice lines, amounts, and dates.
3. Confirm that the invoice is eligible for posting.
4. Use the available **Post** action or the configured posting process.
5. Refresh the record.
6. Verify the final invoice status.

### Purpose

- Finalize the invoice in the billing process.
- Support downstream payment and accounting workflows.
- Maintain a record of posted customer charges.

**Note:** If the scheduler is configured to post invoices automatically, the invoice may already be posted during batch processing.

## 9. Troubleshooting

| Issue                                               | Checks                                                                                 |
| --------------------------------------------------- | -------------------------------------------------------------------------------------- |
| Billing Schedules are not created                   | Verify Order activation and the configured Order-to-Billing-Schedule automation.       |
| Billing Schedule exists but no invoice is generated | Verify schedule eligibility, billing dates, target date, and Invoice Billing Criteria. |
| Invoice Batch Run fails                             | Review the batch run details and associated error logs.                                |
| Batch run completes but no invoice exists           | Check the generated invoice count and confirm that eligible schedules were processed.  |
| Invoice amount is incorrect                         | Verify Order Product pricing, Billing Schedule amounts, and tax configuration.         |
| Invoice remains in Draft                            | Verify the invoice and use the configured posting action if appropriate.               |
| Scheduler is inactive                               | Check scheduler status and configuration before initiating another run.                |

## Summary

The Salesforce Revenue Cloud billing process starts with Order Activation and continues through Billing Schedule generation, Invoice Batch processing, Invoice creation, Invoice Line verification, and Invoice Posting.

Each stage should be verified before proceeding to the next. The exact fields, actions, and automation depend on the Salesforce Revenue Cloud configuration and enabled features in the organization.

**Updated Date:** October 20, 2026
#### 1. Bundle-Based Pricing from Price Adjustment Schedule

Learned how to configure Bundle-Based Pricing in Salesforce Revenue Cloud to apply special pricing to child products when they are sold as part of a bundle.

Scenario
Parent Bundle: Tesla Model X
Child Product: Wheel

Requirement: Apply a 50% discount to the Wheel when sold within the Tesla Model X bundle, while keeping its full price when sold as a standalone product.

### Implementation
Created the bundle product Tesla Model X and its child product Wheel.
Configured the Bundle-Based Adjustment.
Defined the Root Bundle, Parent Product, and Child Product.
Selected the adjustment type and configured the adjustment value.
Tested the pricing behavior for bundle and standalone sales.
Reviewed the Pricing Procedure and Pricing Settings when the adjustment did not work as expected.

### 2. Attribute-Based Pricing

Learned how Attribute-Based Pricing can change product prices based on selected attribute values.

### Key Learning
Configure product attributes that affect pricing.
Set up Attribute-Based Adjustments.
Apply additional charges when a specific attribute value is selected.
Verify attribute-based price changes during product configuration.

### 3. Contract Pricing

Learned how Contract Pricing is used to provide customer-specific negotiated prices and discounts during an agreed contract period.

### Implementation

Created a contract associated with an Account and Opportunity.
Configured Contract Item Pricing for specific products.
Set negotiated prices or discounts and applicable contract dates.
Activated the contract according to the configured lifecycle.
Linked the contract to a quote.
Verified whether the negotiated contract price was applied instead of the standard product price.



**Updated Date:** October 19, 2026

#### 1. Contract Creation from Quote
### Definition: Allows users to create a Contract directly from a Quote using Contract Use Case Mapping.

Why use it? To automate contract creation and transfer the required data from Quote to Contract.

### Steps:
1. Open Contract Use Case Mapping.
2. Create mapping: Quote → Contract.
3. Configure Hydration and Persistence mappings.
4. Create a Quote linked to an Opportunity and Account.
5. Click Create Contract and verify the Contract.

### 2. Contract Pricing
Definition: Allows businesses to define negotiated prices or discounts for specific products or product categories under a Contract.

Why use it? To provide customers with agreed pricing for the contract period, regardless of standard pricing changes, where configured.

### Steps:
1. Open the Contract and set the Start Date, Term, and Price Book.
2. Go to Related → Contract Item Pricing → New.
3. Select Product or Category.
4. Configure a percentage discount, amount discount, or price override.
5. Activate the Contract through the required stages.
6. Refresh relevant Decision Tables if required.
7. Add the product to the Quote and verify the Net Unit Price.
### Example:
Standard price = ₹1,000; contract price override = ₹100. The eligible quote line should use ₹100 as its Net Unit Price.

### Product Configurator Flow – Salesforce Revenue Cloud
### Definition: Product Configurator Flow is a Screen Flow that controls how the product configuration screen appears in Revenue Cloud.

Why use it? To customize the configurator UI, such as changing attribute layouts from one column to two columns, without modifying the standard flow.
### Steps to configure
1. Clone the standard flow: Go to Setup → Flows → search for Default Product Configurator Flow → Save As New Flow.
2. Customize the screen: Open the cloned flow and select the Product Configurator Product Attributes component. Change the Display Column value from 1 to 2.
3. Activate the flow: Save and activate the custom flow.
4. Create a flow configuration: Open Product Configurator Configuration Flows from App Launcher and create a record using the custom flow's API name. Set Status to Active and configure Default as required.
5. Assign the flow: Under Related, create a Product Configuration Flow Assignment record.
6. Select the scope: Choose a specific Product (e.g., Laptop) or a Product Classification to apply the customization to multiple products.
7. Test: Open Browse Catalog, select the product, and verify the updated configurator layout.
Example: Laptop attributes display in two columns, while other products retain the standard one-column layout if the assignment applies only to Laptop.

### Important: Always clone the standard flow instead of modifying it directly.


### Salesforce Revenue Cloud: Product Discovery & Transaction Line Editor
### 1. Product Discovery
Definition: Product Discovery is a tool used to search, browse, filter, and select products from a catalog to add them to a Quote.

Why use it? To help users quickly find the required products and add them to a Quote.

Steps:
1. Open the Quote.
2. Click Browse Catalog.
3. Select the Catalog and Category.
4. Search, filter, or select products.
5. Click Add Selection to Quote.
6. Review the selected products and save the Quote.

### 2. Transaction Line Editor (TLE)
Definition: Transaction Line Editor is the interface where users view, manage, and edit the products added to a Quote.

Why use it? To update product quantities, review pricing, apply adjustments, organize products, and recalculate prices.

### Steps and key features:
1. Add products to the Quote through Product Discovery.
2. Open the Quote Line Editor.
3. Inline Editing: Update eligible fields such as quantity.
4. Instant Pricing: Recalculate pricing immediately when supported and enabled.
5. Freeze Columns: Keep important columns visible while scrolling.
6. Add Group: Group quote lines manually.
7. Group By: Organize lines by fields such as Selling Model Type.
8. Reprice All: Refresh prices and run applicable validations.
9. Bulk Delete: Remove multiple selected quote lines.
10. Quote Summary: Review total price, tax, one-time total, and recurring total.
### Example: 
A user adds an HP Desktop through Product Discovery, then uses TLE to change its quantity from 1 to 2 and recalculate the total price.

**Updated Date:** October 14, 2026

## 1. Constraint Model and Configuration Rules

### Objective
Implemented product configuration constraints to control the available attribute values based on selected product attributes.

### Implementation Steps
1. Enabled **Set Up Configuration Rules and Constraints with Constraints Engine**.
2. Created a configuration rule for the Laptop product.
3. Configured a condition to check whether the product attribute equals `2K Built-in Display`.
4. Applied constraints to hide the `24 inch` and `16 inch` size values when the specified display attribute was selected.
5. Tested the configuration behavior using **Browse Catalog**.

### Outcome
Implemented attribute-based constraints to dynamically control available product configuration options and prevent users from selecting incompatible values.

## 2. Context Definition and Decision Tables

### Objective
Learned how Salesforce Revenue Cloud uses Context Definitions and Decision Tables to provide data for business rules and pricing calculations.

### Implementation and Learning
1. Explored Context Definitions and their role in defining the data available to pricing and configuration logic.
2. Learned how to access source object fields and related object values through the context.
3. Explored Decision Tables to evaluate input conditions and return the corresponding output values.
4. Studied how input and output variables are used in the pricing process.
5. Learned how pricing-related values can be passed to and consumed by the pricing engine.

### Outcome
Gained an understanding of the data flow from source records through Context Definitions and Decision Tables to pricing calculations.

## 3. Ramp Deal and Free Trial Configuration

### Objective
Worked on configuring a subscription-based Ramp Deal that includes a free trial period.

### Implementation
1. Worked with a subscription product having a total term of 36 months.
2. Configured a one-month free trial for the specified product.
3. Explored how the free-trial period fits into the subscription term and the overall pricing structure.

### Example
- **Subscription Term:** 36 months
- **Free Trial:** 1 month
- **Product:** Selected subscription product

### Outcome
Gained practical knowledge of configuring a free-trial period within a longer subscription-based commercial agreement.

## 4. Pricing Procedure Configuration

### Objective
Started configuring a Pricing Procedure to calculate pricing at the Quote Line level in Salesforce Revenue Cloud.

### Implementation Steps
1. Created and configured a Pricing Procedure.
2. Added the required Pricing Element for the pricing calculation.
3. Configured the List Price Element Assignment.
4. Mapped the pricing calculation to the **Net Unit Price** field on the Quote Line.
5. Started working on volume discount configuration to apply discounts based on product quantity.

### Pricing Flow

`Pricing Procedure → Pricing Element → List Price Element Assignment → Net Unit Price`


**Updated Date:** October 13, 2026
1. Attribute Picklist and Product Classification

### Objective

Display different product attributes, such as RAM and Color, in Browse Catalogs for product selection and configuration.

Implementation Steps
Created an Attribute Picklist.
Added the required picklist values, including RAM and Color.
Created a Product Classification.
Associated the Attribute Picklist with the Product Classification.
Configured the product attributes to support product selection in Browse Catalogs.

### Outcome
Configured product attributes to support product selection and display in Browse Catalogs.

### Revenue Cloud – Product Setup to Billing Schedule

### Objective
Configure a product in Salesforce Revenue Cloud and process the order lifecycle, including Order Activation, Contract creation, Asset creation, and Billing Schedule troubleshooting.

Implementation Steps
Created a new product in Salesforce Revenue Cloud.
Configured the Product Selling Model.
Created a Price Book and configured the product pricing.
Assigned the product to the Product Catalog and appropriate Product Category.
Created an Order for the configured product.
Started the Contract creation process and encountered an issue with the Product Subtotal.
Manually populated the required Product Subtotal value to proceed with Contract creation.
Successfully created the Contract.
Created and verified the associated Asset.
Activated the Order to proceed with the order lifecycle.
Worked on Billing Schedule creation and troubleshot the issues encountered during the process.

### Outcome
Configured the product and its selling details, created the Order, Contract, and Asset, activated the Order, and worked on Billing Schedule troubleshooting as part of the Salesforce Revenue Cloud order-to-billing process.


**Updated Date:** October 12, 2026


##  Salesforce Revenue Cloud: Create and Configure a Bundle

### Business Scenario
Create a parent bundle product with child products and make it available in Browse Catalogs.

### Implementation Steps
1. Open the Salesforce Revenue Cloud application.
2. Navigate to the Products or Product Catalog management area.
3. Create the parent bundle product.
4. Create the child products that will be included in the bundle.
5. Open the parent product.
6. Navigate to the **Product Structure** tab.
7. Add the required child products to the parent product structure.
8. Configure the appropriate child-product relationships and required settings.
9. Save the product structure.
10. Navigate to the Catalogs area.
11. Open the relevant catalog or create a new catalog.
12. Create or select the appropriate category.
13. Associate the parent bundle product with the catalog category.
14. Ensure that the product and catalog configuration meet the requirements for publication and availability.
15. Open **Browse Catalogs**.
16. Locate the parent bundle product and verify that it appears in the catalog.
17. Open the bundle and verify that its child products are available for configuration.


## 1. Salesforce CPQ: Bundle Product Discount

### Business Scenario
A Dell laptop bundle contains child products such as a keyboard and mouse.

- When the keyboard is added to the Dell laptop bundle, apply a 50% discount.
- When the keyboard is sold as a standalone product, charge the full price.

### Implementation Steps

1. Navigate to the Salesforce App Launcher and open **Salesforce CPQ**.
2. Open the Products tab and create or select the Dell laptop parent product.
3. Create the keyboard and mouse as child products.
4. Open the Dell laptop product and navigate to the **Related** tab.
5. Create Product Options for the keyboard and mouse.
6. Open the keyboard Product Option record.
7. Enable the **Discounted** checkbox.
8. Set the discount to 50% using the applicable bundle pricing configuration.
9. Save the Product Option.
10. Create a Quote and add the Dell laptop bundle.
11. Configure the bundle and verify that the keyboard receives the 50% discount.
12. Add the keyboard separately to another Quote and verify that its standalone price remains unchanged.

### Expected Result

- Keyboard inside the bundle: 50% discount.
- Keyboard sold separately: Full standalone price.

---

## 2. Salesforce CPQ: Price Rule Based on Quantity

### Business Scenario
When the quantity of a Quote Line Item exceeds 2, automatically apply a 10% discount.

### Implementation Steps

1. Navigate to **Setup → Object Manager → Price Rule** or open the Price Rules tab, depending on your configuration.
2. Create a new Price Rule.
3. Enter the Price Rule Name: `Discount Based on Quantity`.
4. Set **Evaluation Scope** to `Calculator`.
5. Set the appropriate Calculator Evaluation Event, such as `On Calculate`.
6. Create a Price Condition:
   - Tested Object: Quote 
   - Tested Field: SBQQ__LineItemCount__c
   - Operator: Greater Than
   - Filter Value: `2`
7. Create a Price Action:
   - Target Object: Quote Line
   - Target Field: `Discount (%)` or the appropriate discount field for your pricing setup.
   - Value: `10`, according to the target field's expected format.
8. Save and activate the Price Rule.
9. Create a Quote and add a product with a quantity greater than 2.
10. Click **Calculate** and verify the resulting discount.


**Note:** `SBQQ__AdditionalDiscount__c` represents the Additional Discount field. Confirm the field's availability and supported use in your CPQ configuration before using it as a Price Action target.

---

## 3. Salesforce CPQ: Price Rule Based on Product Code

### Business Scenario
Apply a 10% discount when the Product Code is `Dell-01`.

### Implementation Steps

1. Create a new Price Rule named `Discount Based on Product Code`.
2. Set Evaluation Scope to `Calculator`.
3. Set the appropriate Calculator Evaluation Event, such as `On Calculate`.
4. Create a Price Condition:
   - Tested Object: Quote Line
   - Tested Field: Product Code (`SBQQ__ProductCode__c`, if available in your configuration)
   - Operator: Equals
   - Filter Value: `Dell-01`
5. Create a Price Action:
   - Target Object: Quote Line
   - Target Field: Discount (AMT).
   - Value: `10`,
6. Save and activate the Price Rule.
7. Create a Quote and add the Dell product with Product Code `Dell-01`.
8. Click **Calculate**.
9. Verify that the 10% discount is applied.
10. Add another product with a different Product Code and confirm that the rule does not apply.

---

## 4. Salesforce CPQ: Custom Action on Quote Lines

### Business Scenario
Display a custom action button on individual Quote Lines for specific products.

### Implementation Steps

1. Open the Salesforce CPQ **Custom Actions** configuration.
2. Create a new Custom Action.
3. Enter the action name and label.
4. Configure the action's display settings:
   - **Location:** `Line`
   - **Page:** `Quote Line`
5. Configure the action's behavior according to the intended functionality.
6. Save the Custom Action.
7. Open the Quote Line Editor for a Quote.
8. Add the relevant products.
9. Verify that the action appears at the Quote Line level.
10. Test the action on the intended products and confirm that it performs the expected operation.

=============================================================

**Updated Date:** October 8, 2026

1. Product Images on Quote Lines

Implemented a feature to display Product Images directly on the Quote Line UI in Salesforce CPQ.
Implementation
Created the required Formula/URL fields to store and reference the Product Image URL.
Stored Product Images in the Document object.
Configured the images with public access so they can be loaded from the Quote Line UI.
Configured the required Image URL and related fields.
Displayed the respective Product Image against each Quote Line Product.
Outcome

Users can easily view the Product Image directly from the Quote Line UI.

2. Bookmarked/Favorite Product & Product Code
Implemented a Record-Triggered Flow to capture and display the Product Code of bookmarked/favorite products on Quote Lines.
Implementation
Created a Record-Triggered Flow to process bookmarked/favorite products.
Retrieved the related Favorite Product and Quote Line records.
Used a Loop to process the related Quote Lines.
Retrieved the Product Code from the related Product.
Assigned the Product Code to a custom Quote Line field.
Stored and displayed the Product Code on the Quote Line UI.
Outcome

Users can easily identify the Product Code of bookmarked/favorite products directly on Quote Lines.

3. Product Rules & Configuration Rules

Implemented Product Rules and Configuration Rules to automate product selection based on Configuration Attribute values during bundle configuration.
Implementation
Created a Configuration Attribute to capture the user's selection.
Created a Product Rule based on the selected Configuration Attribute value.
Configured the Product Rule to automatically select/add the required Product Option.
Created the required Configuration Rule.
Linked the Configuration Rule with the Product Bundle.
Configured the rule to execute during the Bundle Configuration process.
Example

When a user selects a specific Configuration Attribute value, the Product Rule automatically selects or adds the required product option within the bundle

===========================================

**Updated Date:** October 7, 2026

**Salesforce CPQ – Implemented Scenarios**
I implemented the following scenarios using a Samsung 5G Phone Package bundle:
**Contract Pricing Scenario**
Implemented customer-specific contract pricing where eligible customers receive negotiated pricing for the Samsung 5G Phone.
**Option Constraint Scenario**
Implemented constraints between Premium Support and Standard Support to prevent incompatible options from being selected together.
**Configuration Attribute Scenario**
Implemented RAM, Storage, and Color as configurable attributes so customers can customize the phone during configuration.
**Product Rule Scenario**
Implemented product rules to validate and control product options based on selected RAM, Storage, and Color values.
**Price Rule Scenario**
Implemented dynamic pricing where selecting 16 GB RAM adds $500 to the base phone price.
**Discount Schedule Scenario**
Implemented quantity-based discounts where the discount percentage increases based on the quantity of phones purchased.
**Bundle Configuration Scenario**
Configured the Samsung 5G Phone bundle with 5G SIM Card, Premium Support, and Standard Support, including appropriate selection and dependency rules.




**Updated Date:** September 30, 2026

---

## 1. Percent of Total (POT)

**Summary:**
Learned how Percent of Total pricing works in Salesforce CPQ, where the price of a product is calculated as a percentage of applicable quote line values.

**Key Learning:**

* Configured Percent of Total products.
* Created and configured related POT records.
* Understood how CPQ dynamically calculates percentage-based pricing.
* Learned practical use cases for service, support, and additional charges.

---

## 2. Option Constraints

**Summary:**
Learned how Option Constraints control which products can be selected together within a CPQ bundle.

**Key Learning:**

* Configured relationships between bundle options.
* Understood dependent and incompatible option relationships.
* Used constraints to prevent invalid product combinations.
* Learned how constraints guide users toward valid bundle configurations.

---

## 3. Twin Fields

**Summary:**
Learned how Twin Fields are used in Salesforce CPQ to transfer values between matching custom fields on related CPQ objects.

**Key Learning:**

* Understood the concept of matching fields between CPQ objects.
* Learned how field values can be carried from one CPQ record to another.
* Understood how Twin Fields can support Product Rules, Price Rules, and CPQ automation.
* Learned the importance of matching field API names and compatible field types.

---

## 4. Multi-Dimensional Quoting (MDQ)

**Summary:**
Learned how MDQ allows a subscription to be divided into multiple time-based segments, with different quantities, prices, discounts, or other values for each segment.

**Key Learning:**

* Understood the concept of subscription segments.
* Learned how quantity can change across different subscription periods.
* Learned how pricing can vary by segment.
* Understood practical use cases such as ramp-up and ramp-down subscriptions.

**Example:**

A 3-year Printer Maintenance Service subscription can have:

* Year 1 → 2 printers
* Year 2 → 3 printers
* Year 3 → 5 printers

MDQ allows each year to be configured independently.

---
**Updated Date:** october 1 , 2026
## 5. Guided Selling

**Summary:**
Guided Selling helps users select the right products by asking predefined questions. It uses **Quote Processes, Process Inputs, Product Fields, and Conditions** to filter products.

**Example:**
Mapping **Service Type** and **Hardware Type** to relevant products.

**Key Learning:**

* Understood the Guided Selling process.
* Learned how predefined questions guide product selection.
* Learned how Process Inputs and Conditions can filter products.
* Understood how Guided Selling improves the product selection experience.

---

## 6. Custom Action in QLE

**Summary:**
A Custom Action adds a customized button or operation in the **Quote Line Editor (QLE)**. It can perform specific business logic on quote lines.

**Example:**
A **Reset Discount** button that resets discounts on selected quote lines.

**Key Learning:**

* Understood the purpose of Custom Actions.
* Learned how Custom Actions can be added to the QLE.
* Understood how actions can perform specific business operations.
* Learned a practical use case for resetting quote line discounts.

---

## 7. Salesforce CPQ Subscription Amendment

**Summary:**
Subscription Amendment allows users to modify an existing subscription contract. It creates an **Amendment Opportunity** linked to the existing contract.

**Key Learning:**

* Understood the Subscription Amendment process.
* Learned how an existing subscription can be modified.
* Understood the relationship between the Contract and Amendment Opportunity.
* Learned how amended subscription products are managed during the amendment process.

---

## 8. `SBQQ__AmendedContract__c` Permission Error

**Issue:**
During the Subscription Amendment process, I troubleshot the **`SBQQ__AmendedContract__c` permission error**.

**Why This Error Occurs:**

* The CPQ Amendment process requires access to the **Amended Contract** field.
* If the user's Profile or Permission Set does not provide the required field access, CPQ can throw a permission error.
* The field-level permissions should be verified for the relevant Contract object.

**Resolution:**

Navigate to:

**Setup → Object Manager → Contract → Fields & Relationships → `SBQQ__AmendedContract__c` → Field-Level Security**

Then provide the required **Read/Edit** access through the appropriate **Permission Set or Profile**, based on the user's CPQ requirements.

---

## Key CPQ Topics Covered

* Percent of Total (POT)
* Option Constraints
* Twin Fields
* Multi-Dimensional Quoting (MDQ)
* Guided Selling
* Quote Processes
* Process Inputs
* Product Fields
* Conditions
* Custom Actions
* Quote Line Editor (QLE)
* Subscription Amendment
* Amendment Opportunity
* Field-Level Security (FLS)
* `SBQQ__AmendedContract__c` troubleshooting
